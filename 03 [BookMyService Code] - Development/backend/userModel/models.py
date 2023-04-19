from django.db import models
from django.contrib.auth.models import AbstractBaseUser, PermissionsMixin
from django.utils.translation import gettext_lazy as _
from phonenumber_field.modelfields import PhoneNumberField
from .UserManager import CustomUserManager


class CustomUser(AbstractBaseUser, PermissionsMixin):
    selections = [('Male', 'Male'), ('Female', 'Female'), ('Others', 'Others')]

    users = [('Admin', 'Admin'), ('Service Provider', 'Service Provider'), ('Clients', 'Clients')]

    name = models.CharField(max_length=20)
    gender = models.CharField('Gender', max_length=20,choices=selections, default='Male', null=True)
    phone = PhoneNumberField(
        _("phone_number"), unique=True, null=False, blank=False)
    email = models.EmailField(unique=True, max_length=200)
    location = models.CharField(max_length=30, null=True, blank=True)
    is_active = models.BooleanField(default=False)
    is_staff = models.BooleanField(default=False)
    avatar = models.ImageField(null=True, blank=True, default='', upload_to='images')
    user_type = models.CharField('User Type', max_length=20, choices=users, default='Clients', null=False)
    
    # Setting email as username and required fields.
    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['name', 'phone', 'location', 'gender']

    objects = CustomUserManager()

    def __str__(self):
        return self.name

    def has_perm(self, perm, obj=None):
        return True

    # Setting properties to define user roles.
    @property
    def admin(self):
        return self.user_type == self.UserType.ADMIN

    def service_provider(self):
        return self.user_type == self.UserType.SERVICE_PROVIDER

    def client(self):
        return self.user_type == self.UserType.USER



class ServiceProvider(models.Model):
    service_type = [('Cleaner', 'cleaner'),
                    ('Carpenter', 'carpenter'), 
                    ('Babysitter', 'babysitter'),
                    ('Painter', 'painter'),
                    ('Electrician', 'electrician'),
                    ('Elderly Care', 'elderly care'),
                    ('Plumber', 'plumber'),
                    ]

    service = models.CharField('Service', max_length=20,
                              choices=service_type, null=False)
    service_provider = models.ForeignKey(CustomUser, on_delete=models.CASCADE, null=True)
    price = models.FloatField(default=0)
    booking_count = models.IntegerField(default=0)
    success = models.IntegerField(default=0)
    active_status = models.BooleanField(default=True)
    description = models.TextField(null=True, blank=True)

    def __str__(self):
        return self.service_provider.name
