import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarkhine/common/common.dart';
import 'package:tarkhine/common/widgets/yx_loader.dart';
import 'package:tarkhine/core/core.dart';
import 'package:tarkhine/logic/cubits/cart_cubit.dart';
import 'widgets/cart_is_empty.dart';
import 'widgets/cart_main_section.dart';
import 'widgets/cart_status_section.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.cart.fetchCartData(context.auth.user!),
      child: BlocConsumer<CartCubit, CartState>(
        buildWhen: (previous, current) => current is! CartActionState,
        listenWhen: (previous, current) => current is CartActionState,
        listener: (context, state) {
          switch (state.runtimeType) {
            case CartAddedFoodActionState:
              showSnackbar(context, 'با موفقیت به سبد خرید افزوده شد.',
                  SnackBarType.success);
          }
        },
        builder: (context, state) {
          if (state is CartLoadingState) {
            return const YxLoader();
          } else if (context.cart.cart.items.isEmpty) {
            return const CartIsEmpty(
              title: 'شما در حال حاضر هیچ محصولی به سبد خرید اضافه نکرده‌اید!',
            );
          }
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CartStatusSection(
                status: CartStatus.cart,
              ).marginOnly(bottom: 25),
              const CartMainSection(),
            ],
          );
        },
      ),
    );
  }
}
