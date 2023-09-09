import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarkhine/common/common.dart';
import 'package:tarkhine/logic/cubits/order_cubit.dart';

import 'widgets/order_card.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderState>(
      buildWhen: (previous, current) => current is! OrderActionState,
      listenWhen: (previous, current) => current is OrderActionState,
      listener: (context, state) {},
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async =>
              {context.order.fetchOrders(context.auth.user!)},
          child: Container(
            child: context.order.orders.nullOrNot
                ? const YxLoader().center
                : ListView.builder(
                    itemCount: context.order.orders!.length,
                    itemBuilder: (_, index) => OrderCard(
                      order: context.order.orders![index],
                    ).paddingH(20).marginOnly(top: 20, bottom: 20),
                  ),
          ),
        );
      },
    );
  }
}
