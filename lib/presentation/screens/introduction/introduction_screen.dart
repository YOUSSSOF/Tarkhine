import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rxdart/rxdart.dart';
import '../../../common/common.dart';
import '../../../core/core.dart';
import '../screens.dart';

import 'widgets/introduction_banner.dart';

class IntroductionScreen extends StatelessWidget {
  IntroductionScreen({super.key});
  final PageController controller = PageController();
  final BehaviorSubject<int> pageIndex = BehaviorSubject()..add(0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: pageIndex.stream,
          builder: (context, snapshot) {
            return Column(
              children: [
                PageView.builder(
                  controller: controller,
                  itemCount: banners.length,
                  itemBuilder: (context, index) => banners[pageIndex.value],
                ).sizedBox(
                  height: context.percentHeight(75),
                ),
                const SizedBox(
                  height: 35,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: BorderRadius.circular(80),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(80),
                    onTap: () {
                      pageIndex.value < 2
                          ? pageIndex.sink.add(pageIndex.value + 1)
                          : context.toOff(AuthScreen());
                    },
                    child: pageIndex.value == 2
                        ? const Icon(
                            Icons.check,
                            color: AppColor.white,
                          ).padding(13)
                        : SvgPicture.asset(Assets.vectors.arrowNext).padding9,
                  ),
                ),
              ],
            );
          }),
    );
  }
}

List<IntroductionBanner> banners = [
  IntroductionBanner(
      topText: 'سفارش آسان غذا با چند کلیک',
      description:
          'با اپلیکیشن ترخینه می‌تونی در عرض چند ثانیه و با چند کلیک به راحتی سفارش خودت رو ثبت کنی.',
      image: Assets.vectors.character1),
  IntroductionBanner(
      topText: 'ارسال سریع سفارشات',
      description:
          'حداکثر زمان تحویل غذا در ترخینه ۴۵ دقیقه است که این زمان بسته به آدرست میتونه کمتر هم بشه!',
      image: Assets.vectors.character2),
  IntroductionBanner(
      topText: 'تجربه غذای سالم و گیاهی',
      description:
          'تموم غذاهای ترخینه با محصولات کشاورزی کاملا سالم و ارگانیک تهیه می‌شن تا بهترین تجربه رو بهت هدیه بدن.',
      image: Assets.vectors.character3),
];
