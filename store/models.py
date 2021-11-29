from django.db import models
from django.db.models.deletion import CASCADE
from accounts.models import Account
from category.models import category
from django.urls import reverse
from colorfield.fields import ColorField
from django.db.models import Avg, Count
from brands.models import Brand


# Create your models here.


class Product(models.Model):
    product_name = models.CharField(max_length=200,unique=True)
    brand_name = models.ForeignKey(Brand,on_delete=models.CASCADE,null=True,blank=True)
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



    def averageReview(self):
        reviews = ReviewRating.objects.filter(product=self, status=True).aggregate(average=Avg('rating'))
        avg = 0
        if reviews['average'] is not None:
            avg = float(reviews['average'])
        return avg

    def countReview(self):
        reviews = ReviewRating.objects.filter(product=self, status=True).aggregate(count=Count('id'))
        count = 0
        if reviews['count'] is not None:
            count = int(reviews['count'])
        return count

    #offer discount
    def Offer_Price(self):
        try:
            if self.productoffer.is_valid:
                offer_price = (self.price * self.productoffer.discount)/100
                new_price = self.price - offer_price
            return {'new_price':new_price,'discount': self.productoffer.discount}
        except:
            return None



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

     
class ReviewRating(models.Model):
    product = models.ForeignKey(Product,on_delete=models.CASCADE)
    user = models.ForeignKey(Account,on_delete=models.CASCADE)
    subject = models.CharField(max_length=100,blank=True)
    review = models.TextField(max_length=500,blank=True)
    rating = models.FloatField()
    ip = models.CharField(max_length=20,blank=True)
    status = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.subject