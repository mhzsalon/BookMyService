from django.urls import path
from .views import servicePayment

urlpatterns = [
    path('payment/', servicePayment.as_view(), name='payment'),
 
]