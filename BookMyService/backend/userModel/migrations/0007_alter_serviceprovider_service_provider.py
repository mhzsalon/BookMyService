# Generated by Django 3.2.7 on 2023-03-04 13:31

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('userModel', '0006_alter_serviceprovider_service_provider'),
    ]

    operations = [
        migrations.AlterField(
            model_name='serviceprovider',
            name='service_provider',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='details', to=settings.AUTH_USER_MODEL),
        ),
    ]
