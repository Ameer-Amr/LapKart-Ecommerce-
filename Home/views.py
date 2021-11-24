from django.shortcuts import render
from store.models import Product
from django.contrib import messages
# Create your views here.


def Homepage(request):
    products =Product.objects.all().filter(is_available=True)
    context = {
        'products':products,
    }
    return render(request,'user/Home.html',context)