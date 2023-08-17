import 'package:flutter/material.dart';
import '../../../../common/common.dart';
import '../../../../common/widgets/yx_shimmer_loader.dart';
import '../../../../core/core.dart';
import '../../../../data/models/food_model.dart';
import 'home_section_title.dart';
import 'main_food_card.dart';

class MainSection extends StatelessWidget {
  const MainSection({
    Key? key,
    required this.title,
    this.isGreenTheme = false,
    required this.items,
  }) : super(key: key);
  final String title;
  final bool isGreenTheme;
  final List<FoodModel?>? items;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: isGreenTheme ? AppColor.green1 : AppColor.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          HomeSectionTitle(
            text: title,
            isGreenTheme: isGreenTheme,
          ),
          const SizedBox(height: 16),
          ListView.builder(
            reverse: true,
            scrollDirection: Axis.horizontal,
            itemCount: items == null ? 5 : items!.length,
            itemBuilder: (context, index) =>
                items == null || context.delivery.state.isLoading
                    ? YxShimmerLoader(
                        height: context.percentHeight(30),
                        width: 168,
                        radius: BorderRadius.circular(4),
                      ).marginH(16)
                    : MainFoodCard(food: items![index]!),
          ).sizedBox(
            height: context.percentHeight(33),
          ),
        ],
      ),
    );
  }
}
