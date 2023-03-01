from rest_framework import serializers
from .models import CustomUser, ServiceProvider

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomUser
        fields = '__all__'


class LoginSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomUser
        fields = ['user_type']

class SpSerializer(serializers.ModelSerializer):
    # sp_name = serializers.CharField(source='id.name')
    class Meta:
        model = ServiceProvider
        fields = ['service', 'price', 'active_status']
        