from django.urls import path, include
from .views import helloAPI, randomQuote

urlpatterns = [
    path("hello/", helloAPI),
    path("<int:id>/", randomQuote),
]