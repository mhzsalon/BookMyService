from rest_framework import serializers
from .models import Booking
from userModel.serializer import UserSerializer, SpSerializer

class BookingSerializer(serializers.ModelSerializer):
    class Meta:
        model = Booking
        fields = '__all__'

class BookingHistorySerializer(serializers.ModelSerializer):
    user_id = UserSerializer(many=False, read_only=True)
    serviceProvider_id = SpSerializer(many=False, read_only=True)

    class Meta:
        model = Booking
        fields = ['user_id', 'serviceProvider_id', 'serviceDate', 'location', 'price', 'start_time', 'end_time', 'requirement', 'id']