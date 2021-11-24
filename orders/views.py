from django.shortcuts import redirect, render
from .models import Order, Payment
from cart.models import CartItem
from .forms import OrderForm
import datetime
import json
# Create your views here.


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
    for  cart_item in cart_items:
        total = total + (cart_item.product.price * cart_item.quantity)
        quantity = quantity + cart_item.quantity
    tax = (2 * total)/100
    grand_total = total + tax
    in_dollar = round(grand_total/70) 

    if request.method == 'POST':
        form = OrderForm(request.POST)
        if form.is_valid():
            #store all the billing information inside the table
            data = Order()
            data.user = current_user
            data.first_name = form.cleaned_data['first_name']
            data.last_name = form.cleaned_data['last_name']
            data.phone = form.cleaned_data['phone']
            data.email = form.cleaned_data['email']
            data.address_line_1 = form.cleaned_data['address_line_1']
            data.address_line_2 = form.cleaned_data['address_line_2']
            data.country = form.cleaned_data['country']
            data.state = form.cleaned_data['state']
            data.city = form.cleaned_data['city']
            data.pin = form.cleaned_data['pin']
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

            order = Order.objects.get(user=current_user,is_ordered=False,order_number=order_number)
            context = {
                'order':order,
                'cart_items':cart_items,
                'total':total,
                'tax':tax,
                'grand_total':grand_total,
                'in_dollar' : in_dollar,
            }

            return render(request,'user/payments.html',context)
    else:
        return redirect('checkout')



def payments(request):

    body = json.loads(request.body)
    order = Order.objects.get(user=request.user,is_ordered = False,order_number = body['orderID'] )

    # store transaction details inside payment model
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
    return render(request,'user/payments.html')