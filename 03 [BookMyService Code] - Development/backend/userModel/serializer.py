from rest_framework import serializers
from .models import CustomUser, ServiceProvider

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomUser
        fields = ['id', 'name', 'email', 'phone', 'location', 'gender', 'user_type']




class LoginSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomUser
        fields = ['id','user_type', 'email', 'name']
        

class SpSerializer(serializers.ModelSerializer):
    service_provider = UserSerializer(many=False, read_only=True)
    class Meta:
        model = ServiceProvider
        fields = ['id', 'service', 'price', 'active_status', 'service_provider', 'description']
    

class StatusSerializer(serializers.ModelSerializer):
    class Meta:
        model = ServiceProvider
        fields = ['active_status']
    