# Generated by Django 3.2.9 on 2021-11-19 08:55

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("store", "0003_alter_productgallery_options"),
    ]

    operations = [
        migrations.AddField(
            model_name="product",
            name="images1",
            field=models.ImageField(null=True, upload_to="photos/products"),
        ),
        migrations.AddField(
            model_name="product",
            name="images2",
            field=models.ImageField(null=True, upload_to="photos/products"),
        ),
        migrations.AddField(
            model_name="product",
            name="images3",
            field=models.ImageField(null=True, upload_to="photos/products"),
        ),
        migrations.AlterField(
            model_name="product",
            name="images",
            field=models.ImageField(null=True, upload_to="photos/products"),
        ),
        migrations.DeleteModel(
            name="ProductGallery",
        ),
    ]
