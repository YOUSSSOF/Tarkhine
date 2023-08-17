import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common/utility/extentions.dart';
import '../../../../common/widgets/yx_text.dart';
import '../../../../core/themes/app_colors.dart';

class IntroductionBanner extends StatelessWidget {
  const IntroductionBanner({
    Key? key,
    required this.topText,
    required this.description,
    required this.image,
  }) : super(key: key);
  final String topText;
  final String description;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomPaint(
          size: Size(
              context.width, (context.width * 0.7138888888888889).toDouble()),
          painter: RPSCustomPainter(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () => context.back(),
                  icon: const Icon(
                    Icons.close,
                    color: AppColor.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              YxText(
                topText,
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: AppColor.white,
              ),
              YxText(
                description,
                fontWeight: FontWeight.w300,
                color: AppColor.white,
              )
            ],
          ).padding(20),
        ).sizedBox(height: context.percentHeight(30)),
        SizedBox(
          height: context.percentHeight(10),
        ),
        SvgPicture.asset(
          image,
          height: context.percentHeight(33),
          width: context.percentHeight(33),
        ),
      ],
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.4979028, size.height * 0.9416342);
    path_0.cubicTo(
        size.width * 0.3003806,
        size.height * 0.9076420,
        size.width * 0.08438222,
        size.height * 0.9092101,
        0,
        size.height * 0.9241245);
    path_0.lineTo(0, 0);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(size.width, size.height * 0.9980545);
    path_0.cubicTo(
        size.width * 0.9142194,
        size.height,
        size.width * 0.7013889,
        size.height * 0.9766537,
        size.width * 0.4979028,
        size.height * 0.9416342);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xff417F56).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
