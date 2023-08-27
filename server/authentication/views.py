from django.shortcuts import render
from rest_framework import viewsets, permissions
from authentication import models, serializers
# Create your views here.


class UserViewSet(viewsets.ModelViewSet):
    queryset = models.User.objects.all()

    def get_serializer_class(self):
        if self.request.method == 'POST':
            return serializers.UserCreateSerializer
        return serializers.UserSerializer
    permission_classes = []
