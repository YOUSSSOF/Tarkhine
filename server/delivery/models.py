from django.db import models
from django.contrib.auth import get_user_model
from django.core import validators


class Food(models.Model):
    FOOD_TAGS = (
        ('normal', 'normal'),
        ('plate', 'plate'),
        ('inMenu', 'inMenu'),
        ('special', 'special'),
        ('favorite', 'favorite'),
        ('persian', 'persian'),
        ('nonPerisan', 'nonPerisan'),
        ('pizza', 'pizza'),
        ('sandwich', 'sandwich'),
    )
    name = models.CharField(max_length=100)
    content = models.CharField(max_length=255)
    price = models.BigIntegerField()
    comments = models.PositiveIntegerField(default=0)
    score = models.PositiveSmallIntegerField(
        default=0, validators=[validators.MaxValueValidator(5)])
    thumbnail = models.ImageField(upload_to='pics', null=True)
    discount = models.PositiveSmallIntegerField(
        default=0, validators=[validators.MaxValueValidator(100)])
    food_tag = models.CharField(
        choices=FOOD_TAGS, max_length=10, default='normal')
    is_liked = models.BooleanField(default=False)

    def __str__(self) -> str:
        return self.name


class FoodCover(models.Model):
    image = models.ImageField(upload_to='pics')
    food = models.ForeignKey(
        Food, on_delete=models.CASCADE, related_name='covers')


class Cart(models.Model):
    user = models.OneToOneField(get_user_model(), on_delete=models.CASCADE)

    def __str__(self) -> str:
        return self.user.phone_number


class CartItem(models.Model):
    quantity = models.PositiveIntegerField(default=1)
    cart = models.ForeignKey(
        Cart, on_delete=models.CASCADE, related_name='items')
    food = models.ForeignKey(Food, on_delete=models.CASCADE)


class Order(models.Model):
    ORDER_STATUSES = (
        ('pending', 'pending'),
        ('canceled', 'canceled'),
        ('delivered', 'delivered'),
    )
    order_date = models.DateTimeField(auto_now=True)
    address = models.CharField(max_length=255)
    order_status = models.CharField(
        max_length=10, choices=ORDER_STATUSES, default='pending')
    deliver_with_delivery = models.BooleanField(default=True)
    user = models.ForeignKey(get_user_model(), on_delete=models.CASCADE)


class OrderItem(models.Model):
    quantity = models.PositiveIntegerField(default=1)
    food = models.ForeignKey(Food, on_delete=models.CASCADE)
    order = models.ForeignKey(
        Order, on_delete=models.CASCADE, related_name='items')
