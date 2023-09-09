from django.shortcuts import render
from rest_framework import viewsets, permissions, response, status, generics, views
from django.db.models import Max
from delivery import models, serializers
from rest_framework.filters import SearchFilter

# General APIs for controlling over models crud system


class FoodViewSet(viewsets.ModelViewSet):
    serializer_class = serializers.FoodSerializer
    filter_backends = [SearchFilter]
    search_fields = ['name', 'content']

    def get_queryset(self):
        max = self.request.query_params.get('max')
        is_liked = self.request.query_params.get('is_liked')
        try:
            queryset = models.Food.objects.all().order_by('?')
            if is_liked:
                queryset = queryset.filter(is_liked=is_liked == 'true')
            if max:
                queryset = queryset.all()[:int(max)]
            return queryset
        except:
            return models.Food.objects.all()

    def get_permissions(self):
        if self.request.method == 'GET':
            self.permission_classes = []
        else:
            self.permission_classes = [permissions.IsAdminUser]
        return super(FoodViewSet, self).get_permissions()


class CartViewSet(viewsets.ModelViewSet):
    queryset = models.Cart.objects.all()
    serializer_class = serializers.CartSerializer
    permission_classes = [permissions.IsAdminUser]


class CartItemViewSet(viewsets.ModelViewSet):
    permission_classes = [permissions.IsAdminUser]

    def get_queryset(self):
        return models.CartItem.objects.filter(cart=self.kwargs['cart_pk'])

    def get_serializer_context(self):
        return {'cart_id': self.kwargs['cart_pk']}

    def get_serializer_class(self, *args, **kwargs):
        if self.request.method == 'POST':
            return serializers.CartItemCreateSerializer
        return serializers.CartItemSerializer


class OrderViewSet(viewsets.ModelViewSet):
    queryset = models.Order.objects.all()
    permission_classes = [permissions.IsAdminUser]

    def get_serializer_class(self, *args, **kwargs):
        if self.request.method == 'POST':
            return serializers.OrderCreateSerializer
        return serializers.OrderSerializer

# Specific APIs for getting current user info


class CurrentCartView(generics.GenericAPIView):
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request):
        user = request.user
        cart = models.Cart.objects.filter(
            user=user).prefetch_related('items').first()
        return response.Response(
            data=serializers.CartSerializer(cart).data
        )


class CurrentCartItemsViewSet(viewsets.ModelViewSet):
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        cart = models.Cart.objects.filter(
            user=self.request.user).prefetch_related('items').first()
        return models.CartItem.objects.filter(cart=cart).select_related('cart')

    def get_serializer_class(self, *args, **kwargs):
        if self.request.method == 'POST':
            return serializers.CartItemCreateSerializer
        return serializers.CartItemSerializer

    def destroy(self, request, *args, **kwargs):
        item: models.CartItem = self.get_object()
        if item.quantity > 1:
            item.quantity = item.quantity - 1
            item.save()
            return response.Response(serializers.CartItemSerializer(item).data)
        else:
            item.delete()
            return response.Response(status=status.HTTP_204_NO_CONTENT)

    def get_serializer_context(self):
        cart = models.Cart.objects.filter(
            user=self.request.user).prefetch_related('items').first()
        return {'cart_id': cart.id}


class CurrentOrderView(generics.GenericAPIView):
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        return models.Order.objects.filter(user=self.request.user).prefetch_related('items')

    def get_serializer_class(self, *args, **kwargs):
        if self.request.method == 'POST':
            return serializers.OrderCreateSerializer
        return serializers.OrderSerializer

    def get(self, request):
        user = request.user
        orders = models.Order.objects.filter(user=user)
        return response.Response(
            data=serializers.OrderSerializer(orders, many=True).data
        )

    def post(self, request):
        order = serializers.OrderCreateSerializer(data=request.data)
        if order.is_valid():
            instance = order.save()
            return response.Response(order.data, status=status.HTTP_201_CREATED)
        return response.Response(order.errors, status=status.HTTP_201_CREATED)


class CurrentWishListView(generics.GenericAPIView):
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request):
        user = request.user
        wishlist = models.WishList.objects.filter(
            user=user).prefetch_related('items').first()

        return response.Response(
            data=serializers.WishListSerializer(wishlist).data
        )


class CurrentWishListItemsViewSet(viewsets.ModelViewSet):
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        wishlist = models.WishList.objects.filter(
            user=self.request.user).prefetch_related('items').first()
        return models.WishListItem.objects.filter(wishlist=wishlist).select_related('wishlist')

    def get_serializer_class(self, *args, **kwargs):
        if self.request.method == 'POST':
            return serializers.WishListItemCreateSerializer
        return serializers.WishListItemSerializer

    def get_serializer_context(self):
        wishlist = models.WishList.objects.filter(
            user=self.request.user).first()
        return {'wishlist_id': wishlist.id}
