import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tarkhine/common/common.dart';
import 'package:tarkhine/core/core.dart';
import 'package:tarkhine/data/repositories/config.dart';
import 'package:tarkhine/presentation/screens/food%20details/food_details_screen.dart';

import '../../../../data/models/order_model.dart';

class OrderCard extends StatelessWidget {
  OrderCard({
    Key? key,
    required this.order,
  }) : super(key: key);
  final OrderModel order;
  final BehaviorSubject<bool> showMore = BehaviorSubject.seeded(false);
  @override
  Widget build(BuildContext context) {
    return YxSideBorder(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: order.orderStatus == OrderStatus.pending
                          ? AppColor.warningExtraLight
                          : order.orderStatus == OrderStatus.delivered
                              ? AppColor.successExtraLight
                              : AppColor.errorExtraLight,
                    ),
                    child: YxText(
                      order.orderStatus == OrderStatus.pending
                          ? 'جاری'
                          : order.orderStatus == OrderStatus.delivered
                              ? 'تحویل شده'
                              : 'لغو شده',
                      fontSize: 10,
                    ).paddingV(3).paddingH(20),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: const Color(0xFFEDEDED),
                    ),
                    child: YxText(
                      order.deliverWithDelivery ? 'پیک' : 'تحویل حضوری',
                      fontSize: 10,
                    ).padding(3),
                  ).marginOnly(left: 5),
                ],
              ),
              const YxText(
                'شعبه اقدسیه',
                color: Color(0xFF757575),
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              YxIconText(
                icon: Iconsax.clock,
                text: 'آماده تحویل تا ۲۵:۳۳',
              ),
              YxIconText(
                icon: Iconsax.calendar,
                text: 'شنبه، ۸ مرداد، ساعت ۱۸:۵۳',
              ),
            ],
          ).marginOnly(top: 10),
          YxIconText(
            icon: Iconsax.location,
            text: order.address,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              YxIconText(
                icon: Iconsax.wallet,
                text:
                    '${context.order.calculateTotalOrderPrice(order).toString().makePersian} تومان   ${context.order.calculateDiscountOrderPrice(order).toString().makePersian} تومان ',
              ),
            ],
          ),
          SvgPicture.asset(
            order.orderStatus == OrderStatus.pending
                ? Assets.vectors.orderStatus1
                : order.orderStatus == OrderStatus.delivered
                    ? Assets.vectors.orderStatus3
                    : Assets.vectors.orderStatus2,
          ).marginOnly(top: 15),
          StreamBuilder<bool>(
            stream: showMore.stream,
            builder: (context, snapshot) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  mainAxisSpacing: 10,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: showMore.value && order.items.length >= 3
                    ? order.items.length
                    : order.items.length < 3
                        ? order.items.length
                        : 3,
                itemBuilder: (context, index) {
                  final OrderItemModel current = order.items[index];
                  return GestureDetector(
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
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color(0xFFCBCBCB),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(8),
                              topLeft: Radius.circular(8),
                            ),
                            child: Stack(
                              children: [
                                Image.network(
                                  Repository.serverUrl +
                                      current.food.thumbnail!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.asset(
                                    Assets.images.notFound,
                                    fit: BoxFit.cover,
                                    height: 50,
                                    width: 100,
                                  ),
                                  height: 50,
                                  width: 100,
                                ),
                                Positioned(
                                  bottom: 3,
                                  left: 3,
                                  child: Container(
                                    width: 18,
                                    height: 18,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: AppColor.white,
                                    ),
                                    child: YxText(
                                      'x${current.quantity.toString().makePersian}',
                                      fontSize: 10,
                                      color: AppColor.primary,
                                    ).center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          YxText(
                            current.food.name,
                            fontSize: 10,
                          ),
                          YxText(
                            '${current.food.price.toString().makePersian} تومان',
                            fontSize: 10,
                          ),
                        ],
                      ),
                    ).margin6,
                  );
                },
              ).marginOnly(top: 20);
            },
          ),
          if (order.items.length > 3)
            StreamBuilder<bool>(
              stream: showMore.stream,
              builder: (context, snapshot) {
                return TextButton(
                  onPressed: () => showMore.add(!showMore.value),
                  child: YxText(
                    showMore.value ? 'مشاهده کمتر' : 'مشاهده همه سفارشات',
                    color: AppColor.primary,
                    fontSize: 10,
                  ),
                );
              },
            ),
          if (order.orderStatus == OrderStatus.pending)
            YxOutlinedButton(
              onPressed: () => context.order.deleteOrder(order),
              title: 'لغو سفارش',
              color: AppColor.error,
            ),
          if (order.orderStatus == OrderStatus.delivered ||
              order.orderStatus == OrderStatus.canceled)
            YxOutlinedButton(
              onPressed: () {},
              title: 'سفارش مجدد',
            )
        ],
      ),
    );
  }
}
