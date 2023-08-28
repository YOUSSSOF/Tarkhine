from django.shortcuts import render
from rest_framework import viewsets
from django.db.models import Max
from api import models, serializers
from rest_framework.filters import SearchFilter

# Create your views here.


class FoodViewSet(viewsets.ModelViewSet):
    def get_queryset(self):
        max = self.request.query_params.get('max')
        is_liked = self.request.query_params.get('is_liked')
        try:
            queryset = models.Food.objects.all()
            if is_liked:
                queryset = queryset.filter(is_liked=is_liked == 'true')
            if max:
                queryset = queryset.all()[:int(max)]
            return queryset
        except:
            return models.Food.objects.all()

    serializer_class = serializers.FoodSerializer
    permission_classes = []
    filter_backends = [SearchFilter]
    search_fields = ['name', 'content']


class CartViewSet(viewsets.ModelViewSet):
    queryset = models.Cart.objects.all()
    serializer_class = serializers.CartSerializer
    permission_classes = []


class CartItemViewSet(viewsets.ModelViewSet):
    def get_queryset(self):
        return models.CartItem.objects.filter(cart=self.kwargs['cart_pk'])

    def get_serializer_context(self):
        return {'cart_id': self.kwargs['cart_pk']}

    def get_serializer_class(self, *args, **kwargs):
        if self.request.method == 'POST':
            return serializers.CartItemCreateSerializer
        return serializers.CartItemSerializer
    serializer_class = serializers.CartItemSerializer
    permission_classes = []


class OrderViewSet(viewsets.ModelViewSet):
    queryset = models.Order.objects.all()

    def get_serializer_class(self, *args, **kwargs):
        if self.request.method == 'POST':
            return serializers.OrderCreateSerializer
        return serializers.OrderSerializer
    permission_classes = []
