# Generated by Django 3.2.7 on 2023-03-20 11:52

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('booking', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Payment',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('user_id', models.CharField(max_length=50, null=True)),
                ('payment_Date', models.DateField(auto_now_add=True)),
                ('payment_mode', models.CharField(max_length=100, null=True)),
                ('is_paid', models.BooleanField(default=False)),
                ('amount', models.IntegerField(null=True)),
                ('booking_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='booking.booking')),
            ],
        ),
    ]
