from django.forms import ModelForm
from userModel.models import CustomUser, ServiceProvider

class CustomUserForm(ModelForm):
    class Meta:
        model = CustomUser
        fields = ['name', 'gender', 'location', 'email', 'phone', 'user_type']


class ServiceProviderForm(ModelForm):
    class Meta:
        model =ServiceProvider
        fields = ['service', 'price']