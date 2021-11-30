from django.shortcuts import render, redirect
from django.contrib import messages, auth
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth.decorators import login_required

from offer.forms import BrandOfferForm, CategoryOfferForm, ProductOfferForm
from offer.models import BrandOffer, CategoryOffer, ProductOffer
from .forms import EditBrand, EditCategory, EditProduct, EditVarient
from store.models import Banners, Product, Variation
from store.forms import BannerForm, ProductForm, VarientForm
from accounts.models import Account
from category.models import category
from category.forms import CategoryForm
from brands.models import Brand
from brands.form import BrandForm
from django.http import JsonResponse
from orders.models import OrderProduct, STATUS1


# Create your views here.

@csrf_exempt
def adminlogin(request):
    if request.method == 'POST':
        email = request.POST['email']
        password = request.POST['password']
        user = auth.authenticate(
            email=email, password=password, is_superadmin=True)

        if user is not None:
            request.session['key'] = 'value'
            #  auth.login(request,user)
            messages.success(request, 'Admin Online')
            return redirect('dashboard')
        else:
            messages.error(request, 'You are not an admin')
            return redirect('adminlogin')
    # messages.error(request,'Invalid Entry')
    return render(request, 'admin/adminlogin.html')


def signout(request):
    if request.session.has_key('key'):
        del request.session['key']
        request.session.modified = True
    return redirect('adminlogin')


def dashboard(request):
    if request.session.has_key('key'):
        return render(request, 'admin/dashboard.html')
    else:
        return redirect('adminlogin')


def productlists(request):
    if request.session.has_key('key'):
        datas = Product.objects.all()
        print(datas)
        return render(request, 'admin/productlist.html', {'datas': datas, })
    else:
        return redirect('dashboard')


def varientlists(request):
    varients = Variation.objects.all()
    for e in varients:
        print(e.product)

    context = {
        'varients': varients,
    }
    return render(request, 'admin/product_variation.html', context)


def editvarient(request, varient_id):
    edtvarient = Variation.objects.get(pk=varient_id)
    form = EditVarient(instance=edtvarient)
    if request.method == 'POST':
        form = EditVarient(request.POST, instance=edtvarient)
        if form.is_valid():
            try:
                form.save()

            except:
                context = {'form': form}
                # messages.info(request,"A user with that email address already exists.")
                return render(request, 'admin/editvarient.html', context)
            return redirect('varientlists')

    context = {'form': form}
    return render(request, 'admin/editvarient.html', context)


def blockvarient(request, varient_id):
    varnt = Variation.objects.get(pk=varient_id)
    varnt.is_active = False
    varnt.save()
    return redirect('varientlists')


def unblockvarient(request, varient_id):
    varnt = Variation.objects.get(pk=varient_id)
    varnt.is_active = True
    varnt.save()
    return redirect('varientlists')


def deletevarient(request, varient_id):
    dlt = Variation.objects.get(pk=varient_id)
    dlt.delete()
    messages.success(request, 'Your Product Has been deleted')
    return redirect('varientlists')


def addproduct(request):

    form = ProductForm()

    if request.method == 'POST':
        form = ProductForm(request.POST, request.FILES)

        if form.is_valid():
            form.save()
            return redirect('productlists')

    context = {
        'form': form
    }
    return render(request, 'admin/productadd.html', context)


def addvarient(request):

    form = VarientForm()

    if request.method == 'POST':
        form = VarientForm(request.POST)

        if form.is_valid():
            form.save()
            return redirect('varientlists')

    context = {
        'form': form
    }
    return render(request, 'admin/add_varient.html', context)


def brandlists(request):
    brands = Brand.objects.all()
    return render(request, 'admin/brandlists.html', {'brands': brands})


def activeusers(request):
    users = Account.objects.order_by('id').filter(is_admin=False).all()
    return render(request, 'admin/activeusers.html', {'users': users})


def categorylists(request):
    Categories = category.objects.all()
    return render(request, 'admin/categorylist.html', {'Categories': Categories})


def addbrand(request):

    form = BrandForm()

    if request.method == 'POST':
        form = BrandForm(request.POST, request.FILES)

        if form.is_valid():
            form.save()
            return redirect('brandlists')

    context = {
        'form': form
    }
    return render(request, 'admin/addbrands.html', context)


def addcategory(request):

    form = CategoryForm()

    if request.method == 'POST':
        form = CategoryForm(request.POST, request.FILES)

        if form.is_valid():
            form.save()
            return redirect('categorylists')

    context = {
        'form': form
    }
    return render(request, 'admin/addcategory.html', context)


def deleteproduct(request, product_id):
    dlt = Product.objects.get(pk=product_id)
    dlt.delete()
    messages.success(request, 'Your Product Has been deleted')
    return redirect('productlists')


def editProduct(request, product_id):
    edtproduct = Product.objects.get(pk=product_id)
    form = EditProduct(instance=edtproduct)
    if request.method == 'POST':
        form = EditProduct(request.POST, request.FILES, instance=edtproduct)
        if form.is_valid():
            try:
                form.save()

            except:
                context = {'form': form}
                # messages.info(request,"A user with that email address already exists.")
                return render(request, 'admin/editproduct.html', context)
            return redirect('productlists')

    context = {'form': form}
    return render(request, 'admin/editproduct.html', context)


def editbrand(request, brand_id):
    edtbrand = Brand.objects.get(pk=brand_id)
    form = EditBrand(instance=edtbrand)
    if request.method == 'POST':
        form = EditBrand(request.POST, request.FILES, instance=edtbrand)
        if form.is_valid():
            try:
                form.save()

            except:
                context = {'form': form}
                # messages.info(request,"A user with that email address already exists.")
                return render(request, 'admin/editbrand.html', context)
            return redirect('brandlists')

    context = {'form': form}
    return render(request, 'admin/editbrand.html', context)


def deletebrand(request, brand_id):
    dlt = Brand.objects.get(pk=brand_id)
    dlt.delete()
    messages.success(request, 'Your Product Has been deleted')
    return redirect('brandlists')


def editcategory(request, category_id):
    edtcategory = category.objects.get(pk=category_id)
    form = EditCategory(instance=edtcategory)
    if request.method == 'POST':
        form = EditCategory(request.POST, request.FILES, instance=edtcategory)
        if form.is_valid():
            try:
                form.save()

            except:
                context = {'form': form}
                # messages.info(request,"A user with that email address already exists.")
                return render(request, 'admin/editcategory.html', context)
            return redirect('categorylists')

    context = {'form': form}
    return render(request, 'admin/editcategory.html', context)


def deletecategory(request, category_id):
    dlt = category.objects.get(pk=category_id)
    dlt.delete()
    messages.success(request, 'Your Product Has been deleted')
    return redirect('categorylists')


def blockuser(request, user_id):
    if request.user.is_authenticated:
        user = Account.objects.get(pk=user_id)
        user.is_active = False
        user.save()
        return redirect('activeusers')


def unblockuser(request, user_id):
    if request.user.is_authenticated:
        user = Account.objects.get(pk=user_id)
        user.is_active = True
        user.save()
        return redirect('activeusers')


def deleteuser(request, user_id):
    if request.user.is_authenticated:
        dlt = Account.objects.get(pk=user_id)
        dlt.delete()
        return redirect('activeusers')


def activeorders(request):
    exclude_list = ['Delivered', 'Canceled']
    active_orders = OrderProduct.objects.all().exclude(status__in=exclude_list)
    status = STATUS1
    context = {
        'active_orders': active_orders,
        'status': status,
    }
    return render(request, 'admin/active_orders.html', context)


def order_history(request):
    exclude_list = ['New', 'Accepted', 'Placed', 'Shipped', ]
    active_orders = OrderProduct.objects.all().exclude(status__in=exclude_list)
    status = STATUS1
    context = {
        'active_orders': active_orders,
        'status': status,
    }
    return render(request, 'admin/order-history.html', context)


def order_status_change(request):
    id = request.POST['id']
    status = request.POST['status']
    order_product = OrderProduct.objects.get(id=id)
    order_product.status = status
    order_product.save()
    return JsonResponse({'success': True})


def add_brand_offer(request):
    form = BrandOfferForm()
    if request.method == 'POST':
        form = BrandOfferForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('existing_brand_Offer')
    context = {
        'form': form
    }
    return render(request, 'admin/add_brand_offer.html', context)


def existing_brand_Offer(request):
    offers = BrandOffer.objects.order_by('id').all()
    return render(request, 'admin/existing_brand_Offer.html', {'offers': offers})


def add_category_offer(request):
    form = CategoryOfferForm()
    if request.method == 'POST':
        form = CategoryOfferForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('existing_category_Offer')
    context = {
        'form': form
    }
    return render(request, 'admin/add_category_offer.html', context)


def existing_category_Offer(request):
    offers = CategoryOffer.objects.order_by('id').all()
    return render(request, 'admin/existing_category_Offer.html', {'offers': offers})


def add_product_offer(request):
    form = ProductOfferForm()
    if request.method == 'POST':
        form = ProductOfferForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('existing_product_Offer')
    context = {
        'form': form
    }
    return render(request, 'admin/add_product_offer.html', context)


def existing_product_Offer(request):
    offers = ProductOffer.objects.order_by('id').all()
    return render(request, 'admin/existing_product_Offer.html', {'offers': offers})


def add_banner(request):
    form = BannerForm()
    if request.method == 'POST':
        form = BannerForm(request.POST,request.FILES)
        if form.is_valid():
            form.save()
            return redirect('active_banners')
    context = {
        'form': form
    }
    return render(request, 'admin/add_banner.html', context)


def active_banners(request):
    banners = Banners.objects.all()
    return render(request, 'admin/active_banners.html', {'banners': banners})
