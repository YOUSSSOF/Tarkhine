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
    discount = models.DecimalField(decimal_places=2, max_digits=6)
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
    user = models.OneToOneField(User, on_delete=models.CASCADE)

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
    user = models.ForeignKey(User, on_delete=models.CASCADE)


class OrderItem(models.Model):
    quantity = models.PositiveIntegerField(default=1)
    food = models.ForeignKey(Food, on_delete=models.CASCADE)
    order = models.ForeignKey(
        Order, on_delete=models.CASCADE, related_name='items')
