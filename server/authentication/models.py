from django.db import models

# Create your models here.
from django.contrib.auth.models import AbstractBaseUser


class User(AbstractBaseUser):
    phone_number = models.CharField(max_length=255)
    first_name = models.CharField(max_length=255)
    last_name = models.CharField(max_length=255)
    email = models.EmailField(max_length=255)
    birth = models.DateField()
    username = models.CharField(max_length=255)
    address = models.CharField(max_length=255)

    USERNAME_FIELD = 'phone_number'
    REQUIRED_FIELDS = [phone_number]

