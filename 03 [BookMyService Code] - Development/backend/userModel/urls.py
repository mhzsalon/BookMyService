from django.urls import path
from .views import  UserLogin, UserRegistration, getSP, logout

urlpatterns = [
    path('login/', UserLogin.as_view(), name='user_login'),
    path('register/', UserRegistration.as_view(), name='user_register'),
    path('logout/', logout, name='logout'),


    path('service_provider/', getSP.as_view(), name='get_service_provider'),

    
]
   

