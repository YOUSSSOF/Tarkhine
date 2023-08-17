import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tarkhine/core/themes/app_colors.dart';

import '../../../../common/common.dart';

class SendOption extends StatelessWidget {
  const SendOption({
    Key? key,
    required this.sendWithDelivery,
    required this.delivery,
    required this.title,
    required this.icon,
  }) : super(key: key);
  final bool delivery;
  final BehaviorSubject<bool> sendWithDelivery;
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(icon).marginH(10),
        YxText(title),
        Checkbox(
          checkColor: AppColor.white,
          value: delivery ? sendWithDelivery.value : !sendWithDelivery.value,
          shape: const CircleBorder(),
          onChanged: (value) =>
              sendWithDelivery.add(delivery ? value! : !value!),
        ),
      ],
    );
  }
}
