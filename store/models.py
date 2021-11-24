from django.db import models
from django.db.models.deletion import CASCADE
from category.models import category
from django.urls import reverse
from colorfield.fields import ColorField
# Create your models here.


class Product(models.Model):
    product_name = models.CharField(max_length=200,unique=True)
    slug = models.SlugField(max_length=200,unique=True)
    description = models.TextField(max_length=500,blank=True)
    price = models.IntegerField()
    images = models.ImageField(upload_to='photos/products',null=True)
    images1 = models.ImageField(upload_to='photos/products',null=True)
    images2 = models.ImageField(upload_to='photos/products',null=True)
    images3 = models.ImageField(upload_to='photos/products',null=True)
    stock = models.IntegerField()
    is_available = models.BooleanField(default=True)
    category = models.ForeignKey(category,on_delete=models.CASCADE) #when delete a category all products related to that category will be deleted
    created_date = models.DateTimeField(auto_now_add=True)
    modified_date = models.DateTimeField(auto_now=True)


    def get_url(self):
        return reverse('product_detail',args = [self.category.slug,self.slug])



    def __str__(self):
        return self.product_name


# class VariationManager(models.Manager):
#     def get_ram(self):
#          return super(VariationManager,self).order_by().values('ram_category').distinct()


#     def RAM(self):
#         return super(VariationManager,self).filter(ram_category={'4GB','8GB'},is_active = True)

#     def storage(self):
#         return super(VariationManager,self).filter(variation_category={'HDD','SSD'},is_active = True)

variation_category_choice = (
    ('color','color'),
)

class Variation(models.Model):
    product = models.ForeignKey(Product,on_delete=models.CASCADE)
    variation_category = models.CharField(max_length=100,choices = variation_category_choice)
    variation_value = models.CharField(max_length = 7)
    color_name = models.CharField(max_length=20)
    is_active = models.BooleanField(default=True)
    created_date = models.DateField(auto_now=True)

    # objects = VariationManager()


    # def get_ram(self):
    #      return self.objects.order_by().values('ram_category').distinct()

    def __unicode__(self):
        return self.product

     