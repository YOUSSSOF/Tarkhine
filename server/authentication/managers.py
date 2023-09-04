from typing import Any, Optional
from authentication.utils import Utils
from django.contrib.auth.models import UserManager as BaseUserManager


class UserManager(BaseUserManager):

    def create_user(self, phone_number, password=None, **extra_fields):
        phone_number = Utils.make_phone_number_standard(phone_number)
        if not phone_number:
            raise ValueError("The Phone Number field must be set")

        user = self.model(phone_number=phone_number, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, phone_number, password=None, **extra_fields):
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)
        if extra_fields.get('is_staff') is not True:
            raise ValueError('You must set is_staff')

        return self.create_user(phone_number, password, **extra_fields)

