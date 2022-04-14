from django import forms
from django.forms import fields
from .models import Order, OrderProduct


class OrderForm(forms.ModelForm):
    class Meta:
        model = Order
        fields = [
            "first_name",
            "last_name",
            "phone_number",
            "email",
            "address_line_1",
            "address_line_2",
            "country",
            "state",
            "city",
            "pincode",
            "order_note",
        ]


# class OrderProductForm(forms.ModelForm):
#     class Meta:
#         model = OrderProduct
#         fields = ['status']

#     def __init__(self, *args, **kwargs):
#         super(OrderProductForm, self).__init__(*args, **kwargs)
#         for field in self.fields:
#             self.fields[field].widget.attrs['class'] = 'form-control'

#         self.fields['status'].widget.attrs['value'] = 'Select'
