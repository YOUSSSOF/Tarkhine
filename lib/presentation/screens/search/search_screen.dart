import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tarkhine/common/common.dart';
import 'package:tarkhine/common/widgets/yx_loader.dart';
import 'package:tarkhine/core/constants/enums.dart';
import 'package:tarkhine/data/models/food_model.dart';
import 'package:tarkhine/logic/cubits/search_cubit.dart';
import 'package:tarkhine/presentation/screens/food%20details/food_details_screen.dart';

TextEditingController controller = TextEditingController();

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        buildWhen: (previous, current) => current is! SearchActionState,
        listenWhen: (previous, current) => current is SearchActionState,
        listener: (context, state) {
          switch (state.runtimeType) {
            case SearchNotFoundActionState:
              showSnackbar(context, 'چیزی یافت نشد', SnackBarType.warning);
            case SearchErrorActionState:
              showSnackbar(context, 'مشکلی پیش آمده است.', SnackBarType.error);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                YxField(
                  hint: 'جست و جو',
                  onSubmit: context.search.search,
                  controller: controller,
                  icon: const Icon(
                    Iconsax.search_normal,
                    size: 16,
                  ),
                ).marginOnly(top: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: const Icon(Iconsax.trash, size: 16),
                    ),
                    Row(
                      children: [
                        const YxText('تاریخچه جست و جو').marginOnly(right: 5),
                        const Icon(Iconsax.clock, size: 16),
                      ],
                    ),
                  ],
                ).marginH(20),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      YxChip(title: 'راتاتویی'),
                      YxChip(title: 'پاستا سبزیجات'),
                      YxChip(title: 'کالزونه اسفناج'),
                      YxChip(title: 'کوکو سبزی'),
                    ],
                  ),
                ).marginOnly(right: 20, top: 12),
                const YxSeprator().paddingH(20).marginV(5),
                state is SearchLoadingState
                    ? const YxLoader()
                        .marginOnly(top: context.percentHeight(30))
                        .center
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state is SearchSuccessState
                            ? (state).results.length
                            : 0,
                        itemBuilder: (context, index) {
                          final FoodModel current =
                              (state as SearchSuccessState).results[index];
                          return GestureDetector(
                            onTap: () => context.to(
                              MultiBlocProvider(
                                providers: [
                                  BlocProvider.value(value: context.cart),
                                  BlocProvider.value(value: context.delivery),
                                ],
                                child: FoodDetailsScreen(
                                  food: current,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    YxText(
                                      current.name,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    YxText(
                                      'در درسته غذای ${getFoodType(current.tag)}',
                                      fontSize: 10,
                                    ),
                                  ],
                                ).marginOnly(right: 12),
                                const Icon(Iconsax.search_normal, size: 16),
                              ],
                            ).margin(15),
                          );
                        },
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
