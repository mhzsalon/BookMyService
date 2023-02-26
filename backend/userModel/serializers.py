from rest_framework import serializers
from .models import CustomUser

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomUser
        fields = '__all__'

class UserVerifySerializer(serializers.ModelField):
    class Meta:
        model = CustomUser
        fields = ['is_verified']


