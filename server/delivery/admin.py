from django.contrib import admin
from delivery import models
# Register your models here.

admin.site.index_title = 'Tarkhine Server Admin Panel'


class FoodCoverInline(admin.TabularInline):
    model = models.FoodCover


@admin.register(models.Food)
class FoodAdmin(admin.ModelAdmin):
    inlines = [FoodCoverInline]


class CartItemInline(admin.TabularInline):
    model = models.CartItem


@admin.register(models.Cart)
class CartAdmin(admin.ModelAdmin):
    inlines = [CartItemInline]


class OrderItemInline(admin.TabularInline):
    model = models.OrderItem


@admin.register(models.Order)
class OrderAdmin(admin.ModelAdmin):
    inlines = [OrderItemInline]
