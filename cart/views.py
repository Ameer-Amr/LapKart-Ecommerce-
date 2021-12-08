
from django.core.exceptions import ObjectDoesNotExist
from django.shortcuts import get_object_or_404, redirect, render
from cart.models import Cart, CartItem
from django.contrib.auth.decorators import login_required
from store.models import Product, Variation
from accounts.models import Address
from datetime import date
from coupon.models import Coupon, ReviewCoupon
from django.views.decorators.cache import never_cache
from django.http.response import  JsonResponse
import math
# Create your views here.


#for bringing cart id from session
def _cart_id(request):
    cart = request.session.session_key
    if not cart:
        cart = request.session.create()
    return cart

#for incrementing item quantity
def add_cart(request,product_id):

    current_user = request.user
    product = Product.objects.get(id=product_id) #for get the product
    #if user is authenticated
    if current_user.is_authenticated:
        product_variation = []  
        if request.method == 'POST':
            for item in request.POST:   #for check the varients
                key = item
                # value = request.POST[key]
                color=request.POST['color']
                print(color)
                
                try:
                    variation = Variation.objects.get(product = product , variation_category__iexact = key , color_name__iexact = color )
                    product_variation.append(variation)
                except:
                    pass    
 
        is_cart_item_exists = CartItem.objects.filter(product=product,user=current_user).exists()
        if is_cart_item_exists:
            cart_item = CartItem.objects.filter(product=product,user=current_user)
            #existing variations - database
            #current variation -product_variation
            #item id - database
            ex_var_list = []
            id = []

            for item in cart_item:
                existing_variations = item.variations.all()
                ex_var_list.append(list(existing_variations))
                id.append(item.id)

            if product_variation in ex_var_list:
                #increase the cart item quantity
                index = ex_var_list.index(product_variation)
                item_id = id[index]
                item = CartItem.objects.get(product=product,id=item_id)
                item.quantity = item.quantity + 1
                item.save()
            else:
                #create a new cart item
                item = CartItem.objects.create(product=product,quantity=1,user=current_user)
                if len(product_variation) > 0:
                    item.variations.clear()
                    item.variations.add(*product_variation)
                    item.save()

        else:
            cart_item =CartItem.objects.create(
                product = product,
                quantity = 1,
                user = current_user,
            )
            if len(product_variation) > 0:
                cart_item.variations.clear()
                cart_item.variations.add(*product_variation)
                cart_item.save()

        return redirect('cart')

    #if user is not authenticated
    else:     
        product_variation = []  
        if request.method == 'POST':
            for item in request.POST:   #for check the varients
                key = item
                # value = request.POST[key]
                color=request.POST['color']
                try:
                    variation = Variation.objects.get(product=product, variation_category__iexact=key, color_name__iexact= color)
                    product_variation.append(variation)
                except:
                    pass    
            
    
        try:
            cart = Cart.objects.get(cart_id = _cart_id(request))
        except Cart.DoesNotExist:
            cart = Cart.objects.create(cart_id = _cart_id(request))
            cart.save()


        is_cart_item_exists = CartItem.objects.filter(product=product,cart=cart).exists(  )
        if is_cart_item_exists:
            cart_item = CartItem.objects.filter(product=product,cart=cart)

            #existing variations - database
            #current variation -product_variation
            #item id - database
            ex_var_list = []
            id = []

            for item in cart_item:
                existing_variations = item.variations.all()
                ex_var_list.append(list(existing_variations))
                id.append(item.id)

            if product_variation in ex_var_list:
                #increase the cart item quantity
                index = ex_var_list.index(product_variation)
                item_id = id[index]
                item = CartItem.objects.get(product=product,id=item_id)
                item.quantity = item.quantity + 1
                item.save()
            else:
                #create a new cart item
                item = CartItem.objects.create(product=product,quantity=1,cart=cart)
                if len(product_variation) > 0:
                    item.variations.clear()
                    item.variations.add(*product_variation)
                    item.save()

        else:
            cart_item =CartItem.objects.create(
                product = product,
                quantity = 1,
                cart = cart,
            )
            if len(product_variation) > 0:
                cart_item.variations.clear()
                cart_item.variations.add(*product_variation)
                cart_item.save()

        return redirect('cart')

#for decrementing item quantity
def remove_cart(request,product_id,cart_item_id):
    product = get_object_or_404(Product,id=product_id)
    try:
        if request.user.is_authenticated:
            cart_item = CartItem.objects.get(product=product,user=request.user,id=cart_item_id)
        else:
            cart = Cart.objects.get(cart_id=_cart_id(request))
            cart_item = CartItem.objects.get(product=product,cart=cart,id=cart_item_id)
        if cart_item.quantity > 1:
            cart_item.quantity = cart_item.quantity - 1
            cart_item.save()
        else:
            cart_item.delete()
    except:
        pass
    return redirect('cart')



def remove_cart_item(request,product_id,cart_item_id):
  
    product = get_object_or_404(Product,id=product_id)
    if request.user.is_authenticated:
        cart_item = CartItem.objects.get(product=product,user=request.user,id=cart_item_id)
    else:
        cart = Cart.objects.get(cart_id=_cart_id(request))
        cart_item = CartItem.objects.get(product=product,cart=cart,id=cart_item_id)
    cart_item.delete()
    return redirect('cart')




def cart(request,total=0,quantity=0,cart_items=None):

    tax = 0
    grand_total = 0
    try:

        if 'buy_now' in request.session:
            del request.session['buy_now']


        if request.user.is_authenticated:
            cart_items = CartItem.objects.filter(user=request.user , is_active=True)
        else:
            cart = Cart.objects.get(cart_id=_cart_id(request))
            cart_items = CartItem.objects.filter(cart=cart , is_active=True)
        for cart_item in cart_items:
            if cart_item.product.Offer_Price():
                offer_price=Product.Offer_Price(cart_item.product)
                print(offer_price['new_price'])
                total = total+(offer_price['new_price'] * cart_item.quantity)
                print(total) 
            else:
                total = total+(cart_item.product.price * cart_item.quantity)
             
            quantity = quantity + cart_item.quantity
        tax = (2 * total)/100
        grand_total = total + tax
    except ObjectDoesNotExist:
        pass #just ignore

    context = {
        'total':total,
        'quantity':quantity,
        'cart_items':cart_items,
        'tax':tax,
        'grand_total':grand_total
    }
    return render(request,'user/cart.html',context)

@login_required(login_url='userlogin')
def checkout(request,total=0,quantity=0,cart_items=None):

        tax = 0
        grand_total = 0
        try:
            if request.user.is_authenticated:
                if 'buy_now' in request.session:
                    product_id=request.session['buy_now']
                    item=Product.objects.get(id=product_id)
                    addresses = Address.objects.filter(user=request.user)
                else:
                    item=False
                    cart_items = CartItem.objects.filter(user=request.user , is_active=True)
                    addresses = Address.objects.filter(user=request.user)
            else:
                cart = Cart.objects.get(cart_id=_cart_id(request))
                cart_items = CartItem.objects.filter(cart=cart , is_active=True)


            if 'buy_now' in request.session:
                product_id=request.session['buy_now']
                item=Product.objects.get(id=product_id)
                if item.Offer_Price():
                    offer_price=Product.Offer_Price(item)
                    print(offer_price['new_price'])
                    total = total+(offer_price['new_price'] * 1)   
                    print(total) 
                else:
                    total =(item.price * 1)
                quantity = 1
                tax = (2 * total)/100
                grand_total = total+tax
  
            else:
                for cart_item in cart_items:
                    if cart_item.product.Offer_Price():
                        offer_price=Product.Offer_Price(cart_item.product)
                        print(offer_price['new_price'])
                        total = total+(offer_price['new_price'] * cart_item.quantity)   
                        print(total) 
                    else:
                        total = total+(cart_item.product.price * cart_item.quantity)
                tax = (2 * total)/100
                grand_total = total+tax
            if 'discount_price' in request.session:
                grand_total = request.session['discount_price']
        except ObjectDoesNotExist:
            pass #just ignore

        context = {
        'total':total,
        'quantity':quantity,
        'cart_items':cart_items,
        'tax':tax,
        'grand_total':grand_total,
        'addresses':addresses,
        'item':item,
        
        
        }
        return render(request,'user/checkout.html',context)


@never_cache
@login_required(login_url='userlogin')
def Check_coupon(request):

    if 'coupon_code' in request.session:
        del request.session['coupon_code']
        del request.session['amount_pay']
        del request.session['discount_price']

    flag = 0
    discount_price = 0
    amount_pay = 0
    coupon_code = request.POST.get('coupon_code')
    grand_total = float(request.POST.get('grand_total'))

    if Coupon.objects.filter(code=coupon_code,coupon_limit__gte=1).exists():
        coupon = Coupon.objects.get(code=coupon_code)
        print(coupon)
        if coupon.active == True:
            flag = 1    
            if not ReviewCoupon.objects.filter(user=request.user, coupon = coupon):
                today = date.today()
                
                if coupon.valid_from <= today and coupon.valid_to >= today:
                    discount_price = grand_total - coupon.discount

                    print(discount_price)
                    amount_pay = grand_total-discount_price
                    print(amount_pay)
                    flag = 2
                    request.session['amount_pay'] = amount_pay
                    request.session['coupon_code'] = coupon_code
                    request.session['discount_price'] = discount_price

                    print('asfghjsftsfT333333')     
                
    context = {
        'amount_pay': amount_pay,
        'flag': flag,
        'discount_price': discount_price,
        'coupon_code':coupon_code
    }   
 
    return JsonResponse(context)