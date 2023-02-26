from django.db import models
from django.contrib.auth.models import AbstractBaseUser, PermissionsMixin
from django.utils.translation import gettext_lazy as _
from phonenumber_field.modelfields import PhoneNumberField
from .user_manager import CustomUserManager

class CustomUser(AbstractBaseUser, PermissionsMixin):
    selections = [('Male', 'Male'), ('Female', 'Female'), ('Others', 'Others')]

    name = models.CharField(max_length=20)
    gender = models.CharField('Gender', max_length=20,
                              choices=selections, default='Male', null=True)
    phone = PhoneNumberField(
        _("phone_number"), unique=True, null=False, blank=False)
    email = models.EmailField(unique=True, max_length=200)
    location = models.CharField(max_length=30, null=True, blank=True)
    is_active = models.BooleanField(default=False)
    is_ServiceProvider = models.BooleanField(default=False)
    avatar = models.ImageField(null=True)

    class UserType(models.IntegerChoices):
        ADMIN = 1, _('Admin')
        SERVICE_PROVIDER = 2, _('Service Provider')        
        USER = 3, _('Client')

    user_type = models.IntegerField(choices=UserType.choices, blank=True, null=True)
    
    # Setting email as username and required fields.
    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['name', 'phone', 'location', 'gender']

    objects = CustomUserManager()

    def __str__(self):
        return self.email

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
