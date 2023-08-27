from django.urls import include, path
from rest_framework.routers import DefaultRouter
from authentication import views

router = DefaultRouter()
router.register(prefix=r'users', viewset=views.UserViewSet, basename='user')

urlpatterns = [
    path('', include(router.urls)),
]
