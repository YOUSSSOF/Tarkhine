from django.urls import include, path
from rest_framework_nested.routers import NestedDefaultRouter, DefaultRouter


from api import views
router = DefaultRouter()
router.register(prefix=r'foods', viewset=views.FoodViewSet, basename='food')
router.register(prefix=r'carts', viewset=views.CartViewSet, basename='cart')


cart_items_router = NestedDefaultRouter(router, 'carts', lookup='cart')
cart_items_router.register(
    prefix=r'items', viewset=views.CartItemViewSet, basename='cartitem')

urlpatterns = [
    path('', include(router.urls)),
    path('', include(cart_items_router.urls)),
]
