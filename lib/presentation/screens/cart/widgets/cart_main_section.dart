import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tarkhine/core/core.dart';
import 'package:tarkhine/logic/cubits/cart_cubit.dart';
import 'package:tarkhine/presentation/screens/cart/complete_info_screen.dart';
import 'package:tarkhine/presentation/screens/food%20details/food_details_screen.dart';

import '../../../../common/common.dart';
import '../../../../data/models/cart_model.dart';

class CartMainSection extends StatelessWidget {
  const CartMainSection({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Align(
          alignment: Alignment.topCenter,
          child: YxSideBorder(
            child: Column(
              children: [
                ListView.builder(
                    itemCount: context.cart.cart.items.length,
                    itemBuilder: (context, index) {
                      final CartItemModel current =
                          context.cart.cart.items[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: index.isOdd
                              ? const Color(0xFFF9F9F9)
                              : const Color(0xFFEDEDED),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            YxQuantityButton(current: current),
                            const Spacer(),
                            GestureDetector(
                              onTap: () => context.to(
                                MultiBlocProvider(
                                  providers: [
                                    BlocProvider.value(value: context.cart),
                                    BlocProvider.value(value: context.delivery),
                                  ],
                                  child: FoodDetailsScreen(
                                    food: current.food,
                                  ),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  YxText(current.food.name),
                                  YxText(
                                    '${current.food.showPrice} تومان',
                                    color: const Color(0xFF717171),
                                    fontSize: 10,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ).padding(10),
                      );
                    }).sizedBox(
                  height: context.percentHeight(23),
                ),
                const YxSeprator(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    YxText(
                      '${'${context.cart.calculateDiscountCartPrice()}'.makePersian}  تومان ',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    const YxText(
                      'تخفیف محصولات',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ).vPadding6,
                const YxSeprator(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    YxText(
                      '${'29000'.makePersian}  تومان ',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    const YxText(
                      'هزینه ارسال',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ).vPadding6,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const YxText(
                      'هزینه ارسال در ادامه بر اساس آدرس، زمان و نحوه ارسال انتخابی شما محاسبه و به این مبلغ اضافه خواهد شد.',
                      color: AppColor.warning,
                      overflow: TextOverflow.visible,
                    ).sizedBox(
                      width: context.percentWidth(66),
                    ),
                    const Icon(
                      Iconsax.warning_2,
                      color: AppColor.warning,
                    ).marginOnly(left: 10),
                  ],
                ).vPadding6,
                const YxSeprator(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    YxText(
                      '${'${context.cart.calculateTotalCartPrice(withDiscount: true)}'.makePersian}  تومان',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColor.primary,
                    ),
                    const YxText(
                      'مبلغ قابل پرداخت',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ).vPadding6,
                YxButton(
                  title: 'تکمیل اطلاعات',
                  onPressed: () => context.to(
                    MultiBlocProvider(
                      providers: [
                        BlocProvider.value(value: context.cart),
                        BlocProvider.value(value: context.order)
                      ],
                      child: CompleteInfoScreen(
                        orderCubit: context.order,
                      ),
                    ),
                  ),
                  width: context.width,
                  paddingV: 8,
                ).marginOnly(top: 12),
              ],
            ),
          ).sizedBox(
            height: context.percentHeight(66),
          ),
        );
      },
    );
  }
}
