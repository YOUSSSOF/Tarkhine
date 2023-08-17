import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../common/common.dart';
import '../../../../core/core.dart';

class MainBannersSlider extends StatelessWidget {
  MainBannersSlider({
    Key? key,
    required this.banners,
    required this.isLoading,
  }) : super(key: key);
  final List<Banner>? banners;
  final bool isLoading;

  final BehaviorSubject<int> index = BehaviorSubject()..add(0);

  @override
  Widget build(BuildContext context) {
    return isLoading || banners.nullOrNot
        ? YxShimmerLoader(height: 176, width: context.width)
        : Container(
            color: AppColor.black,
            child: Stack(
              children: [
                PageView.builder(
                  reverse: true,
                  onPageChanged: (value) => index.add(value),
                  itemCount: banners!.length,
                  itemBuilder: (context, index) => Banner(
                    banner: banners![index].banner,
                    title: banners![index].title,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: StreamBuilder<int>(
                      stream: index.stream,
                      builder: (context, snapshot) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: const BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                          ),
                          child: DotsIndicator(
                            dotsCount: banners!.length,
                            position: index.value,
                            reversed: true,
                            decorator: const DotsDecorator(
                              activeColor: AppColor.primary,
                              size: Size.square(5),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          );
  }
}

class Banner extends StatelessWidget {
  const Banner({
    super.key,
    required this.banner,
    required this.title,
  });

  final String banner;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AppColor.black,
          child: Image.asset(
            banner,
            fit: BoxFit.cover,
            width: double.infinity,
            alignment: Alignment.center,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: YxText(
            title,
            color: AppColor.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
