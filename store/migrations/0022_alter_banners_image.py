# Generated by Django 3.2.9 on 2021-11-30 15:52

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('store', '0021_banners'),
    ]

    operations = [
        migrations.AlterField(
            model_name='banners',
            name='image',
            field=models.ImageField(blank=True, upload_to='photos/banners'),
        ),
    ]
