from django.shortcuts import redirect, render
from django.http import JsonResponse
from coupon.models import Coupon, ReviewCoupon
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
from django.urls import reverse

# Create your views here.


# authorize razorpay client with API Keys.
razorpay_client = razorpay.Client(
    auth=(settings.RAZOR_KEY_ID, settings.RAZOR_KEY_SECRET)
)


def place_order(request, total=0, quantity=0):
    current_user = request.user

    # if the cart count is less than or equels to 0
    cart_items = CartItem.objects.filter(user=current_user)
    cart_count = cart_items.count()

    if not "buy_now" in request.session:
        if cart_count <= 0:
            return redirect("store")

    grand_total = 0
    tax = 0
    in_dollar = 0
    offer_price = 0
    amount_pay = 0
    discount = 0
    if "buy_now" in request.session:
        product_id = request.session["buy_now"]
        item = Product.objects.get(id=product_id)
        if item.Offer_Price():
            offer_price = Product.Offer_Price(item)
            print(offer_price["new_price"])
            total = total + (offer_price["new_price"] * 1)
            print(total)
        else:
            total = item.price * 1
        quantity = 1

    else:
        item = False
        for cart_item in cart_items:
            if cart_item.product.Offer_Price():
                offer_price = Product.Offer_Price(cart_item.product)
                print(offer_price["new_price"])
                total = total + (
                    offer_price["new_price"] * cart_item.quantity
                )
                print(total)
            else:
                total = total + (cart_item.product.price * cart_item.quantity)
    tax = (2 * total) / 100
    grand_total = total + tax
    in_dollar = round(grand_total / 70)

    if "discount_price" in request.session:
        grand_total = request.session["discount_price"]
        discount = int(offer_price["discount"])
        print(grand_total)

    if "amount_pay" in request.session:
        amount_pay = request.session["amount_pay"]

    if request.method == "POST":
        form = OrderForm(request.POST)
        if form.is_valid():
            # store all the billing information inside the table
            data = Order()
            print(data)
            data.user = current_user
            print(data.user)
            data.first_name = form.cleaned_data["first_name"]
            data.last_name = form.cleaned_data["last_name"]
            data.phone_number = form.cleaned_data["phone_number"]
            data.email = form.cleaned_data["email"]
            data.address_line_1 = form.cleaned_data["address_line_1"]
            data.address_line_2 = form.cleaned_data["address_line_2"]
            data.country = form.cleaned_data["country"]
            data.state = form.cleaned_data["state"]
            data.city = form.cleaned_data["city"]
            data.pincode = form.cleaned_data["pincode"]
            data.order_note = form.cleaned_data["order_note"]
            data.order_total = grand_total
            data.tax = tax
            data.ip = request.META.get("REMOTE_ADDR")
            data.save()
            print(data.id, "ameer")

            # generate order number
            yr = int(datetime.date.today().strftime("%Y"))
            dt = int(datetime.date.today().strftime("%d"))
            mt = int(datetime.date.today().strftime("%m"))
            d = datetime.date(yr, mt, dt)
            current_date = d.strftime("%Y%m%d")  # 20210305 like this

            payment_type = request.POST["payment"]
            currency = "INR"
            amount = grand_total * 100
            request.session["razorpay_amount"] = amount
            razorpay_order = razorpay_client.order.create(
                dict(amount=amount, currency=currency, payment_capture="0")
            )

            if payment_type == "Razorpay":
                order_number = razorpay_order["id"]
                data.order_number = razorpay_order["id"]
                print("razor")
                data.save()
            else:
                order_number = current_date + str(data.id)
                print(data.id)
                data.order_number = order_number
                request.session["order_number"] = order_number
                print("cod/paypal")
                data.save()
            # order id of newly created order.
            razorpay_order_id = razorpay_order["id"]
            callback_url = "paymenthandler/"

            payment_type = request.POST["payment"]
            print(payment_type)
            order = Order.objects.get(
                user=current_user, is_ordered=False, order_number=order_number
            )
            addresses = Address.objects.filter(user=request.user)
            context = {
                "order": order,
                "cart_items": cart_items,
                "total": total,
                "tax": tax,
                "discount": discount,
                "grand_total": grand_total,
                "in_dollar": in_dollar,
                "addresses": addresses,
                "razorpay_order_id": razorpay_order_id,
                "razorpay_merchant_key": settings.RAZOR_KEY_ID,
                "razorpay_amount": amount,
                "currency": currency,
                "callback_url": callback_url,
                "amount_pay": amount_pay,
                "payment_type": payment_type,
                "item": item,
            }

            return render(request, "user/payments.html", context)
    else:
        return redirect("checkout")


@csrf_exempt
def paymenthandler(request, total=0, quantity=0):
    # only accept POST request.
    if request.method == "POST":
        try:
            # get the required parameters from post request.
            payment_id = request.POST.get("razorpay_payment_id", "")
            razorpay_order_id = request.POST.get("razorpay_order_id", "")
            signature = request.POST.get("razorpay_signature", "")
            params_dict = {
                "razorpay_order_id": razorpay_order_id,
                "razorpay_payment_id": payment_id,
                "razorpay_signature": signature,
            }

            print(payment_id, "razorpay_payment_id")
            print(razorpay_order_id)
            # verify the payment signature.
            result = razorpay_client.utility.verify_payment_signature(
                params_dict
            )
            if result is None:
                print("ameeeeeeeeerrrrrr")
                amount = request.session["razorpay_amount"]
                try:
                    # capture the payemt
                    razorpay_client.payment.capture(payment_id, amount)
                    # render success page on successful caputre of payment
                    current_user = request.user
                    order = Order.objects.get(
                        user=current_user,
                        is_ordered=False,
                        order_number=razorpay_order_id,
                    )
                    print(order)
                    print(order.id)

                    # save payment informations
                    payment = Payment(
                        user=current_user,
                        payment_id=payment_id,
                        payment_method="RazorPay",
                        amount_paid=order.order_total,
                        status="Completed",
                    )
                    payment.save()
                    order.user = current_user
                    order.payment = payment
                    order.is_ordered = True
                    order.save()

                    if "buy_now" in request.session:
                        product_id = request.session["buy_now"]
                        item = Product.objects.get(id=product_id)

                        orderproduct = OrderProduct()
                        orderproduct.order_id = order.id
                        orderproduct.payment = payment
                        orderproduct.user_id = request.user.id
                        orderproduct.product_id = item.id
                        orderproduct.quantity = 1
                        if item.Offer_Price():
                            offer_price = Product.Offer_Price(item)
                            price = offer_price["new_price"]
                            orderproduct.product_price = price
                        else:
                            orderproduct.product_price = item.product.price
                        orderproduct.ordered = True
                        orderproduct.save()

                        cart_item = CartItem.objects.get(id=item.id)
                        product_variation = cart_item.variations.all()
                        orderproduct = OrderProduct.objects.get(
                            id=orderproduct.id
                        )
                        orderproduct.variations.set(product_variation)
                        orderproduct.save()

                        # reduce the quantity of sold products
                        product = Product.objects.get(id=item.id)
                        product.stock = product.stock - 1
                        product.save()

                    else:

                        # move cart items to order product table
                        cart_items = CartItem.objects.filter(
                            user=current_user
                        )

                        for item in cart_items:
                            orderproduct = OrderProduct()
                            orderproduct.order_id = order.id
                            orderproduct.payment = payment
                            orderproduct.user_id = request.user.id
                            orderproduct.product_id = item.product_id
                            orderproduct.quantity = item.quantity
                            if item.product.Offer_Price():
                                offer_price = Product.Offer_Price(
                                    item.product
                                )
                                price = offer_price["new_price"]
                                orderproduct.product_price = price
                            else:
                                orderproduct.product_price = (
                                    item.product.price
                                )
                            orderproduct.ordered = True
                            orderproduct.save()

                            cart_item = CartItem.objects.get(id=item.id)
                            product_variation = cart_item.variations.all()
                            orderproduct = OrderProduct.objects.get(
                                id=orderproduct.id
                            )
                            orderproduct.variations.set(product_variation)
                            orderproduct.save()

                            # reduce the quantity of sold products
                            product = Product.objects.get(id=item.product_id)
                            product.stock = product.stock - item.quantity
                            product.save()

                            # clear the cart
                            CartItem.objects.filter(
                                user=request.user
                            ).delete()

                    # for review coupons and reduce count
                    check_coupon = redeemed_coupon(request)
                    print(check_coupon)

                    # send transaction successfull
                    param = (
                        "order_number="
                        + order.order_number
                        + "&payment_id="
                        + payment.payment_id
                    )
                    ################
                    # capture the payemt
                    messages.success(request, "Payment Success")
                    print("hello")

                    redirect_url = reverse("order_complete")
                    return redirect(f"{redirect_url}?{param}")
                    # render success page on successful caputre of payment
                except Exception as e:
                    print(e)
                    messages.error(request, "Payment Failed")
                    # if there is an error while capturing payment.
                    return redirect("checkout")
            else:

                return redirect("checkout")
                # if signature verification fails.

        except:
            return redirect("checkout")
            # if we don't find the required parameters in POST data
    else:
        # if other than POST request is made.
        return redirect("checkout")


def payments(request):
    body = json.loads(request.body)
    order = Order.objects.get(
        user=request.user, is_ordered=False, order_number=body["orderID"]
    )

    # Store transaction details inside Payment model
    payment = Payment(
        user=request.user,
        payment_id=body["transID"],
        payment_method=body["payment_method"],
        amount_paid=order.order_total,
        status=body["status"],
    )
    payment.save()

    order.payment = payment
    order.is_ordered = True
    order.save()

    if "buy_now" in request.session:
        product_id = request.session["buy_now"]
        item = Product.objects.get(id=product_id)

        orderproduct = OrderProduct()
        orderproduct.order_id = order.id
        orderproduct.payment = payment
        orderproduct.user_id = request.user.id
        orderproduct.product_id = item.id
        orderproduct.quantity = 1
        if item.Offer_Price():
            offer_price = Product.Offer_Price(item)
            price = offer_price["new_price"]
            orderproduct.product_price = price
        else:
            orderproduct.product_price = item.product.price
        orderproduct.ordered = True
        orderproduct.save()

        # cart_item = CartItem.objects.get(id=item.id)
        # product_variation = cart_item.variations.all()
        # orderproduct = OrderProduct.objects.get(id=orderproduct.id)
        # orderproduct.variations.set(product_variation)
        # orderproduct.save()

        # reduce the quantity of sold products
        product = Product.objects.get(id=item.id)
        product.stock = product.stock - 1
        product.save()

    else:
        # move the cart item to order product table
        cart_items = CartItem.objects.filter(user=request.user)
        for item in cart_items:
            orderproduct = OrderProduct()
            orderproduct.order_id = order.id
            orderproduct.payment = payment
            orderproduct.user_id = request.user.id
            orderproduct.product_id = item.product_id
            orderproduct.quantity = item.quantity
            if item.product.Offer_Price():
                offer_price = Product.Offer_Price(item.product)
                price = offer_price["new_price"]
                orderproduct.product_price = price
            else:
                orderproduct.product_price = item.product.price
            orderproduct.ordered = True
            orderproduct.save()

            cart_item = CartItem.objects.get(id=item.id)
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

    # for review coupons and reduce count
    check_coupon = redeemed_coupon(request)
    print(check_coupon)

    # sent order number and transaction id back to sentData method via Json Response
    data = {
        "order_number": order.order_number,
        "transID": payment.payment_id,
    }

    return JsonResponse(data)


def cod(request):
    current_user = request.user
    # generate order number
    order_number = request.session["order_number"]
    # move cart items to order product table
    cart_items = CartItem.objects.filter(user=current_user)
    order = Order.objects.get(
        user=current_user, is_ordered=False, order_number=order_number
    )
    print(order)

    # save payment informations
    payment = Payment(
        user=current_user,
        payment_id=order_number,
        payment_method="Cash On Delivery",
        amount_paid=order.order_total,
        status="Completed",
    )
    payment.save()
    order.payment = payment
    order.is_ordered = True
    order.save()

    if "buy_now" in request.session:
        product_id = request.session["buy_now"]
        item = Product.objects.get(id=product_id)

        orderproduct = OrderProduct()
        orderproduct.order_id = order.id
        orderproduct.payment = payment
        orderproduct.user_id = request.user.id
        orderproduct.product_id = product_id
        orderproduct.quantity = 1
        if item.Offer_Price():
            offer_price = Product.Offer_Price(item)
            price = offer_price["new_price"]
            orderproduct.product_price = price
        else:
            orderproduct.product_price = item.product.price
        orderproduct.ordered = True
        orderproduct.save()

        # cart_item = CartItem.objects.get(id=item.id)
        # product_variation = cart_item.variations.all()
        # orderproduct = OrderProduct.objects.get(id=orderproduct.id)
        # orderproduct.variations.set(product_variation)
        # orderproduct.save()

        # reduce the quantity of sold products
        product = Product.objects.get(id=item.id)
        product.stock = product.stock - 1
        product.save()
    else:
        for item in cart_items:
            orderproduct = OrderProduct()
            orderproduct.order_id = order.id
            orderproduct.payment = payment
            orderproduct.user_id = request.user.id
            orderproduct.product_id = item.product_id
            orderproduct.quantity = item.quantity
            if item.product.Offer_Price():
                offer_price = Product.Offer_Price(item.product)
                price = offer_price["new_price"]
                orderproduct.product_price = price
            else:
                orderproduct.product_price = item.product.price
            orderproduct.ordered = True
            orderproduct.save()

            cart_item = CartItem.objects.get(id=item.id)
            product_variation = cart_item.variations.all()
            orderproduct = OrderProduct.objects.get(id=orderproduct.id)
            orderproduct.variations.set(product_variation)
            orderproduct.save()

            # reduce the quantity of sold products
            product = Product.objects.get(id=item.product_id)
            product.stock = product.stock - item.quantity
            product.save()

            # clear the cart
            CartItem.objects.filter(user=request.user).delete()

    # for review coupons and reduce count
    check_coupon = redeemed_coupon(request)
    print(check_coupon)

    # send transaction successfull
    param = (
        "order_number="
        + order.order_number
        + "&payment_id="
        + payment.payment_id
    )
    ################
    # capture the payemt
    messages.success(request, "Payment Success")
    if "order_number" in request.session:
        del request.session["order_number"]

    redirect_url = reverse("order_complete")
    return redirect(f"{redirect_url}?{param}")


def order_complete(request):
    order_number = request.GET.get("order_number")
    transID = request.GET.get("payment_id")

    try:
        order = Order.objects.get(order_number=order_number, is_ordered=True)
        ordered_products = OrderProduct.objects.filter(order_id=order.id)

        subtotal = 0
        for i in ordered_products:
            subtotal += i.product_price * i.quantity

        payment = Payment.objects.get(payment_id=transID)

        context = {
            "order": order,
            "ordered_products": ordered_products,
            "order_number": order.order_number,
            "transID": payment.payment_id,
            "payment": payment,
            "subtotal": subtotal,
        }
        return render(request, "user/order_complete.html", context)
    except (Payment.DoesNotExist, Order.DoesNotExist):
        return redirect("Homepage")


def redeemed_coupon(request):
    if "amount_pay" in request.session:
        coupon_code = request.session["coupon_code"]
        current_user = request.user
        coupon = Coupon.objects.get(code=coupon_code)
        coupon.coupon_limit = coupon.coupon_limit - 1
        coupon.save()
        redeem = ReviewCoupon()
        redeem.user = current_user
        redeem.coupon = coupon
        redeem.save()

        del request.session["coupon_code"]
        del request.session["amount_pay"]
        del request.session["discount_price"]
        return True
    else:
        return False
