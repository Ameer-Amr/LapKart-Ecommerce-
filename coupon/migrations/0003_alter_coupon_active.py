# Generated by Django 3.2.9 on 2021-12-05 02:02

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("coupon", "0002_auto_20211203_1909"),
    ]

    operations = [
        migrations.AlterField(
            model_name="coupon",
            name="active",
            field=models.BooleanField(default=True),
        ),
    ]
