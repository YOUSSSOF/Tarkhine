import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:tarkhine/common/common.dart';
import 'package:tarkhine/core/constants/assets.dart';
import 'package:tarkhine/core/core.dart';

class PaymentResultScreen extends StatelessWidget {
  const PaymentResultScreen({super.key, required this.wasSuccessful});
  final bool wasSuccessful;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (wasSuccessful)
            Positioned.fill(
              child: Lottie.asset(
                Assets.lotties.success,
                repeat: false,
              ),
            ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                wasSuccessful ? Assets.vectors.success : Assets.vectors.error,
                width: 120,
                height: 120,
              ),
              YxText(
                wasSuccessful
                    ? 'پرداخت شما با موفقیت انجام شد!'
                    : 'پرداخت شما ناموفق بود!',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: wasSuccessful ? AppColor.primary : AppColor.error,
              ).marginV(16),
              YxText(
                wasSuccessful
                    ? 'کد رهگیری سفارش شما:  ۲۱۵۴۹۰۱۹'
                    : 'کد پیگیری تراکنش شما:  ۶۵۸۵۷۱۲۷',
                color: wasSuccessful ? AppColor.primary : AppColor.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  wasSuccessful
                      ? YxButton(
                          title: 'پیگیری سفارش',
                          onPressed: () {},
                        ).sizedBox(width: 160, height: 35)
                      : YxOutlinedButton(
                          title: 'پرداخت مجدد',
                          onPressed: () {
                            context.toFirst();
                            context.nav.changeIndex(4);
                          },
                        ).sizedBox(width: 160, height: 35),
                  YxOutlinedButton(
                    title: 'بازگشت به صفحه اصلی',
                    onPressed: () {
                      context.toFirst();
                      context.nav.changeIndex(4);
                    },
                  ).sizedBox(width: 160, height: 35),
                ],
              ).marginOnly(top: 50).paddingH(
                    context.percentWidth(10),
                  ),
            ],
          ).center,
        ],
      ),
    );
  }
}
