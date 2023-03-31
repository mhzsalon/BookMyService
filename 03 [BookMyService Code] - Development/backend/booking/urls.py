from django.urls import path
from .views import BookService

urlpatterns = [
    path('book-service/', BookService.as_view(), name='booking'),
 
]