
from django.shortcuts import get_object_or_404, redirect, render
from django.contrib import messages, auth
from cart.models import Cart, CartItem
from django.http import  JsonResponse
from accounts.otp import checkOTP, sentOTP
from .models import Account, UserProfile,Address
from .forms import RegistrationForm,AddressForm,UserProfileForm,UserForm
from django.contrib.auth.decorators import login_required
from cart.models import Cart, CartItem
from cart.views import _cart_id
import requests
from orders.models import Order, OrderProduct
from store.models import Product
# Create your views here.


def userlogin(request):
    if request.method == 'POST':
        email = request.POST['email']
        password = request.POST['password']

        user = auth.authenticate(email=email, password=password)

        if user is not None:
            try:
                cart = Cart.objects.get(cart_id = _cart_id(request))
                is_cart_item_exists = CartItem.objects.filter(cart=cart).exists()
                if is_cart_item_exists:
                    cart_item = CartItem.objects.filter(cart=cart)

                    #getting the product variations by cart id
                    product_variation = []
                    for item in cart_item:
                        variation = item.variations.all()
                        product_variation.append(list(variation))


                    #get the cart items from the user to access his product variation
                    cart_item = CartItem.objects.filter(user=user)
                    ex_var_list = []
                    id = []

                    for item in cart_item:
                        existing_variations = item.variations.all()
                        ex_var_list.append(list(existing_variations))
                        id.append(item.id)

                    # product_variation = [1,2,3,4]
                    # ex_var_list = [4,6,3,5]

                    for pr in product_variation:
                        if pr in ex_var_list:
                            index = ex_var_list.index(pr)
                            item_id = id[index]
                            item = CartItem.objects.get(id = item_id)
                            item.quantity = item.quantity + 1
                            item.user = user
                            item.save()
                        else:
                            cart_item = CartItem.objects.filter(cart=cart)
                            for item in cart_item:
                                item.user = user
                                item.save()   
            except:
                pass
            auth.login(request, user)
            messages.success(request,'Authenticated Successfully.')
            url = request.META.get('HTTP_REFERER')
            try:
                query = requests.utils.urlparse(url).query # eg: next=/cart/checkout/
                params = dict(x.split('=') for x in query.split('&'))  #it splits the equel sign in to key and other things are value  eg:--  {'next':'cart/checkout/'}
                if 'next' in params:
                    nextPage = params['next']
                    return redirect(nextPage)
            except:
                return redirect('Homepage')
        else:
            messages.error(request, 'invalid credentials')
            return redirect('userlogin')
    return render(request, 'user/userlogin.html')

def usersignup(request):
    global phone_number, user
    if request.user.is_authenticated:
        return redirect('Homepage')
    form = RegistrationForm()
    if request.method == 'POST':
        form = RegistrationForm(request.POST)
        if form.is_valid():
            # to fetch the data from request
            first_name = form.cleaned_data['first_name']
            last_name = form.cleaned_data['last_name']
            email = form.cleaned_data['email']
            phone_number = form.cleaned_data['phone_number']
            password = form.cleaned_data['password']
            username = email.split('@')[0]

            user = Account.objects.create_user(
                first_name=first_name, last_name=last_name, email=email, password=password, username=username,)
            sentOTP(phone_number)
            return redirect('confirm_signup')

    context = {
        'form': form,
    }

    return render(request, 'user/usersignup.html', context)


def confirm_signup(request):
   
    if request.user.is_authenticated:
        return redirect('Homepage')
    if request.method == 'POST':
        otp = request.POST['otpcode']
        print(otp)
        if checkOTP(phone_number, otp):
            user.phone_number = phone_number
            user.save()

            # Create a user profile
            profile = UserProfile()
            profile.user_id = user.id
            profile.profile_picture = 'default/default-image.png'
            profile.save()
            messages.success(request, 'Registered successfully')
            return redirect('userlogin')
        else:
            print('OTP not matching')
            return redirect('confirm_signup')
    return render(request, 'user/confirm_signup.html')


@login_required(login_url='userlogin')
def userlogout(request):
    auth.logout(request)
    messages.success(request, 'You are logged out')
    return redirect('userlogin')


def signinotp(request):
    if request.method == 'POST':
        mobile = request.POST['phone']
        try:
            if Account.objects.get(phone_number=mobile):
                sentOTP(mobile)
                request.session['checkmobile'] = mobile
                return redirect('otpcheck')
        except:
            messages.info(request, 'User not registered')
            return redirect('signinotp')
    return render(request, 'user/signinotp.html')


def otpcheck(request):
    if request.method == 'POST':
        otp = request.POST['otpcode']
        mobile = request.session['checkmobile']
        a = checkOTP(mobile, otp)
        if a:
            user = Account.objects.get(phone_number=mobile)
            auth.login(request, user)
            messages.info(request,'Autheticated Successfully')
            return redirect('Homepage')

        else:
            messages.info(request, 'OTP not Valid')
            return redirect('otpcheck')

    return render(request, 'user/otpcheck.html')

def resent_otp(request):
     mobile = request.session['checkmobile']
     sentOTP(mobile)
     return redirect('otpcheck')    


@login_required(login_url='userlogin')
def userdashboard(request):
    orders = Order.objects.order_by('-created_at').filter(user_id=request.user.id,is_ordered=True)
    orders_count = orders.count()

    userprofile = UserProfile.objects.get(user_id=request.user.id)
    context = {
        'orders_count':orders_count,
        'userprofile':userprofile,  
    }
    return render(request,'user/userdashboard.html',context)


@login_required(login_url='userlogin')
def my_orders(request):
    orders = OrderProduct.objects.filter(user=request.user,ordered=True).order_by('-created_at')
    context = {
        'orders':orders
    }
    return render(request,'user/my_orders.html',context)



@login_required(login_url='userlogin')
def cancel_order(request,pk):
    product = OrderProduct.objects.get(pk=pk)
    product.status = 'Canceled'
    product.save()
    item = Product.objects.get(pk=product.product.id)
    item.stock += product.quantity
    item.save()
    return redirect('my_orders')




@login_required(login_url='userlogin')
def edit_profile(request):
    userprofile = get_object_or_404(UserProfile, user=request.user)
    print(userprofile)
    if request.method == 'POST':
        user_form = UserForm(request.POST, instance=request.user)
        profile_form = UserProfileForm(request.POST, request.FILES, instance=userprofile)
        if user_form.is_valid() and profile_form.is_valid():
            user_form.save()
            profile_form.save()
            messages.success(request, 'Your profile has been updated.')
            return redirect('edit_profile')
    else:
        user_form = UserForm(instance=request.user)
        profile_form = UserProfileForm(instance=userprofile)
    context = {
        'user_form': user_form,
        'profile_form': profile_form,
        'userprofile': userprofile,
    }
    return render(request, 'user/edit_profile.html', context)


@login_required(login_url='userlogin')
def change_password(request):
    if request.method == 'POST':
        current_password = request.POST['current_password']
        new_password = request.POST['new_password']
        confirm_password = request.POST['confirm_password']

        user = Account.objects.get(username__exact=request.user.username)

        if new_password == confirm_password:
            success = user.check_password(current_password)
            if success:
                user.set_password(new_password)
                user.save()
                #auth.logout(request)
                messages.success(request,'Password Updated Successfully.')
                return redirect('change_password')
            else:
                messages.error(request,'Your Existing Password Is Incorrect')
                return redirect('change_password')
        else:
            messages.info(request,'Password Does Not Match!')        
            return redirect('change_password')

    return render(request,'user/change_password.html')


@login_required(login_url='userlogin')
def order_detail(request,order_id):
    order_detail = OrderProduct.objects.filter(order__order_number=order_id) #with the '__' we can access foreign key objects
    order = Order.objects.get(order_number=order_id)
    subtotal = 0

    for i in order_detail:
        subtotal = subtotal + i.product_price * i.quantity

    context = {
        'order_detail':order_detail,
        'order':order,
        'subtotal':subtotal
    }

    return render(request,'user/order_detail.html',context)


# @login_required(login_url='userlogin')
# def cancel_order(request):
#     id = request.POST['id']
#     cancelled_product = OrderProduct.objects.get(id=id)
#     Product.objects.filter(id=cancelled_product.product.id).update(stock=cancelled_product.product.stock + cancelled_product.quantity)
#     OrderProduct.objects.filter(id=id).update(status='Cancelled')
#     return JsonResponse({'success': True})




@login_required(login_url='userlogin')
def add_address(request):
    form = AddressForm()
    addresses = Address.objects.filter(user=request.user)

    if request.method == 'POST':
        form = AddressForm(request.POST)
        if form.is_valid():
            instance = form.save(commit=False)
            instance.user = request.user
            instance.save()
            messages.success(request, 'Successfully new address added')
            return redirect('add_address')

    context = {
        'form': form,
        'addresses': addresses
    }
    return render(request, 'user/add_address.html', context)



@login_required
def edit_address(request, pk):
    address = Address.objects.get(pk=pk)
    form = AddressForm(instance=address)

    if request.method == 'POST':
        form = AddressForm(request.POST, instance=address)

        if form.is_valid():
            form.save()
            messages.success(request, 'Your address is updated')
            return redirect('add_address')

    context = {
        'form': form
    }
    return render(request, 'user/edit-address.html', context)


@login_required
def delete_address(request,pk):
    dlt =  Address.objects.filter(id=pk)
    print(dlt)
    dlt.delete()
    messages.success(request,'Your Address Has been deleted')
    return redirect('add_address') 




@login_required
def set_default_address(request, pk):
    Address.objects.filter(user=request.user, default=True).update(default=False)
    address = Address.objects.get(pk=pk)
    address.default = True
    address.save()
    messages.success(request, 'Default address changed')
    return redirect('add_address')