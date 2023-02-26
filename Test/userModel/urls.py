from django.urls import path, include
from .views import UserRegistration, UserLogin

urlpatterns = [
    path('login/', UserLogin.as_view(), name='user_login'),
    path('register/', UserRegistration.as_view(), name='user_register'),
    
]
   

