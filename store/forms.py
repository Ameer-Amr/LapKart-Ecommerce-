from django.db.models import fields
from django.forms import ModelForm
from.models import Product, Variation
from django.forms.widgets import TextInput


class ProductForm(ModelForm):
    class Meta:
        model = Product
        fields = ['product_name','slug','images','images1','images2','images3','description','price','category',]


class VarientForm(ModelForm):
    class Meta:
        model = Variation
        fields = ['product','variation_category','variation_value','color_name','is_active']
        widgets = {
   'variation_value': TextInput(attrs = {
      'type': 'color'
   }),
}

