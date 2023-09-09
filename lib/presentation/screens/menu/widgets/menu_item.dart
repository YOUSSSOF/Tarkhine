import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tarkhine/common/common.dart';
import 'package:tarkhine/core/core.dart';

import '../../../../data/models/food_model.dart';
import '../../../../logic/cubits/cart_cubit.dart';
import '../../food details/food_details_screen.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.food,
  });
  final FoodModel food;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: const Color(0xFFCBCBCB),
            ),
          ),
          height: context.percentWidth(30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              food.discount == 0
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        YxText('${food.showPrice} تومان').marginOnly(bottom: 5),
                        if (state is CartItemsLoadingState &&
                                food.id == state.foodId ||
                            state is CartLoadingState ||
                            context.cart.nullOrNot ||
                            context.cart.isInCart(food).$1.nullOrNot)
                          const YxLoader(
                            size: 20,
                          ).marginOnly(bottom: 20)
                        else if (context.cart.isInCart(food).$1 &&
                            !context.cart.isInCart(food).$2.nullOrNot)
                          YxQuantityButton(
                            current: context.cart.isInCart(food).$2!,
                          )
                        else
                          YxButton(
                            title: 'افزودن به سبد خرید',
                            fontSize: 10,
                            onPressed: () {},
                          ).marginOnly(bottom: 5),
                      ],
                    ).margin(10)
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColor.errorExtraLight,
                              ),
                              child: YxText(
                                '%${food.discountInP}',
                                color: AppColor.error,
                              ).paddingH(8),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            YxText(
                              food.showPrice,
                              lineThrough: true,
                              color: AppColor.black.withOpacity(0.7),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        YxText('${food.showPriceWithDiscount} تومان'),
                        if (state is CartItemsLoadingState &&
                                food.id == state.foodId ||
                            state is CartLoadingState ||
                            context.cart.isInCart(food).$1.nullOrNot)
                          const YxLoader(
                            size: 20,
                          ).marginOnly(bottom: 5, left: 10).center
                        else if (context.cart.isInCart(food).$1 &&
                            !context.cart.isInCart(food).$2.nullOrNot)
                          YxQuantityButton(
                            current: context.cart.isInCart(food).$2!,
                          )
                        else
                          YxButton(
                            title: 'افزودن به سبد خرید',
                            fontSize: 10,
                            onPressed: () => context.cart
                                .addToCart(food, context.auth.user!),
                          ).sizedBox(height: 32),
                      ],
                    ).margin(10),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  YxText(
                    food.name,
                    fontSize: 12,
                  ).sizedBox(width: 100),
                  YxText(
                    food.content,
                    fontSize: 10,
                  ).sizedBox(width: context.percentWidth(20)).marginV(3),
                  Row(
                    children: [
                      for (int i = 0; i < food.score; i++) const YxStar(5),
                      for (int i = 0; i < 5 - food.score; i++) const YxStar(0),
                      IconButton(
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                        onPressed: () => context.delivery.likeFood(food),
                        icon: Icon(
                          food.isLiked ? Iconsax.heart5 : Iconsax.heart,
                          color: food.isLiked
                              ? AppColor.errorLight
                              : AppColor.black.withOpacity(.3),
                          size: 16,
                        ).marginOnly(left: 5),
                      ),
                    ],
                  ),
                ],
              ).marginOnly(right: 8).paddingV(10),
              GestureDetector(
                onTap: () => context.to(
                  MultiBlocProvider(
                    providers: [
                      BlocProvider.value(value: context.cart),
                      BlocProvider.value(value: context.delivery),
                    ],
                    child: FoodDetailsScreen(
                      food: food,
                    ),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    food.thumbnail ?? Assets.images.notFound,
                    width: context.percentWidth(30),
                    height: context.percentWidth(30),
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                      Assets.images.notFound,
                      fit: BoxFit.cover,
                      width: context.percentWidth(30),
                      height: context.percentWidth(30),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ).marginOnly(top: 12);
  }
}
