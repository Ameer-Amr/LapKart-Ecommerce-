# Generated by Django 3.2.9 on 2021-11-23 08:53

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("orders", "0001_initial"),
    ]

    operations = [
        migrations.AddField(
            model_name="order",
            name="pin",
            field=models.IntegerField(default=673641),
            preserve_default=False,
        ),
    ]
