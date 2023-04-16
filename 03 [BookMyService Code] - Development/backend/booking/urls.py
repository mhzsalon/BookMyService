from django.urls import path
from .views import BookService, BookingHistory

urlpatterns = [
    path('book-service/', BookService.as_view(), name='booking'),
    path('booking-history/', BookingHistory.as_view(), name='booking-history'),

 
]