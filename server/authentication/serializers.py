from rest_framework import serializers, validators
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer as BaseTokenObtainPairSerializer
from rest_framework_simplejwt.tokens import Token
from authentication import models


class UserSerializer(serializers.ModelSerializer):

    class Meta:
        model = models.User
        fields = ['id', 'last_login', 'phone_number', 'first_name',
                  'last_name', 'email', 'birth', 'username', 'address']


class UserCreateSerializers(serializers.ModelSerializer):
    phone_number = serializers.CharField(
        validators=[
            validators.UniqueValidator(
                queryset=models.User.objects.all(), message='phone number already exists.')]
    )

    class Meta:
        model = models.User
        fields = ['phone_number']

    def create(self, validated_data):
        user = models.User.objects.create(**validated_data)
        user.set_unusable_password()
        user.save()


        return user

# OTP section


class OtpRequestSerializer(serializers.Serializer):
    phone_number = serializers.CharField(max_length=12)


class OtpResponseSerializer(serializers.ModelSerializer):

    class Meta:
        model = models.Otp
        fields = ['verification_code']


class OtpVerificationRequestSerializer(serializers.Serializer):
    verification_code = serializers.CharField(max_length=5)
    phone_number = serializers.CharField(max_length=12)


class OtpVerificationResponseSerializer(serializers.ModelSerializer):
    token = serializers.CharField(max_length=255)


class TokenObtainPairSerializer(BaseTokenObtainPairSerializer):
    @classmethod
    def get_token(cls, user: models.User) -> Token:
        token = super().get_token(user)
        return token
