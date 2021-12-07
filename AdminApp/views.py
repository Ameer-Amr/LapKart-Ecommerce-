
import datetime
from django.shortcuts import render, redirect
from django.contrib import messages, auth
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth.decorators import login_required
from django.utils import timezone
from coupon.forms import CouponForm
from offer.forms import BrandOfferForm, CategoryOfferForm, ProductOfferForm
from offer.models import BrandOffer, CategoryOffer, ProductOffer
from .forms import EditBrand, EditBrandOffer, EditCategory, EditCategoryOffer, EditProduct, EditProductOffer, EditVarient
from store.models import Banners, Product, Variation
from store.forms import BannerForm, ProductForm, VarientForm
from accounts.models import Account
from category.models import category
from category.forms import CategoryForm
from brands.models import Brand
from brands.form import BrandForm
from django.http import JsonResponse,HttpResponse
from orders.models import Order, OrderProduct, STATUS1
from django.db.models import Sum
from coupon.models import Coupon
from datetime import date
import csv
from django.template.loader import render_to_string
from weasyprint import HTML
import tempfile

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
    products = Product.objects.all()
    total_revenue = Order.objects.aggregate(Sum ('order_total'))
    total_orders = Order.objects.filter(is_ordered=True).count()
    total_products = Product.objects.filter(is_available=True).count()

    if request.session.has_key('key'):

        #sales/orders
        current_year = timezone.now().year
        order_detail = OrderProduct.objects.filter(created_at__lt = datetime.date(current_year,12,31 ), status = 'Delivered') #with the '__' we can access foreign key objects
        monthly_order_count = []
        month = timezone.now().month
        print(month)
        for i in range(1, month+1):
            monthly_order = order_detail.filter(created_at__month=i).count()
            monthly_order_count.append(monthly_order)


        #status
        new_count = OrderProduct.objects.filter(status='New').count()
        placed_count = OrderProduct.objects.filter(status='Placed').count()
        shipped_count = OrderProduct.objects.filter(status='Shipped').count()
        accepted_count = OrderProduct.objects.filter(status='Accepted').count()
        delivered_count = OrderProduct.objects.filter(status='Delivered').count()
        cancelled_count = OrderProduct.objects.filter(status='Canceled').count()
       
        #most moving product
        most_moving_product_count = []
        most_moving_product = []
        for i in products:
            most_moving_product.append(i)
            most_moving_product_count.append(
                OrderProduct.objects.filter(product=i, status="Delivered").count())
        
        print(most_moving_product)
        print(most_moving_product_count)
        
        context = {
            'order_detail':order_detail,
            'monthly_order_count':monthly_order_count,
            'status_counter':[new_count,placed_count,shipped_count,accepted_count,delivered_count,cancelled_count],
            'most_moving_product_count':most_moving_product_count,
            'most_moving_product':most_moving_product,
            'total_revenue':total_revenue,
            'total_orders':total_orders,
            'total_products':total_products  
    }
        return render(request, 'admin/dashboard.html',context)
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
    active_orders = OrderProduct.objects.all().exclude(status__in=exclude_list)[::-1] #for reversing the order.
    status = STATUS1
    context = {
        'active_orders': active_orders,
        'status': status,
    }
    return render(request, 'admin/active_orders.html', context)


def order_history(request):
    exclude_list = ['New', 'Accepted', 'Placed', 'Shipped', ]
    active_orders = OrderProduct.objects.all().exclude(status__in=exclude_list)[::-1]
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


def blockBrandOffer(request, brand_id):
    brandoff = BrandOffer.objects.get(pk=brand_id)
    brandoff.is_valid = False
    brandoff.save()
    return redirect('existing_brand_Offer')


def unblockBrandOffer(request, brand_id):
    brandoff = BrandOffer.objects.get(pk=brand_id)
    brandoff.is_valid = True
    brandoff.save()
    return redirect('existing_brand_Offer')


def editBrandOffer(request, brand_id):
    editBrandOff = BrandOffer.objects.get(pk=brand_id)
    form = EditBrandOffer(instance=editBrandOff)
    if request.method == 'POST':
        form = EditBrandOffer(request.POST,instance=editBrandOff)
        if form.is_valid():
            try:
                form.save()

            except:
                context = {'form': form}
                # messages.info(request,"A user with that email address already exists.")
                return render(request, 'admin/editBrandOffer.html', context)
            return redirect('existing_brand_Offer')

    context = {'form': form}
    return render(request, 'admin/editBrandOffer.html', context)


def deleteBrandOffer(request, brand_id):
        dlt = BrandOffer.objects.get(pk=brand_id)
        dlt.delete()
        return redirect('existing_brand_Offer')


def blockCategoryOffer(request, category_id):
    categoryoff = CategoryOffer.objects.get(pk=category_id)
    categoryoff.is_valid = False
    categoryoff.save()
    return redirect('existing_category_Offer')


def unblockCategoryOffer(request, category_id):
    categoryoff = CategoryOffer.objects.get(pk=category_id)
    categoryoff.is_valid = True
    categoryoff.save()
    return redirect('existing_category_Offer')


def editCategoryOffer(request, category_id):
    editCategoryOff = CategoryOffer.objects.get(pk=category_id)
    form = EditCategoryOffer(instance=editCategoryOff)
    if request.method == 'POST':
        form = EditCategoryOffer(request.POST,instance=editCategoryOff)
        if form.is_valid():
            try:
                form.save()

            except:
                context = {'form': form}
                # messages.info(request,"A user with that email address already exists.")
                return render(request, 'admin/editCategoryOffer.html', context)
            return redirect('existing_category_Offer')

    context = {'form': form}
    return render(request, 'admin/editCategoryOffer.html', context)


def deleteCategoryOffer(request, category_id):
    dlt = CategoryOffer.objects.get(pk=category_id)
    dlt.delete()
    return redirect('existing_category_Offer')





def blockProductOffer(request, product_id):
    productoff = ProductOffer.objects.get(pk=product_id)
    productoff.is_valid = False
    productoff.save()
    return redirect('existing_product_Offer')


def unblockProductOffer(request, product_id):
    productoff = ProductOffer.objects.get(pk=product_id)
    productoff.is_valid = True
    productoff.save()
    return redirect('existing_product_Offer')


def editProductOffer(request, product_id):
    editProductOff = ProductOffer.objects.get(pk=product_id)
    form = EditProductOffer(instance=editProductOff)
    if request.method == 'POST':
        form = EditProductOffer(request.POST,instance=editProductOff)
        if form.is_valid():
            try:
                form.save()

            except:
                context = {'form': form}
                # messages.info(request,"A user with that email address already exists.")
                return render(request, 'admin/editProductOffer.html', context)
            return redirect('existing_product_Offer')

    context = {'form': form}
    return render(request, 'admin/editProductOffer.html', context)


def deleteProductOffer(request, product_id):
    dlt = ProductOffer.objects.get(pk=product_id)
    dlt.delete()
    return redirect('existing_product_Offer')



def coupon_lists(request):
    today = date.today()
    coupon_form = CouponForm()
    coupons = Coupon.objects.all().order_by('-id')


    for coupon in coupons:
        if coupon.valid_from <= today and coupon.valid_to >= today:
            Coupon.objects.filter(id=coupon.id).update(active=True)
        else:
            Coupon.objects.filter(id=coupon.id).update(active=False)

    context = {
        'coupon_form': coupon_form,
        'coupons': coupons,
    }
    return render(request, 'admin/couponlist.html', context)



def add_coupon(request):
    form = CouponForm()
    if request.method == 'POST':
        form = CouponForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('coupon_lists')
    context = {
        'form': form
    }
    return render(request, 'admin/add_coupon.html', context)


def prouduct_report(request):
    products = Product.objects.all()
    sales = OrderProduct.objects.filter(ordered = True,status = 'Delivered')
    orders = OrderProduct.objects.filter(ordered=True).order_by('-created_at')

    if request.GET.get('from'):
        date_from = datetime.datetime.strptime(request.GET.get('from'), "%Y-%m-%d")
        date_to = datetime.datetime.strptime(request.GET.get('to'), "%Y-%m-%d")
        date_to += datetime.timedelta(days=1)
        orders = OrderProduct.objects.filter(created_at__range=[date_from, date_to])


    if request.GET.get('from'):
        date_from = datetime.datetime.strptime(request.GET.get('from'), "%Y-%m-%d")
        date_to = datetime.datetime.strptime(request.GET.get('to'), "%Y-%m-%d")
        date_to += datetime.timedelta(days=1)
        sales = OrderProduct.objects.filter(created_at__range=[date_from, date_to])

    context = {

        'products':products,
        'orders':orders,
        'sales':sales,
       

    }
    return render(request, 'admin/prouduct_report.html',context)


def product_export_csv(request):
    response = HttpResponse(content_type = 'text/csv')
    response['Content-Disposition'] = 'attachement; filename=Product_Report.csv'

    writer = csv.writer(response)
    writer.writerow(['Product Name','Brand Name','Category Name','Rating','Price','Stock'])

    products = Product.objects.all().order_by('id')

    for product in products:
        writer.writerow([product.product_name,product.brand_name,product.category,product.averageReview(),product.price,product.stock])

    return response


def product_export_pdf(request):
    response = HttpResponse(content_type = 'application/pdf')
    response['Content-Disposition'] = 'inline; attachement; filename=Product_Report.pdf'

    response['Content-Transfer-Encoding'] = 'binary'

    products = Product.objects.all().order_by('id')

    html_string = render_to_string('admin/product_pdf_output.html', {
                                    'products': products, 'total': 0})

    html = HTML(string=html_string)

    result = html.write_pdf()

    with tempfile.NamedTemporaryFile(delete=True) as output:
        output.write(result)
        output.flush()
        output = open(output.name, 'rb')
        response.write(output.read())

    return response


def orders_export_csv(request):
    response = HttpResponse(content_type='text/csv')
    response['Content-Disposition'] = 'attachment; filename=orders.csv'

    writer = csv.writer(response)
    orders = OrderProduct.objects.filter(ordered=True).order_by('-created_at')

    writer.writerow(
        ['Order Number', 'Customer', 'Product', 'Amount', 'Payment', 'Qty', 'Status', 'Date',])

    for order in orders:
        writer.writerow([order.order.order_number, order.user.full_name(), order.product,
                         order.product_price, order.payment.payment_method, order.quantity,
                         order.status,order.updated_at,])
    return response



def orders_export_pdf(request):
    response = HttpResponse(content_type = 'application/pdf')
    response['Content-Disposition'] = 'inline; attachement; filename=orders_Report.pdf'

    response['Content-Transfer-Encoding'] = 'binary'

    orders = OrderProduct.objects.filter(ordered=True).order_by('-created_at')

    html_string = render_to_string('admin/orders_pdf_output.html', {
                                    'orders': orders, 'total': 0})

    html = HTML(string=html_string)

    result = html.write_pdf()

    with tempfile.NamedTemporaryFile(delete=True) as output:
        output.write(result)
        output.flush()
        output = open(output.name, 'rb')
        response.write(output.read())

    return response



def sales_export_csv(request):
    
    response = HttpResponse(content_type='text/csv')
    response['Content-Disposition'] = 'attachment; filename=sales.csv'

    writer = csv.writer(response)
    sales = OrderProduct.objects.filter(ordered = True,status = 'Delivered')
    for sale in sales:
        offer_price = Product.Offer_Price(sale.product)
        if sale.product.Offer_Price: 
            discount = int(offer_price['discount'])
            for i in sale.variations.all():
                print(i.color_name)


    writer.writerow(
        ['Product Name', 'Color', 'Product Price', 'Offer Price', 'Discount', 'Qty', 'Last Updation'])


    writer.writerow([sale.product.product_name, i.color_name, sale.product.price,
                    sale.product_price, discount, sale.quantity,
                        sale.updated_at])
    return response




def sales_export_pdf(request):
    response = HttpResponse(content_type = 'application/pdf')
    response['Content-Disposition'] = 'inline; attachement; filename=sales_Report.pdf'

    response['Content-Transfer-Encoding'] = 'binary'

    sales = OrderProduct.objects.filter(ordered = True,status = 'Delivered')

    html_string = render_to_string('admin/sales_pdf_output.html', {
                                    'sales': sales, 'total': 0})

    html = HTML(string=html_string)

    result = html.write_pdf()

    with tempfile.NamedTemporaryFile(delete=True) as output:
        output.write(result)
        output.flush()
        output = open(output.name, 'rb')
        response.write(output.read())

    return response