import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tarkhine/common/common.dart';
import 'package:tarkhine/core/core.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({
    super.key,
    required this.paymentMethod,
  });
  final BehaviorSubject<PaymentMethods> paymentMethod;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PaymentMethods>(
      stream: paymentMethod.stream,
      builder: (context, snapshot) {
        return YxSideBorder(
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
                  const Icon(Iconsax.card).marginOnly(left: 10),
                ],
              ),
              const YxSeprator(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BankIcon(
                    icon: Assets.images.parsian,
                    isActive: paymentMethod.value == PaymentMethods.parsian
                        ? true
                        : false,
                    onTap: () => paymentMethod.add(PaymentMethods.parsian),
                  ),
                  BankIcon(
                    icon: Assets.images.melat,
                    isActive: paymentMethod.value == PaymentMethods.melat
                        ? true
                        : false,
                    onTap: () => paymentMethod.add(PaymentMethods.melat),
                  ).hMargin9,
                  BankIcon(
                    icon: Assets.images.saman,
                    isActive: paymentMethod.value == PaymentMethods.saman
                        ? true
                        : false,
                    onTap: () => paymentMethod.add(PaymentMethods.saman),
                  ),
                ],
              ).marginOnly(top: 10, bottom: 10),
              const YxText(
                'پرداخت از طریق کلیه کارت‌های عضو شتاب امکان‌پذیر است.‌',
                fontSize: 10,
              ),
              const YxText(
                '(لطفا قبل از پرداخت فیلترشکن خود را خاموش کنید.)',
                fontSize: 10,
              ),
            ],
          ),
        );
      },
    );
  }
}

class BankIcon extends StatelessWidget {
  const BankIcon({
    super.key,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });
  final String icon;
  final bool isActive;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isActive ? AppColor.primary : AppColor.black,
          ),
          borderRadius: BorderRadius.circular(4),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: AppColor.primary.withOpacity(.2),
                    spreadRadius: 0,
                    blurRadius: 3,
                    offset: const Offset(0, 0), // changes position of shadow
                  ),
                ]
              : null,
        ),
        child: ColorFiltered(
          colorFilter: isActive
              ? const ColorFilter.mode(
                  Colors.transparent,
                  BlendMode.color,
                )
              : const ColorFilter.mode(
                  Colors.grey,
                  BlendMode.saturation,
                ),
          child: Image.asset(
            icon,
            height: 64,
            width: 64,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
