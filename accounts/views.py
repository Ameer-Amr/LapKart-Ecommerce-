
from django.shortcuts import redirect, render
from django.contrib import messages, auth
from cart.models import Cart, CartItem

from accounts.otp import checkOTP, sentOTP
from .models import Account
from .forms import RegistrationForm
from django.contrib.auth.decorators import login_required
from cart.models import Cart, CartItem
from cart.views import _cart_id
import requests
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
            messages.success(request,'you are logined')
            url = request.META.get('HTTP_REFERER')
            try:
                query = requests.utils.urlparse(url).query # eg: next=/cart/checkout/
                params = dict(x.split('=') for x in query.split('&'))  #it splits the equel sign in to key and other things are value  eg:--  {'next':'cart/checkout/'}
                if 'next' in params:
                    nextPage = params['next']
                    return redirect(nextPage)
            except:
                return redirect('userdashboard')
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
            messages.success(request, 'Registered successfully')
            return redirect('userlogin')
        else:
            print('OTP not matching')
            return redirect('confirm_signup')
    return render(request, 'user/confirm_signup.html')


@login_required(login_url='userlogin')
def userlogout(request):
    auth.logout(request)
    messages.success(request, 'you are logged out')
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
            # messages.info(request,'OTP Verified')
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
    return render(request,'user/userdashboard.html')
