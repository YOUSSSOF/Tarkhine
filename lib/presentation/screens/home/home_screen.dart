import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarkhine/core/core.dart';
import '../../../common/common.dart';
import '../../../logic/cubits/delivery_cubit.dart';
import 'widgets/home_section_title.dart';
import 'widgets/main_banner_slider.dart';
import 'widgets/main_section.dart';
import 'widgets/menu_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeliveryCubit, DeliveryState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: context.delivery.fetchDeliveryData,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MainBannersSlider(
                  isLoading: state.isLoading,
                  banners: state.banners,
                ).sizedBox(height: 176),
                const HomeSectionTitle(text: 'منوی رستوران').marginV(24),
                const MenuSection(),
                MainSection(
                  title: 'پیشنهاد ویژه',
                  items: state.mainFoods.filterWithTag(FoodTag.special),
                  isGreenTheme: true,
                ),
                MainSection(
                  title: 'غذاهای محبوب',
                  items: state.mainFoods.filterWithTag(FoodTag.favorite),
                  isGreenTheme: false,
                ),
                MainSection(
                  title: 'غذاهای غیر ایرانی',
                  items: state.mainFoods.filterWithTag(FoodTag.nonPersian),
                  isGreenTheme: true,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
