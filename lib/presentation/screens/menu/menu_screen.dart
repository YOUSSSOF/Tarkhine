import 'package:flutter/material.dart';
import 'package:tarkhine/common/common.dart';
import 'package:tarkhine/core/core.dart';
import 'package:tarkhine/data/models/food_model.dart';
import 'widgets/menu_body.dart';
import 'widgets/menu_body_section.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    final List<FoodModel>? menuFoods = context.deliveryWatch.state.menuFoods;
    return DefaultTabController(
      length: 4,
      child: RefreshIndicator(
        onRefresh: () => context.delivery.fetchMenuItems(reFeth: true),
        child: Scaffold(
          appBar: const YxAppbar(
            title: 'منوی رستوران',
          ),
          body: SingleChildScrollView(
            child: DefaultTabController(
              initialIndex: title == 'غذای اصلی'
                  ? 3
                  : title == 'پیش غذا'
                      ? 2
                      : title == 'دسر'
                          ? 1
                          : 0,
              length: 4,
              child: Column(
                children: [
                  Container(
                    color: const Color(0xFFEDEDED),
                    child: const TabBar(
                      indicatorWeight: 1,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: AppColor.primary,
                      labelColor: AppColor.primary,
                      unselectedLabelColor: Color(0xFF717171),
                      labelStyle: TextStyle(
                        fontFamily: 'Estedad',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontFamily: 'Estedad',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      tabs: [
                        Tab(text: 'نوشیدنی'),
                        Tab(text: 'دسر'),
                        Tab(text: 'پیش غذا'),
                        Tab(text: 'غذای اصلی'),
                      ],
                    ),
                  ),
                  TabBarView(
                    children: [
                      MenuBody(
                        sections: [
                          MenuBodySection(
                            title: 'نوشیدنی',
                            items: menuFoods.filterWithTag(FoodTag.persian),
                          ),
                        ],
                      ),
                      MenuBody(
                        sections: [
                          MenuBodySection(
                            title: 'دسر',
                            items: menuFoods.filterWithTag(FoodTag.persian),
                          ),
                        ],
                      ),
                      MenuBody(
                        sections: [
                          MenuBodySection(
                            title: 'پیش غذا',
                            items: menuFoods.filterWithTag(FoodTag.pizza),
                          ),
                        ],
                      ),
                      MenuBody(
                        sections: [
                          MenuBodySection(
                            title: 'غذاهای ایرانی',
                            items: menuFoods.filterWithTag(FoodTag.persian),
                          ),
                          MenuBodySection(
                            title: 'غذاهای غیر ایرانی',
                            items: menuFoods.filterWithTag(FoodTag.nonPersian),
                          ),
                          MenuBodySection(
                            title: 'پیتزاها',
                            items: menuFoods.filterWithTag(FoodTag.pizza),
                          ),
                          MenuBodySection(
                            title: 'ساندویچ ها',
                            items: menuFoods.filterWithTag(FoodTag.sandwich),
                          ),
                        ],
                      ),
                    ],
                  ).sizedBox(height: context.height),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
