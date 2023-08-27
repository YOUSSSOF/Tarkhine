from rest_framework import serializers, validators
from authentication import models
from api import models as api_models
from api import serializers as api_serializers


class UserSerializer(serializers.ModelSerializer):
    cart = api_serializers.CartSerializer()

    class Meta:
        model = models.User
        fields = ['id', 'last_login', 'phone_number', 'first_name',
                  'last_name', 'email', 'birth', 'username', 'address', 'cart']


class UserCreateSerializer(serializers.ModelSerializer):
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
        cart = api_models.Cart.objects.create(user=user)
        cart.save()

        return user
