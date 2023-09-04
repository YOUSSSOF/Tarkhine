from django.urls import include, path
from rest_framework.routers import DefaultRouter
from authentication import views
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView

router = DefaultRouter()
router.register(prefix=r'users', viewset=views.UserViewSet, basename='user')

urlpatterns = [
    path('', include(router.urls)),
    path('otp/request/', views.OtpView.as_view()),
    path('otp/verify/', views.OtpVerificationView.as_view()),
    path('token/', TokenObtainPairView.as_view()),
    path('token/refresh/', TokenRefreshView.as_view()),
    path('me/', views.CurrentUserView.as_view())
]
