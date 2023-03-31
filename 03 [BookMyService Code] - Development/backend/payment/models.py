# from django.db import models
# from booking.models import Booking

# # Create your models here.
# class Payment(models.Model):
#     user_id = models.CharField(max_length=50, null=True)
#     booking_id = models.ForeignKey(Booking, on_delete=models.CASCADE)
#     payment_Date = models.DateField(auto_now_add=True)
#     payment_mode = models.CharField(max_length=100, null=True)
#     is_paid = models.BooleanField(default=False)
#     amount = models.IntegerField(null=True)