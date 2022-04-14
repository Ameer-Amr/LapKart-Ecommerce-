from django.db.models import fields
from django.forms import ModelForm
from .models import Brand


class BrandForm(ModelForm):
    class Meta:
        model = Brand
        fields = ["brand_name", "slug", "logo", "description"]
