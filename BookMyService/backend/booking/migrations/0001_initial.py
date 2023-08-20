# Generated by Django 3.2.7 on 2023-03-20 11:52

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('userModel', '0008_alter_serviceprovider_service_provider'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Booking',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('serviceDate', models.DateField()),
                ('bookingDate', models.DateField(auto_now=True)),
                ('location', models.CharField(blank=True, max_length=30)),
                ('price', models.FloatField(default=0)),
                ('time', models.TimeField()),
                ('booking_status', models.BooleanField(default=False)),
                ('serviceProvider_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='userModel.serviceprovider')),
                ('user_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]