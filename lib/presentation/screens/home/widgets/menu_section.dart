import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarkhine/presentation/screens/menu/menu_screen.dart';
import '../../../../core/core.dart';

import '../../../../common/common.dart';

class MenuSection extends StatelessWidget {
  const MenuSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      scrollDirection: Axis.horizontal,
      itemCount: plates.length,
      itemBuilder: (context, index) => plates[index],
    ).sizedBox(
      height: context.percentHeight(19.5),
    );
  }
}

List<Plate> plates = [
  Plate(image: Assets.images.plate1, title: 'غذای اصلی'),
  Plate(image: Assets.images.plate2, title: 'پیش غذا'),
  Plate(image: Assets.images.plate3, title: 'دسر'),
  Plate(image: Assets.images.plate4, title: 'نوشیدنی'),
];

class Plate extends StatelessWidget {
  const Plate({
    Key? key,
    required this.image,
    required this.title,
  }) : super(key: key);
  final String image;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.delivery.fetchMenuItems();
        context.to(
          BlocProvider.value(
            value: context.delivery,
            child: BlocProvider.value(
              value: context.cart,
              child: MenuScreen(
                title: title,
              ),
            ),
          ),
        );
      },
      child: SizedBox(
        width: 150,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 40),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 136,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                image,
                height: 120,
                width: 120,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 80,
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: AppColor.white,
                  ),
                  child: YxText(title).center,
                ).card,
              ),
            ),
          ],
        ),
      ).marginH(20),
    );
  }
}
