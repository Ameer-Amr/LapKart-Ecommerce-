# Generated by Django 3.2.9 on 2021-11-30 16:51

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ("store", "0024_delete_banners"),
    ]

    operations = [
        migrations.CreateModel(
            name="Banners",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                (
                    "image",
                    models.ImageField(blank=True, upload_to="photos/banners"),
                ),
                ("alt_text", models.CharField(max_length=200)),
                (
                    "product",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        to="store.product",
                    ),
                ),
            ],
        ),
    ]
