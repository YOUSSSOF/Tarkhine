from pydantic import BaseModel
from datetime import datetime
from core.enums import *


# Food Schemas


class FoodBase(BaseModel):
    name: str
    content: str
    price: float
    comments: int | None = None
    score: int
    thumbnail: str | None = None
    covers: list[str] = []
    discount: float
    food_tag: FoodTag


class FoodCreate(FoodBase):
    pass


class Food(FoodBase):
    id: int
    is_liked: bool

    class Config:
        orm_mode = True

# Cart & Cart Item Schemas


class CartItemBase(BaseModel):
    cart_id: int
    food_id: int
    quantity: int


class CartItemCreate(CartItemBase):
    pass


class CartItem(CartItemBase):
    id: int
    food: Food

    class Config:
        orm_mode = True


class CartBase(BaseModel):
    user_id: int


class CartCreate(CartBase):
    pass


class Cart(CartBase):
    id: int
    items: list[CartItem]

    class Config:
        orm_mode = True

# User Schemas


class UserBase(BaseModel):
    phone_number: str


class UserCreate(UserBase):
    pass


class User(UserBase):
    id: int
    first_name: str
    last_name: str
    email: str
    birth: datetime
    username: str
    address: str
    cart: Cart

    class Config:
        orm_mode = True

# Order & Order Item Schemas


class OrderItemBase(BaseModel):
    quantity: int
    food_id: int
    order_id: int


class OrderItemCreate(OrderItemBase):
    pass


class OrderItem(OrderItemBase):
    int: id
    food: Food

    class Config:
        orm_mode = True


class OrderBase(BaseModel):
    order_date: datetime
    address: str


class OrderCreate(OrderBase):
    pass


class Order(OrderBase):
    id: int
    order_staus: OrderStatus
    deliver_with_delivery: bool
    items: list[OrderItem]

    class Config:
        orm_mode = True
