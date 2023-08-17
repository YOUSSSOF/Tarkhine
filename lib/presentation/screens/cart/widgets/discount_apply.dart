import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tarkhine/common/common.dart';
import 'package:tarkhine/core/core.dart';

import '../../../../logic/cubits/cart_cubit.dart';

class DiscountApply extends StatelessWidget {
  const DiscountApply({
    super.key,
    required this.controller,
    required this.controllerText,
  });
  final TextEditingController controller;
  final BehaviorSubject controllerText;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case CartDiscountNotValidActionState:
            showSnackbar(
              context,
              'کد تخفیف معتبر نمی باشد.',
              SnackBarType.error,
            );
          case CartApplyedDiscountCodeSuccessgfullyActionState:
            showSnackbar(
              context,
              'با موفقیت اعمال شد',
              SnackBarType.success,
            );
          case CartDiscountAlreadyAppliedActionState:
            showSnackbar(
              context,
              'کد مورد نظر قبلا اعمال شده است.',
              SnackBarType.warning,
            );
        }
      },
      builder: (context, state) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const YxText(
                'ثبت کد تخفیف',
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              Tooltip(
                message:
                    'را وارد کنید TARKHINE برای مشاهده مکانیزم اعمال کد تخفیف.',
                child: const Icon(Iconsax.discount_shape).marginOnly(left: 10),
              ),
            ],
          ),
          const YxSeprator(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              state is CartApplyingDiscountCodeLoadingState
                  ? const YxLoader(
                      size: 20,
                    ).center.marginOnly(left: 20)
                  : YxButton(
                      title: 'ثبت کد',
                      height: 33,
                      width: 50,
                      onPressed: controllerText.value ||
                              state is CartDiscountAlreadyAppliedActionState
                          ? null
                          : () =>
                              context.cart.applyDiscountCode(controller.text),
                    ),
              YxField(
                hint: 'کد تخفیف',
                controller: controller,
                onChanged: (value) => controller.text.isEmpty
                    ? controllerText.add(true)
                    : controllerText.add(false),
                width: context.percentWidth(50),
                height: 33,
                textCapitalization: TextCapitalization.characters,
              ),
            ],
          ).marginOnly(top: 10),
        ],
      ),
    );
  }
}
