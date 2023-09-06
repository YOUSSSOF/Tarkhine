from django.db.models.signals import post_save
from django.dispatch import receiver
from authentication import models as auth_models
from delivery import models as api_models


@receiver(post_save, sender=auth_models.User)
def user_created(sender, instance: auth_models.User, created, **kwargs):
    if created:
        cart = api_models.Cart.objects.create(user=instance)
        cart.save()
        wishlist = api_models.WishList.objects.create(user=instance)
        wishlist.save()
