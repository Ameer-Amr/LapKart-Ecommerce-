from django.shortcuts import redirect, render
from django.http import  JsonResponse
from store.models import Product
from .models import Order, OrderProduct, Payment
from accounts.models import Address
from cart.models import CartItem
from .forms import OrderForm
import datetime
import json
import razorpay
from django.conf import settings
from django.views.decorators.csrf import csrf_exempt
from django.http import HttpResponseBadRequest
from django.contrib import messages
# Create your views here.




# authorize razorpay client with API Keys.
razorpay_client = razorpay.Client(
    auth=(settings.RAZOR_KEY_ID, settings.RAZOR_KEY_SECRET))


def place_order(request,total = 0,quantity = 0):
    current_user = request.user 

    #if the cart count is less than or equels to 0
    cart_items = CartItem.objects.filter(user=current_user)
    cart_count = cart_items.count()
    if cart_count <= 0:
        return redirect('store')

    
    grand_total = 0
    tax = 0
    in_dollar = 0
    offer_price = 0
    for  cart_item in cart_items:
            if cart_item.product.Offer_Price():
                offer_price=Product.Offer_Price(cart_item.product)
                print(offer_price['new_price'])
                total = total+(offer_price['new_price'] * cart_item.quantity)   
                print(total) 
            else:
                total = total+(cart_item.product.price * cart_item.quantity)
    tax = (2 * total)/100
    grand_total = total + tax
    if 'discount_price' in request.session:
        grand_total = request.session['discount_price']
        print(grand_total)
    in_dollar = round(grand_total/70) 
    discount = int(offer_price['discount'])
    amount_pay = request.session['amount_pay']
   

    if request.method == 'POST':
        form = OrderForm(request.POST)
        if form.is_valid():
            #store all the billing information inside the table
            data = Order()
            data.user = current_user
            data.first_name = form.cleaned_data['first_name']
            data.last_name = form.cleaned_data['last_name']
            data.phone_number = form.cleaned_data['phone_number']
            data.email = form.cleaned_data['email']
            data.address_line_1 = form.cleaned_data['address_line_1']
            data.address_line_2 = form.cleaned_data['address_line_2']
            data.country = form.cleaned_data['country']
            data.state = form.cleaned_data['state']
            data.city = form.cleaned_data['city']
            data.pincode = form.cleaned_data['pincode']
            data.order_note = form.cleaned_data['order_note']
            data.order_total = grand_total
            data.tax = tax
            data.ip = request.META.get('REMOTE_ADDR')
            data.save()
            
            # generate order number
            yr = int(datetime.date.today().strftime('%Y'))
            dt = int(datetime.date.today().strftime('%d'))
            mt = int(datetime.date.today().strftime('%m'))
            d = datetime.date(yr,mt,dt)
            current_date = d.strftime("%Y%m%d") #20210305 like this
            order_number = current_date + str(data.id)
            data.order_number = order_number
            data.save()
            
            currency = 'INR'
            amount = grand_total*100
            request.session['razorpay_amount']=amount
            razorpay_order = razorpay_client.order.create(dict(amount=amount, currency=currency, payment_capture='0'))
            print(razorpay_order)

            # order id of newly created order.
            razorpay_order_id = razorpay_order['id']
            callback_url = 'paymenthandler/'

            payment_type = request.POST['payment']
            print(payment_type)
            order = Order.objects.get(user=current_user,is_ordered=False,order_number=order_number)
            addresses = Address.objects.filter(user=request.user)
            context = {
                'order':order,
                'cart_items':cart_items,
                'total':total,
                'tax':tax,
                'discount':discount,
                'grand_total':grand_total,
                'in_dollar' : in_dollar,
                'addresses':addresses,
                'razorpay_order_id':razorpay_order_id,
                'razorpay_merchant_key': settings.RAZOR_KEY_ID,
                'razorpay_amount':amount,
                'currency':currency,
                'callback_url':callback_url,
                'amount_pay':amount_pay,
                'payment_type':payment_type
            }

            return render(request,'user/payments.html',context)
    else:
        return redirect('checkout')


@csrf_exempt
def paymenthandler(request,total = 0,quantity = 0):
    # only accept POST request.
    if request.method == "POST":
        try:
            # get the required parameters from post request.
            payment_id = request.POST.get('razorpay_payment_id', '')
            razorpay_order_id = request.POST.get('razorpay_order_id', '')
            signature = request.POST.get('razorpay_signature', '')
            params_dict = {
                'razorpay_order_id': razorpay_order_id,
                'razorpay_payment_id': payment_id,
                'razorpay_signature': signature
            }
 
            # verify the payment signature.
            result = razorpay_client.utility.verify_payment_signature(params_dict)
            if result is None:
                amount =  request.session['razorpay_amount']
                try:
                    # capture the payemt
                    razorpay_client.payment.capture(payment_id, amount)
                    # render success page on successful caputre of payment
                    messages.success(request,"success")
                    return render(request,'user/paymentsuccess.html')
                except:
                    # if there is an error while capturing payment.
                    messages.error(request,"failed")
                    return render(request,'user/paymentfail.html')
            else:
                # if signature verification fails.
                messages.error(request,"failed")
                return render(request,'user/paymentfail.html')
        except:
 
            # if we don't find the required parameters in POST data
            return HttpResponseBadRequest()
    else:
       # if other than POST request is made.
        return HttpResponseBadRequest()


def payments(request):
    body = json.loads(request.body)
    order = Order.objects.get(user=request.user, is_ordered=False, order_number=body['orderID'])

    # Store transaction details inside Payment model
    payment = Payment(
        user = request.user,
        payment_id = body['transID'],
        payment_method = body['payment_method'],
        amount_paid = order.order_total,
        status = body['status'],
    )
    payment.save()

    order.payment = payment
    order.is_ordered = True
    order.save()

    # move the cart item to order product table
    cart_items = CartItem.objects.filter(user=request.user)

    for item in cart_items:
        orderproduct = OrderProduct()
        orderproduct.order_id = order.id
        orderproduct.payment = payment
        orderproduct.user_id = request.user.id
        orderproduct.product_id =item.product_id
        orderproduct.quantity = item.quantity
        if item.product.Offer_Price():
            offer_price = Product.Offer_Price(item.product)
            price = offer_price['new_price']
            orderproduct.product_price = price
        else:
            orderproduct.product_price = item.product.price
        orderproduct.ordered = True
        orderproduct.save()


        cart_item = CartItem.objects.get(id = item.id)
        product_variation = cart_item.variations.all()
        orderproduct = OrderProduct.objects.get(id=orderproduct.id)
        orderproduct.variations.set(product_variation)
        orderproduct.save()


        # reduce the quantity of sold products
        product = Product.objects.get(id=item.product_id)
        product.stock = product.stock - item.quantity
        product.save()

    # Clear the cart
    CartItem.objects.filter(user=request.user).delete()

    # sent order number and transaction id back to sentData method via Json Response
    data = {
        'order_number' : order.order_number,
        'transID' : payment.payment_id,

    }

    return JsonResponse(data)
    






def order_complete(request):
    order_number = request.GET.get('order_number')
    transID = request.GET.get('payment_id')

    try:
        order = Order.objects.get(order_number=order_number, is_ordered=True)
        ordered_products = OrderProduct.objects.filter(order_id=order.id)

        subtotal = 0
        for i in ordered_products:
            subtotal += i.product_price * i.quantity

        payment = Payment.objects.get(payment_id=transID)

        context = {
            'order': order,
            'ordered_products': ordered_products,
            'order_number': order.order_number,
            'transID': payment.payment_id,
            'payment': payment,
            'subtotal': subtotal,
        }
        return render(request, 'user/order_complete.html', context)
    except (Payment.DoesNotExist, Order.DoesNotExist):
        return redirect('Homepage')
