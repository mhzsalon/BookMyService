# Generated by Django 3.2.7 on 2023-05-23 11:01

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('userModel', '0013_alter_customuser_avatar'),
    ]

    operations = [
        migrations.AlterField(
            model_name='customuser',
            name='avatar',
            field=models.ImageField(blank=True, default='images/default-profile.png', null=True, upload_to='images'),
        ),
    ]