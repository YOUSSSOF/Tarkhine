import enum


class FoodTag(enum.Enum):
    normal = 'normal'
    plate = 'plate'
    in_menu = 'inMenu'
    special = 'special'
    favorite = 'favorite'
    persian = 'persian'
    non_persian = 'nonPersian'
    pizza = 'pizza'
    sandwich = 'sandwich'


class OrderStatus(enum.Enum):
    canceled = 'canceled'
    delivered = 'delivered'
    pending = 'pending'
