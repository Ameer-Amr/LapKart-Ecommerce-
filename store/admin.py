from django.contrib import admin
from django.db import models
from .models import Product, Variation,ReviewRating
import admin_thumbnails
# Register your models here.





class ProductAdmin(admin.ModelAdmin):
    list_display = ('product_name','brand_name','category','modified_date','is_available','price','stock')
    prepopulated_fields = {'slug':('product_name',)}



class VariationAdmin(admin.ModelAdmin):
    list_display = ('product','variation_category','variation_value','color_name','is_active')
    list_editable = ('is_active',)
    list_filter = ('product','variation_category','color_name','variation_value')
    fieldsets = (
   (None, {
      'fields': (('name', 'letter'), 'questions', 'color')
   }),
)

admin.site.register(Product,ProductAdmin)
admin.site.register(Variation,VariationAdmin)
admin.site.register(ReviewRating)
