from django.conf import settings
from django.contrib.auth.models import AbstractBaseUser, PermissionsMixin
from authentication import managers
from django.utils import timezone
from datetime import timedelta
from django.db import models
import random
import string
import bcrypt
import requests


class User(AbstractBaseUser, PermissionsMixin):
    phone_number = models.CharField(max_length=12, unique=True)
    first_name = models.CharField(max_length=255, null=True)
    last_name = models.CharField(max_length=255, null=True)
    email = models.EmailField(max_length=255, null=True)
    birth = models.DateField(null=True, blank=True)
    username = models.CharField(max_length=255, default='کاربر ترخینه')
    address = models.CharField(max_length=255, null=True)
    last_login = models.DateTimeField(auto_now_add=True)
    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)
    objects = managers.UserManager()

    USERNAME_FIELD = 'phone_number'
    REQUIRED_FIELDS = []

    def __str__(self) -> str:
        return self.phone_number


class Otp(models.Model):
    verification_code = models.CharField(max_length=255)
    phone_number = models.CharField(max_length=12)
    valid_from = models.DateTimeField(null=True)
    valid_till = models.DateTimeField(null=True)
    user = models.OneToOneField(
        User, on_delete=models.CASCADE, related_name='otp', null=True)

    def generate_verification_code(self):
        code = ''.join(random.choices(string.digits, k=4))
        hashed_code = bcrypt.hashpw(code.encode(
            'utf-8'), bcrypt.gensalt())
        self.verification_code = hashed_code.decode('utf-8')
        self.valid_from = timezone.now()
        self.valid_till = timezone.now() + timedelta(minutes=2)
        self.save()
        return code

    def check_verification_code(self, code: str):
        return bcrypt.checkpw(code.encode('utf-8'), self.verification_code.encode('utf-8'))

    def send_sms(self, to, code):
        try:
            username = settings.OTP_SERVICE_USERNAME
            password = settings.OTP_SERVICE_PASSWORD
            text = code
            bodyId = 159910

            response = requests.get(
                f'https://api.payamak-panel.com/post/Send.asmx/SendByBaseNumber2?username={username}&password={password}&text={text}&to={to}&bodyId={bodyId}'
            )
            print(response.status_code)
        except Exception as e:
            print(e)

    def __str__(self) -> str:
        return self.phone_number
