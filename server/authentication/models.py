from django.db import models

# Create your models here.
from django.contrib.auth.models import AbstractBaseUser


class User(AbstractBaseUser):
    phone_number = models.CharField(max_length=255,unique=True)
    first_name = models.CharField(max_length=255, null=True)
    last_name = models.CharField(max_length=255, null=True)
    email = models.EmailField(max_length=255, null=True)
    birth = models.DateField(null=True, blank=True)
    username = models.CharField(max_length=255, default='کاربر ترخینه')
    address = models.CharField(max_length=255, null=True)
    last_login = models.DateTimeField(auto_now_add=True)
    USERNAME_FIELD = 'phone_number'
    REQUIRED_FIELDS = [phone_number]
