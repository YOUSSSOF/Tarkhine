from django.shortcuts import render
from rest_framework import views, permissions, response
from django.contrib.auth import get_user_model
from delivery import models, serializers
# Create your views here.


