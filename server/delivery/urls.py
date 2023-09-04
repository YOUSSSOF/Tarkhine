from django.urls import include, path
from rest_framework_nested.routers import NestedDefaultRouter, DefaultRouter
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView

from delivery import views
router = DefaultRouter()
router.register(prefix=r'foods', viewset=views.FoodViewSet, basename='food')
router.register(prefix=r'carts', viewset=views.CartViewSet, basename='cart')
router.register(prefix=r'orders', viewset=views.OrderViewSet, basename='order')
router.register(prefix=r'auth/me/cart/items',
                viewset=views.CurrentCartItemsViewSet, basename='current_cart_items')

cart_items_router = NestedDefaultRouter(router, 'carts', lookup='cart')
cart_items_router.register(
    prefix=r'items', viewset=views.CartItemViewSet, basename='cartitem')

urlpatterns = [
    path('', include(router.urls)),
    path('', include(cart_items_router.urls)),
    path('auth/me/cart/', views.CurrentCartView.as_view()),
    path('auth/me/orders/', views.CurrentOrderView.as_view())
]
