from rest_framework import serializers, exceptions
from delivery import models


class FoodCoverSerializer(serializers.ModelSerializer):
    image = serializers.ImageField()

    class Meta:
        model = models.FoodCover
        fields = ['image']


class FoodSerializer(serializers.ModelSerializer):
    covers = serializers.SerializerMethodField('get_covers')
    price_with_discount = serializers.SerializerMethodField(
        'get_price_with_discount')

    class Meta:
        model = models.Food
        fields = ['id', 'name', 'content', 'price', 'discount', 'price_with_discount',
                  'comments', 'score', 'thumbnail', 'covers', 'food_tag']

    def get_covers(self, obj):
        covers = FoodCoverSerializer(obj.covers, many=True)
        return [cover['image'] for cover in covers.data]

    def get_price_with_discount(self, obj):
        return obj.price - ((obj.price * obj.discount)/100)


class CartItemSerializer(serializers.ModelSerializer):
    food = FoodSerializer()

    class Meta:
        model = models.CartItem
        fields = ['id', 'food', 'quantity']


class CartItemCreateSerializer(serializers.ModelSerializer):
    quantity = serializers.IntegerField(read_only=True)

    class Meta:
        model = models.CartItem
        fields = ['food', 'quantity']

    def create(self, validated_data):
        food_id = models.Food.objects.filter(
            id=validated_data['food'].id).first()
        item = models.CartItem.objects.filter(food_id=food_id).first()
        if item:
            item.quantity += 1
            item.save()
            return item
        else:
            return models.CartItem.objects.create(**validated_data, cart_id=self.context['cart_id'])


class CartSerializer(serializers.ModelSerializer):
    items = CartItemSerializer(many=True)

    class Meta:
        model = models.Cart
        fields = ['id', 'items']


class OrderItemSerializer(serializers.ModelSerializer):
    food = FoodSerializer()

    class Meta:
        model = models.OrderItem
        fields = '__all__'


class OrderSerializer(serializers.ModelSerializer):
    items = OrderItemSerializer(many=True)

    class Meta:
        model = models.Order
        fields = '__all__'


class OrderCreateSerializer(serializers.ModelSerializer):
    items = OrderItemSerializer(many=True, read_only=True)

    class Meta:
        model = models.Order
        fields = ['address', 'order_status',
                  'deliver_with_delivery', 'user', 'items']

    def create(self, validated_data):
        cart = models.Cart.objects.get(user__id=validated_data['user'].id)
        order_items = []
        order = models.Order.objects.create(
            address=validated_data['address'], user=cart.user)
        if cart.items.all().count() > 0:
            for item in cart.items.all():
                order_items.append(models.OrderItem.objects.create(
                    quantity=item.quantity, food=item.food, order=order)
                )
            order.items.set(order_items)
            order.save()
            cart.items.all().delete()
            cart.save()
            return order
        else:
            class CartIsEmpty(exceptions.APIException):
                default_detail = 'Cart is empty.'
                status_code = 400
            raise CartIsEmpty()


class WishListItemSerializer(serializers.ModelSerializer):
    food = FoodSerializer()

    class Meta:
        model = models.WishListItem
        fields = ['id', 'food']


class WishListItemCreateSerializer(serializers.ModelSerializer):

    class Meta:
        model = models.WishListItem
        fields = ['food']

    def create(self, validated_data):
        try:
            item = models.WishListItem.objects.get(food=validated_data['food'])
            if item:
                return item
        except:
            return models.WishListItem.objects.create(**validated_data, wishlist_id=self.context['wishlist_id'])


class WishListSerializer(serializers.ModelSerializer):
    items = WishListItemSerializer(many=True)

    class Meta:
        model = models.WishList
        fields = ['id', 'items']
