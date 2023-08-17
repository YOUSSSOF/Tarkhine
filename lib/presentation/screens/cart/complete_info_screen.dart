import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tarkhine/common/common.dart';
import 'package:tarkhine/core/core.dart';
import 'package:tarkhine/presentation/screens/cart/checkout_screen.dart';
import 'package:tarkhine/presentation/screens/cart/widgets/cart_status_section.dart';
import 'widgets/addresses.dart';
import 'widgets/send_option.dart';

class CompleteInfoScreen extends StatelessWidget {
  CompleteInfoScreen({
    Key? key,
  }) : super(key: key);
  final BehaviorSubject<bool> sendWithDelivery = BehaviorSubject.seeded(true);
  final BehaviorSubject<List<String>> addresses = BehaviorSubject.seeded([]);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: sendWithDelivery.stream,
        builder: (context, snapshot) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              appBar: const YxAppbar(
                title: 'تکمیل اطلاعات',
              ),
              body: Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const CartStatusSection(status: CartStatus.completeInfo)
                          .marginV(25),
                      YxSideBorder(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const YxText(
                                  'روش تحویل سفارش',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                const Icon(Iconsax.truck).marginOnly(left: 10),
                              ],
                            ),
                            const YxSeprator(),
                            SendOption(
                              delivery: true,
                              sendWithDelivery: sendWithDelivery,
                              title: 'ارسال توسط پیک',
                              icon: Iconsax.truck_fast,
                            ),
                            SendOption(
                              delivery: false,
                              sendWithDelivery: sendWithDelivery,
                              title: 'تحویل حضوری',
                              icon: Iconsax.shopping_bag,
                            ),
                          ],
                        ),
                      ),
                      if (sendWithDelivery.value)
                        Addresses(
                          addresses: addresses,
                        ).marginOnly(top: 20),
                      if (!sendWithDelivery.value)
                        YxSideBorder(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const YxText(
                                    'آدرس شعبه اکباتان',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  const Icon(Iconsax.location)
                                      .marginOnly(left: 10),
                                ],
                              ),
                              const YxSeprator(),
                              const YxText(
                                  'شهرک اکباتان، فاز ۳، مجتمع تجاری کوروش، طبقه سوم'),
                              const YxText('شماره تماس: ۰۲۱-۵۴۸۹۱۲۵۰-۵۱'),
                              const YxText(
                                  'ساعت کاری: همه‌روزه از ساعت ۱۲ تا ۲۳ بجز روزهای تعطیل'),
                            ],
                          ),
                        ).marginOnly(top: 20),
                      YxField(
                        hint: 'توضیحات سفارش',
                        controller: TextEditingController(),
                        height: context.percentHeight(10),
                        width: context.percentWidth(90),
                        keyboardType: TextInputType.multiline,
                        maxLines: 8,
                      ).marginV(20),
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
                            if (sendWithDelivery.value) const YxSeprator(),
                            if (sendWithDelivery.value)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                  '${'${sendWithDelivery.value ? context.cart.calculateTotalCartPrice() + 29000 : context.cart.calculateTotalCartPrice()}'.makePersian}  تومان',
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
                              title: 'ثبت سفارش',
                              onPressed: () => context.to(
                                BlocProvider.value(
                                  value: context.cart,
                                  child: CheckoutScreen(
                                    sendWithDelivery: sendWithDelivery.value,
                                  ),
                                ),
                              ),
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
        });
  }
}
