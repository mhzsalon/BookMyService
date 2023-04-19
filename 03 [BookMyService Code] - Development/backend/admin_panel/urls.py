from django.urls import path
from .views import  loginPage, dashboard, logoutUser, addUser, addSp, deleteUser, getBooking, getPayment
urlpatterns = [
    path('', loginPage, name='admin-login'),
    path('dashboard/', dashboard, name='dashboard'),
    path('user/', addUser, name='user'),

    path('service-provider/', addSp, name='service-provider'),
    path('delete-user/<str:pk>/', deleteUser, name='delete-user'),

    path('booking/', getBooking, name='booking'),
    path('payment-details/', getPayment, name='payment-details'),

    path('logout/', logoutUser, name='logout'),


]
   

