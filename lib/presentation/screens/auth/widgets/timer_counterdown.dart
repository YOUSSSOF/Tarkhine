import 'package:flutter/material.dart';

import '../../../../common/widgets/yx_text.dart';


class TimerCountDown extends StatelessWidget {
  const TimerCountDown({
    super.key,
    this.onEnd,
    required this.duration,
  });
  final VoidCallback? onEnd;
  final Duration duration;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Duration>(
        duration: duration,
        tween: Tween(begin: duration, end: Duration.zero),
        onEnd: onEnd,
        builder: (BuildContext context, Duration value, Widget? child) {
          final minutes = value.inMinutes;
          final seconds = value.inSeconds % 60;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: YxText(
              '$minutes:$seconds',
              color: Colors.black,
              fontSize: 10,
            ),
          );
        });
  }
}
