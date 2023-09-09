import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tarkhine/common/common.dart';
import 'package:tarkhine/core/core.dart';
import 'package:tarkhine/logic/cubits/order_cubit.dart';
import 'package:tarkhine/presentation/screens/cart/widgets/cart_status_section.dart';
import 'package:tarkhine/presentation/screens/payment%20result/payment_result_screen.dart';
import 'widgets/discount_apply.dart';
import 'widgets/payment_method.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({
    Key? key,
    required this.sendWithDelivery,
    required this.orderCubit,
  }) : super(key: key);
  final bool sendWithDelivery;
  final TextEditingController discountController = TextEditingController();
  final BehaviorSubject<bool> discountControllerText =
      BehaviorSubject<bool>.seeded(true);
  final BehaviorSubject<bool> payWithCash = BehaviorSubject.seeded(true);
  final BehaviorSubject<PaymentMethods> paymentMethod =
      BehaviorSubject.seeded(PaymentMethods.saman);
  final OrderCubit orderCubit;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const YxAppbar(
          title: 'روش پرداخت',
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CartStatusSection(status: CartStatus.checkout)
                    .marginV(25),
                StreamBuilder<bool>(
                  stream: discountControllerText.stream,
                  builder: (context, snapshot) {
                    return YxSideBorder(
                      child: DiscountApply(
                        controller: discountController,
                        controllerText: discountControllerText,
                      ),
                    );
                  },
                ),
                YxSideBorder(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const YxText(
                            'روش پرداخت',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          const Icon(Iconsax.discount_shape)
                              .marginOnly(left: 10),
                        ],
                      ),
                      const YxSeprator(),
                      StreamBuilder<bool>(
                          stream: payWithCash.stream,
                          builder: (context, snapshot) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Iconsax.wallet_2),
                                    const YxText('پرداخت در محل')
                                        .marginOnly(left: 10),
                                    Checkbox(
                                      checkColor: AppColor.white,
                                      value: payWithCash.value,
                                      shape: const CircleBorder(),
                                      onChanged: (val) => payWithCash.add(val!),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Iconsax.card_pos),
                                    const YxText('پرداخت اینترنتی').marginH(3),
                                    Checkbox(
                                      checkColor: AppColor.white,
                                      value: !payWithCash.value,
                                      shape: const CircleBorder(),
                                      onChanged: (val) =>
                                          payWithCash.add(!val!),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }),
                    ],
                  ),
                ).marginV(25),
                StreamBuilder<bool>(
                    stream: payWithCash.stream,
                    builder: (context, snapshot) {
                      if (!payWithCash.value) {
                        return PaymentMethod(
                          paymentMethod: paymentMethod,
                        ).marginOnly(bottom: 25);
                      } else {
                        return Container();
                      }
                    }),
                YxSideBorder(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          YxText(
                            '${'${context.cart.calculateDiscountCartPrice()}'.makePersian}  تومان ',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF717171),
                          ),
                          const YxText(
                            'تخفیف محصولات',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      if (sendWithDelivery) const YxSeprator(),
                      if (sendWithDelivery)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            YxText(
                              '29000  تومان '.makePersian,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColor.primary,
                            ),
                            const YxText(
                              'هزینه ارسال',
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
                            '${'${sendWithDelivery ? context.cartWatch.calculateTotalCartPrice() + 29000 : context.cart.calculateTotalCartPrice()}'.makePersian}  تومان',
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
                      ),
                      YxButton(
                        title: 'تایید و پرداخت',
                        onPressed: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return const YxLoader(
                                size: 80,
                                strokeWidth: 8,
                              );
                            },
                          );
                          orderCubit
                              .postOrder(
                                  context.auth.user!,
                                  'تهران: اقدسیه، بزرگراه ارتش، مجتمع شمیران سنتر، طبقه ۱۰',
                                  sendWithDelivery)
                              .then((value) {
                            context.cart
                                .fetchCartData(context.auth.user!)
                                .then((value) {
                              context.back();
                              context.to(
                                const PaymentResultScreen(
                                  wasSuccessful: true,
                                ),
                              );
                            });
                          });
                        },
                        width: context.width,
                        paddingV: 8,
                      ).marginOnly(top: 15),
                    ],
                  ),
                ),
              ],
            ).marginOnly(bottom: 25),
          ),
        ),
      ),
    );
  }
}
