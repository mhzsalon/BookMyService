from django.urls import path
from .views import  UserLogin, UserRegistration, getSP, logout, delete, activateUser, deactivateUser, changePw, updateUser

urlpatterns = [
    path('login/', UserLogin.as_view(), name='user_login'),
    path('register/', UserRegistration.as_view(), name='user_register'),
    path('logout/', logout, name='logout'),

    path('delete-user/', delete, name='delete'),
    path('change-password/', changePw.as_view(), name='change-password'),
    path('update-user/', updateUser.as_view(), name='update-user'),


    path('activate/', activateUser.as_view(), name='activate-user'),
    path('deactivate/', deactivateUser.as_view(), name='deactivate-user'),

    path('service_provider/', getSP.as_view(), name='get_service_provider'),

    
]
   

