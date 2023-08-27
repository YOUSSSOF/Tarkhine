from rest_framework import serializers
from api import models


class FoodCoverSerializer(serializers.ModelSerializer):
    image = serializers.ImageField()

    class Meta:
        model = models.FoodCover
        fields = ['image']


class FoodSerializer(serializers.ModelSerializer):
    covers = FoodCoverSerializer(many=True)

    class Meta:
        model = models.Food
        fields = '__all__'


class CartItemSerializer(serializers.ModelSerializer):
    food = FoodSerializer()

    class Meta:
        model = models.CartItem
        fields = ['id', 'food', 'quantity']


class CartItemCreateSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.CartItem
        fields = ['food']

    def create(self, validated_data):
        food_id = models.Food.objects.filter(
            id=validated_data['food'].id).first()
        item = models.CartItem.objects.filter(food_id=food_id).first()
        if item:
            item.quantity += 1
            item.save()
            return item
        else:
            return models.CartItem.objects.create(**validated_data)


class CartSerializer(serializers.ModelSerializer):
    items = CartItemSerializer(many=True)

    class Meta:
        model = models.Cart
        fields = '__all__'
