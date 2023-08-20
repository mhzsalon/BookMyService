from rest_framework import serializers
from .models import Payment
from booking.serializer import BookingHistorySerializer

class PaymentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Payment
        fields = [ 'payment_mode', 'is_paid', 'booking_id']
