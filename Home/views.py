from django.shortcuts import render
from store.models import Banners, Product
from django.contrib import messages

# Create your views here.


def Homepage(request):
    products = Product.objects.all().filter(is_available=True)
    banners = Banners.objects.all()
    context = {
        "products": products,
        "banners": banners,
    }
    return render(request, "user/Home.html", context)
