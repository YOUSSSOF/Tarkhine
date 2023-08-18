from django.db import models
from authentication.models import User


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
    price = models.DecimalField(decimal_places=2, max_digits=6)
    comments = models.PositiveIntegerField()
    score = models.PositiveSmallIntegerField()
    thumbnail = models.ImageField(upload_to='pics')
    covers = ''
    discount = models.DecimalField(decimal_places=2, max_digits=6)
    food_tag = models.CharField(
        choices=FOOD_TAGS, max_length=10, default='normal')
    is_liked = models.BooleanField(default=False)


class FoodCover(models.Model):
    image = models.ImageField(upload_to='pics')
    food = models.ForeignKey(Food, on_delete=models.CASCADE)


class Cart(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)


class CartItem(models.Model):
    quantity = models.PositiveIntegerField(default=1)
    cart = models.ForeignKey(Cart, on_delete=models.CASCADE)
    food = models.ForeignKey(Food, on_delete=models.CASCADE)


class Order(models.Model):
    ORDER_STATUSES = (
        ('canceled', 'canceled'),
        ('delivered', 'delivered'),
        ('pending', 'pending'),
    )
    order_date = models.DateTimeField(auto_now=True)
    address = models.CharField(max_length=255)
    order_status = models.CharField(max_length=10, choices=ORDER_STATUSES)
    deliver_with_delivery = models.BooleanField(default=True)
    user = models.OneToOneField(User, on_delete=models.CASCADE)


class OrderItem(models.Model):
    quantity = models.PositiveIntegerField(default=1)
    food = models.ForeignKey(Food, on_delete=models.CASCADE)
    order = models.ForeignKey(Order, on_delete=models.CASCADE)
