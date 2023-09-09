import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../common/common.dart';
import '../../../../data/models/food_model.dart';
import '../../../../logic/cubits/delivery_cubit.dart';
import 'menu_item.dart';

final BehaviorSubject<ScrollController> controller =
    BehaviorSubject<ScrollController>()
      ..add(ScrollController())
      ..value.addListener(_scrollListener);
void _scrollListener() {
  if (controller.value.position.extentAfter > 50) print('fuck you');
}

class MenuBodySection extends StatelessWidget {
  const MenuBodySection({
    Key? key,
    required this.title,
    required this.items,
  }) : super(key: key);
  final String title;
  final List<FoodModel>? items;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeliveryCubit, DeliveryState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          controller: controller.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              YxText(
                title,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: items?.length ?? 5,
                  itemBuilder: (context, index) {
                    return items.nullOrNot || context.delivery.state.isLoading
                        ? YxShimmerLoader(
                            radius: BorderRadius.circular(4),
                            height: 100,
                          ).marginV(12)
                        : MenuItem(food: items![index]);
                  }),
            ],
          ).marginH(20).marginV(24),
        );
      },
    );
  }
}
