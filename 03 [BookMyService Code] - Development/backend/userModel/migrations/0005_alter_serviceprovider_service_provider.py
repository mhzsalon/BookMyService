# Generated by Django 3.2.7 on 2023-03-03 14:24

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('userModel', '0004_alter_serviceprovider_service_provider'),
    ]

    operations = [
        migrations.AlterField(
            model_name='serviceprovider',
            name='service_provider',
            field=models.OneToOneField(null=True, on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL),
        ),
    ]
