from django.db import models
from django.db.models import fields
from django.forms import ModelForm
from .models import Banners, Product, ReviewRating, Variation
from django.forms.widgets import TextInput


class ProductForm(ModelForm):
    class Meta:
        model = Product
        fields = [
            "product_name",
            "brand_name",
            "slug",
            "images",
            "images1",
            "images2",
            "images3",
            "description",
            "price",
            "category",
            "stock",
        ]


class VarientForm(ModelForm):
    class Meta:
        model = Variation
        fields = [
            "product",
            "variation_category",
            "variation_value",
            "color_name",
            "is_active",
        ]
        widgets = {
            "variation_value": TextInput(attrs={"type": "color"}),
        }


class ReviewForm(ModelForm):
    class Meta:
        model = ReviewRating
        fields = [
            "subject",
            "review",
            "rating",
        ]


class BannerForm(ModelForm):
    class Meta:
        model = Banners
        fields = ["image", "product", "alt_text"]
