from django.contrib import admin
from .models import CustomUser, ServiceProvider
# Register your models here.
admin.site.register(CustomUser)
admin.site.register(ServiceProvider)

