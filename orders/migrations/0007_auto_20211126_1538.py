# Generated by Django 3.2.9 on 2021-11-26 15:38

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ("orders", "0006_rename_phone_order_phone_number"),
    ]

    operations = [
        migrations.RemoveField(
            model_name="order",
            name="address_type",
        ),
        migrations.RemoveField(
            model_name="order",
            name="default",
        ),
    ]
