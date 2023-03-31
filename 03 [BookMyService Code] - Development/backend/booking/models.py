from django.db import models
from userModel.models import CustomUser, ServiceProvider

# Create your models here.
class Booking(models.Model):
    serviceProvider_id = models.ForeignKey(ServiceProvider, on_delete=models.CASCADE)
    user_id = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    serviceDate = models.DateField()
    bookingDate = models.DateField(auto_now=True)
    location = models.CharField(max_length=30, blank=True)
    price = models.FloatField(default=0)
    start_time = models.TimeField(auto_now=False, auto_now_add=False, null=True)
    end_time = models.TimeField(auto_now=False, auto_now_add=False)
    booking_status = models.BooleanField(default=False)
    


