
# Django
from django.forms import ModelForm

# local
from .models import CategoryOffer,ProductOffer,BrandOffer



class BrandOfferForm(ModelForm):
    class Meta:
        model = BrandOffer
        fields = ['brand_name', 'discount', 'is_valid']


    def __init__(self, *args, **kwargs):
        super(BrandOfferForm, self).__init__(*args, **kwargs)
        for field in self.fields:
            self.fields[field].widget.attrs['class'] = 'form-control'




class CategoryOfferForm(ModelForm):
    class Meta:
        model = CategoryOffer
        fields = ['category_name', 'discount', 'is_valid']
    

    def __init__(self, *args, **kwargs):
        super(CategoryOffer, self).__init__(*args, **kwargs)
        for field in self.fields:
            self.fields[field].widget.attrs['class'] = 'form-control'




class ProductOfferForm(ModelForm):
    class Meta:
        model = ProductOffer
        fields = ['variant', 'discount', 'is_valid']

    
    def __init__(self, *args, **kwargs):
        super(ProductOfferForm, self).__init__(*args, **kwargs)
        for field in self.fields:
            self.fields[field].widget.attrs['class'] = 'form-control'