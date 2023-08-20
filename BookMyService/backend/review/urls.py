from django.urls import path
from .views import Review

urlpatterns = [
    path('review/', Review.as_view(), name='review'),

]
