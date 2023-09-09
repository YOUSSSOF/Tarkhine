import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tarkhine/common/widgets/yx_loader.dart';
import 'package:tarkhine/logic/cubits/cart_cubit.dart';
import 'package:tarkhine/presentation/screens/food%20details/food_details_screen.dart';
import '../../../../common/common.dart';
import '../../../../core/core.dart';
import '../../../../data/models/food_model.dart';

class MainFoodCard extends StatelessWidget {
  const MainFoodCard({
    Key? key,
    required this.food,
  }) : super(key: key);
  final FoodModel food;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return InkWell(
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
            child: Container(
              color: AppColor.white,
              height: 240,
              width: 177,
              child: Column(
                children: [
                  Hero(
                    tag: food.id,
                    child: Image.network(
                      food.thumbnail ?? Assets.images.notFound,
                      height: 109,
                      fit: BoxFit.cover,
                      width: context.width,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                        Assets.images.notFound,
                        fit: BoxFit.cover,
                        height: 109,
                        width: context.width,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  YxText(
                    food.name,
                    fontSize: 12,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        food.discount == 0
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  YxText('${food.showPrice} تومان'),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                ],
                              ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              constraints: const BoxConstraints(),
                              padding: EdgeInsets.zero,
                              onPressed: () => context.delivery.likeFood(food),
                              icon: Icon(
                                food.isLiked ? Iconsax.heart5 : Iconsax.heart,
                                color: food.isLiked
                                    ? AppColor.errorLight
                                    : AppColor.black.withOpacity(.3),
                              ),
                            ),
                            Row(
                              children: [
                                YxText(food.score.toString()),
                                YxStar(food.score).marginOnly(left: 5),
                              ],
                            ).marginOnly(top: 3),
                          ],
                        ),
                      ],
                    ).marginH(15),
                  ),
                  const Spacer(),
                  if (state is CartItemsLoadingState &&
                          food.id == state.foodId ||
                      state is CartLoadingState ||
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
                      onPressed: () =>
                          context.cart.addToCart(food, context.auth.user!),
                      width: double.infinity,
                      height: 32,
                    ).margin9,
                ],
              ),
            ),
          ).card.marginH(16),
        );
      },
    );
  }
}
