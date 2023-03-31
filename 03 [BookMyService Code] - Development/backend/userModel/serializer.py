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
    # sp_name = serializers.CharField(source='id.name')
    service_provider = UserSerializer(many=False, read_only=True)
    class Meta:
        model = ServiceProvider
        fields = ['id', 'service', 'price', 'active_status', 'service_provider', 'description']
    
    # def get_details(self,obj):
    #     spDetails = CustomUser.objects.get(id=obj.service_provider.id)
    #     sp = UserSerializer(spDetails, many=True)
    #     return sp

class StatusSerializer(serializers.ModelSerializer):
    class Meta:
        model = ServiceProvider
        fields = ['active_status']
    