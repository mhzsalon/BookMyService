from rest_framework import serializers
from .models import feedback

class FeedbackSerializer(serializers.ModelSerializer):
    class Meta:
        model = feedback
        fields = '__all__'