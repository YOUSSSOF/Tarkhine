from database.database import Base
from sqlalchemy import Column, String, Integer, DateTime, Enum, ForeignKey, Date, Boolean, Float, ARRAY
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from utils.enums import *


class UserModel(Base):
    __tablename__ = 'users'
    id = Column(Integer, primary_key=True, index=True)
    phone_number = Column(String)
    first_name = Column(String)
    last_name = Column(String)
    email = Column(String)
    birth = Column(Date)
    username = Column(String, default='کاربر ترخینه')
    address = Column(String)

    cart = relationship('CartModel', back_populates='user')


class FoodModel(Base):
    __tablename__ = 'foods'
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String)
    content = Column(String)
    price = Column(Float)
    comments = Column(Integer)
    score = Column(Integer)
    thumbnail = Column(String)
    covers = Column(ARRAY(String))
    discount = Column(Float)
    food_tag = Column(Enum(FoodTag), default=FoodTag.normal)
    is_liked = Column(Boolean, default=False)
    cart_items = relationship('CartItemModel', back_populates='food')
    order_items = relationship('OrderItemModel', back_populates='food')


class CartModel(Base):
    __tablename__ = 'carts'
    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey('users.id'))

    items = relationship('CartItemModel', back_populates='cart')
    user = relationship('UserModel', back_populates='cart', uselist=False)


class CartItemModel(Base):
    __tablename__ = 'cart_items'
    id = Column(Integer, primary_key=True, index=True)
    cart_id = Column(Integer, ForeignKey('carts.id'))
    food_id = Column(Integer, ForeignKey('foods.id'))
    quantity = Column(Integer, default=1)

    cart = relationship('CartModel', back_populates='items')
    food = relationship('FoodModel', back_populates='cart_items')


class OrderModel(Base):
    __tablename__ = 'orders'
    id = Column(Integer, primary_key=True, index=True)
    order_date = Column(DateTime(timezone=True), server_default=func.now())
    address = Column(String)
    order_status = Column(Enum(OrderStatus))
    deliver_with_delivery = Column(Boolean, default=True)

    items = relationship('OrderItemModel', back_populates='order')


class OrderItemModel(Base):
    __tablename__ = 'order_items'
    id = Column(Integer, primary_key=True, index=True)
    quantity = Column(Integer, default=1)
    food_id = Column(Integer, ForeignKey('foods.id'))
    order_id = Column(Integer, ForeignKey('orders.id'))
    food = relationship('FoodModel', back_populates='order_items')
    order = relationship('OrderModel', back_populates='items')


