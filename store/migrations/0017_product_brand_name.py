# Generated by Django 3.2.9 on 2021-11-29 16:04

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ("brands", "0001_initial"),
        ("store", "0016_remove_product_brand_name"),
    ]

    operations = [
        migrations.AddField(
            model_name="product",
            name="brand_name",
            field=models.ForeignKey(
                blank=True,
                null=True,
                on_delete=django.db.models.deletion.CASCADE,
                to="brands.brand",
            ),
        ),
    ]
