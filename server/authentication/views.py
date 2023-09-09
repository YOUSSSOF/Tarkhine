from django.shortcuts import render
from rest_framework import viewsets, permissions, views, response, status, decorators
from authentication import models, serializers
from authentication.utils import Utils
from datetime import timedelta
from django.utils import timezone
from rest_framework_simplejwt.tokens import RefreshToken

# Create your views here.


class UserViewSet(viewsets.ModelViewSet):

    queryset = models.User.objects.all()
    permission_classes = [permissions.IsAdminUser]

    def get_serializer_class(self):
        if self.request.method == 'POST':
            return serializers.UserCreateSerializers
        return serializers.UserSerializer


class CurrentUserView(views.APIView):
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request):
        user = serializers.UserSerializer(request.user)
        return response.Response(user.data)

    def put(self, request, format=None):
        instance = request.user
        serializer = serializers.UserSerializer(instance, data=request.data)

        if serializer.is_valid():
            serializer.save()
            return response.Response(serializer.data)
        return response.Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class OtpView(views.APIView):
    def post(self, request):
        otp_request = serializers.OtpRequestSerializer(data=request.data)
        if otp_request.is_valid():
            request_phone_number = str(otp_request.data['phone_number'])
            request_phone_number = Utils.make_phone_number_standard(
                request_phone_number)
            otp, created = models.Otp.objects.get_or_create(
                phone_number=request_phone_number)
            code = otp.generate_verification_code()
            # otp.send_sms(request_phone_number, code)
            return response.Response({'code': code}, status=status.HTTP_200_OK)
        else:
            return response.Response(data={'error': 'invalid phone number, try again.'})


class OtpVerificationView(views.APIView):
    def post(self, request):
        otp_verification_request = serializers.OtpVerificationRequestSerializer(
            data=request.data)
        if otp_verification_request.is_valid():
            request_phone_number = otp_verification_request.data['phone_number']
            request_phone_number = Utils.make_phone_number_standard(
                request_phone_number)
            request_verification_code = str(
                otp_verification_request.data['verification_code'])
            user, created = models.User.objects.get_or_create(
                phone_number=request_phone_number)
            otp = models.Otp.objects.get(
                phone_number=request_phone_number)
            otp.user = user
            otp.save()
            if otp.check_verification_code(code=request_verification_code):
                if otp.valid_from < timezone.now() < otp.valid_till:
                    if created:
                        user.set_unusable_password()
                        user.save()
                    otp.user = user
                    otp.save()
                    token = RefreshToken.for_user(user)
                    return response.Response({
                        'refresh': str(token),
                        'access': str(token.access_token),
                    })
                else:
                    return response.Response(data={'error': 'code is expired.'}, status=status.HTTP_400_BAD_REQUEST)
            else:
                return response.Response(data={'error': 'verification code is wrong.'}, status=status.HTTP_400_BAD_REQUEST)

        else:
            return response.Response(otp_verification_request.errors)
