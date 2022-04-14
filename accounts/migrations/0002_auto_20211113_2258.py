# Generated by Django 3.2.9 on 2021-11-13 22:58

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("accounts", "0001_initial"),
    ]

    operations = [
        migrations.AlterField(
            model_name="account",
            name="is_active",
            field=models.BooleanField(default=True),
        ),
        migrations.AlterField(
            model_name="account",
            name="phone_number",
            field=models.CharField(max_length=15, unique=True),
        ),
    ]
