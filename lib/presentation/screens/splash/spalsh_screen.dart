import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import '../../../common/common.dart';
import '../../../core/core.dart';
import '../../../logic/cubits/authentication_cubit.dart';
import '../screens.dart';

class SpalshScreen extends StatelessWidget {
  const SpalshScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      buildWhen: (previous, current) => current is! AuthenticationActionState,
      listenWhen: (previous, current) => current is AuthenticationActionState,
      listener: (context, state) {
        switch (state.runtimeType) {
          case AuthenticationSuccedNavigateToAuthActionState:
            context.toOff(const Root());
          case AuthenticationFailedNavigateToIntroductionActionState:
            context.to(IntroductionScreen());
          case AuthenticationFailedNavigateToAuthActionState:
            context.toOff(AuthScreen());
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  Assets.images.splashBackground,
                  fit: BoxFit.cover,
                ),
              ),
              SvgPicture.asset(
                Assets.vectors.splashLogo,
                height: context.percentHeightLimited(8, 250),
                width: context.percentWidthLimited(8, 250),
              ).center,
              Align(
                alignment: Alignment.bottomCenter,
                child: Lottie.asset(
                  Assets.lotties.loader,
                  height: 100,
                  width: 100,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
