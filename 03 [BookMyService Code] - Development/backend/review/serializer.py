from rest_framework import serializers

from userModel.serializer import UserSerializer
from .models import feedback

class FeedbackSerializer(serializers.ModelSerializer):
    user_id = UserSerializer(many=False, read_only=True)
    class Meta:
        model = feedback
        fields = '__all__'