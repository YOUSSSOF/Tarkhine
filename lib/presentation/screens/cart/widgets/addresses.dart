import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../common/common.dart';
import '../../../../core/core.dart';
import 'cart_is_empty.dart';

class Addresses extends StatelessWidget {
  const Addresses({
    super.key,
    required this.addresses,
  });
  final BehaviorSubject<List<String>> addresses;
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
                  const YxText(
                    'افزودن آدرس',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () => showSnackbar(
                      context,
                      'این بخش توسعه نیافته است.',
                      SnackBarType.warning,
                    ),
                    icon: const Icon(
                      Iconsax.add_circle,
                      color: AppColor.primary,
                    ),
                  ).marginOnly(left: 5),
                ],
              ),
              Row(
                children: [
                  const YxText(
                    'آدرس‌ها',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  const Icon(Iconsax.location).marginOnly(left: 5),
                ],
              ),
            ],
          ),
          const YxSeprator(),
          addresses.value.isEmpty
              ? const CartIsEmpty(
                  title: 'شما در حال حاضر هیچ آدرسی ثبت نکرده‌اید!',
                  height: 131,
                  width: 127,
                  menu: false,
                )
              : ListView.builder(
                  itemCount: addresses.value.length,
                  itemBuilder: (context, index) => Container(),
                ),
        ],
      ),
    );
  }
}
