from django.urls import path
from .views import  loginPage, dashboard, logoutUser, addUser, addSp, deleteUser
urlpatterns = [
    path('', loginPage, name='admin-login'),
    path('dashboard/', dashboard, name='dashboard'),
    path('user/', addUser, name='user'),

    path('service-provider/', addSp, name='service-provider'),
    path('delete-user/<str:pk>/', deleteUser, name='delete-user'),




    path('logout/', logoutUser, name='logout'),


]
   

