from django.db import models
from booking.models import Booking
from userModel.models import CustomUser

# Create your models here.
class Payment(models.Model):
    types = [('Cash', 'cash'), ('Online', 'online')]


    user_id = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    booking_id = models.ForeignKey(Booking, on_delete=models.CASCADE)
    payment_date = models.DateField(auto_now_add=True)
    payment_mode = models.CharField('Payemnt mode', max_length=20,
                              choices=types, default='Cash', null=True)
    is_paid = models.BooleanField(default=False)
    amount = models.IntegerField(null=True, blank=True)