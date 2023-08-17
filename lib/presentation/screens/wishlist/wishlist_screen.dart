import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tarkhine/common/common.dart';
import 'package:tarkhine/logic/cubits/delivery_cubit.dart';
import 'package:tarkhine/presentation/screens/home/widgets/main_food_card.dart';

class WishlistScreen extends StatelessWidget {
  WishlistScreen({super.key});
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const YxAppbar(
          title: 'علاقمندی‌ها',
        ),
        body: BlocBuilder<DeliveryCubit, DeliveryState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  YxField(
                    hint: 'جستجو',
                    icon: const Icon(
                      Iconsax.search_normal,
                      size: 16,
                    ),
                    onChanged: (filter) =>
                        context.delivery.filterLikedFoods(filter!),
                    controller: searchController,
                  ),
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: .65,
                      mainAxisSpacing: 10,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: context.delivery.likedFoods.length,
                    itemBuilder: (context, index) =>
                        context.delivery.likedFoods.isEmpty
                            ? YxShimmerLoader(
                                height: context.percentHeight(150),
                                width: 150,
                                radius: BorderRadius.circular(4),
                              ).margin(16)
                            : MainFoodCard(
                                food: context.delivery.likedFoods[index],
                              ),
                  ),
                ],
              ).margin(20),
            );
          },
        ),
      ),
    );
  }
}
