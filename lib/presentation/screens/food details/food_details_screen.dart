import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tarkhine/common/common.dart';
import 'package:tarkhine/core/core.dart';
import 'package:tarkhine/data/models/food_model.dart';
import 'package:tarkhine/logic/cubits/cart_cubit.dart';
import 'package:tarkhine/logic/cubits/delivery_cubit.dart';

class FoodDetailsScreen extends StatelessWidget {
  FoodDetailsScreen({
    Key? key,
    required this.food,
  }) : super(key: key);
  final FoodModel food;

  final BehaviorSubject<int> index = BehaviorSubject()..add(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const YxAppbar(
        title: 'جزئیات محصول',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: PageView.builder(
                    reverse: true,
                    itemCount: food.covers?.length ?? 1,
                    onPageChanged: (value) => index.add(value),
                    itemBuilder: (context, index) => Hero(
                      tag: food.id,
                      child: Image.asset(
                        food.covers?[index] ?? Assets.images.notFound,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                food.covers.nullOrNot
                    ? Container()
                    : Align(
                        alignment: Alignment.bottomCenter,
                        child: StreamBuilder<Object>(
                            stream: index.stream,
                            builder: (context, snapshot) {
                              return DotsIndicator(
                                reversed: true,
                                dotsCount: food.covers!.length,
                                position: index.value,
                                decorator: const DotsDecorator(
                                  activeColor: AppColor.white,
                                  activeSize: Size(12, 12),
                                ),
                              );
                            }),
                      ).marginOnly(bottom: 10),
              ],
            )
                .sizedBox(
                  width: context.percentWidth(90),
                  height: context.percentWidth(50),
                )
                .marginOnly(
                  top: context.percentWidth(5),
                )
                .center,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.nav.changeIndex(2);
                        context.toFirst();
                      },
                      icon: Icon(
                        Iconsax.shopping_cart,
                        color: AppColor.black.withOpacity(.6),
                      ),
                    ),
                    BlocBuilder<DeliveryCubit, DeliveryState>(
                      builder: (context, state) {
                        return IconButton(
                          onPressed: () => context.delivery.likeFood(food),
                          icon: Icon(
                            food.isLiked ? Iconsax.heart5 : Iconsax.heart,
                            color: food.isLiked
                                ? AppColor.errorLight
                                : AppColor.black.withOpacity(.6),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const Spacer(),
                YxText(
                  food.name,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ).marginH(context.percentWidth(5)).marginOnly(top: 12),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  width: 1,
                  color: AppColor.black.withOpacity(.5),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const YxText(
                    'محتویات',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ).marginOnly(bottom: 8),
                  YxText(
                    food.content,
                    color: AppColor.black.withOpacity(.8),
                  ),
                  const YxSeprator(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          for (int i = 0; i < food.score; i++) const YxStar(5),
                          for (int i = 0; i < 5 - food.score; i++)
                            const YxStar(0),
                          YxText('(${food.comments} نظر)').marginOnly(left: 3),
                        ],
                      ),
                      const YxText(
                        'امتیاز',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  const YxSeprator(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      YxText(
                        '${food.showPrice} تومان',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      const YxText(
                        'قیمت',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ],
              ).padding(8),
            )
                .sizedBox(
                  width: context.percentWidth(90),
                )
                .marginOnly(top: 17, bottom: 24),
            BlocBuilder<CartCubit, CartState>(builder: (context, state) {
              if (state is CartItemLoadingState && food.id == state.foodId ||
                  state is CartLoadingState ||
                  context.cart.isInCart(food).$1.nullOrNot) {
                return const YxLoader(
                  size: 20,
                ).marginOnly(bottom: 20);
              } else if (context.cart.isInCart(food).$1 &&
                  !context.cart.isInCart(food).$2.nullOrNot) {
                return YxQuantityButton(
                  current: context.cart.isInCart(food).$2!,
                );
              } else {
                return YxButton(
                  title: 'افزودن به سبد خرید',
                  onPressed: () => context.cart.addToCart(food),
                  width: double.infinity,
                  height: 35,
                  fontSize: 12,
                ).margin(20);
              }
            }),
          ],
        ),
      ),
    );
  }
}
