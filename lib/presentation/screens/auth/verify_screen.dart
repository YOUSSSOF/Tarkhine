import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../common/common.dart';
import '../../../logic/cubits/authentication_cubit.dart';
import '../root/root.dart';
import '../../../core/core.dart';
import 'widgets/timer_counterdown.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  final String phoneNumber;

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  late final TextEditingController controller;
  bool isTimerOn = true;
  Duration duration = const Duration(minutes: 2);
  void onEnd() {
    setState(() {
      isTimerOn = false;
    });
  }

  String code = "";
  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      buildWhen: (previous, current) => current is! AuthenticationActionState,
      listenWhen: (previous, current) => current is AuthenticationActionState,
      listener: (context, state) {
        switch (state.runtimeType) {
          case AuthenticationSucceedVerificationState:
            context.toOffAll(const Root());
            showSnackbar(context, 'خوش آمدید!', SnackBarType.success);
          case AuthenticationErrorState:
            showSnackbar(
              context,
              (state as AuthenticationErrorState).error.toString(),
              SnackBarType.error,
            );
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(Assets.vectors.mainLogo),
                const SizedBox(
                  height: 60,
                ),
                const YxText(
                  'کد تائید',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 15,
                ),
                YxText(
                  'کد تایید پنج رقمی به شماره  ${widget.phoneNumber} ارسال شد.',
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
                const SizedBox(
                  height: 24,
                ),
                PinCodeTextField(
                  appContext: context,
                  length: 5,
                  controller: controller,
                  onChanged: (value) {
                    setState(() {
                      code = value;
                    });
                  },
                  onCompleted: (value) {
                    context.auth.verifyCode(value, widget.phoneNumber);
                  },
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(4),
                    selectedColor: AppColor.primary,
                    inactiveColor: const Color(0xFF717171),
                    activeColor: state is AuthenticationErrorState
                        ? AppColor.error
                        : null,
                  ),
                ).marginH(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => context.back(),
                      child: const YxText(
                        'ویرایش شماره',
                        fontSize: 11,
                        color: AppColor.primary,
                      ),
                    ),
                    isTimerOn
                        ? Row(
                            children: [
                              const YxText(
                                'تا دریافت مجدد کد',
                                fontSize: 10,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              TimerCountDown(
                                onEnd: onEnd,
                                duration: duration,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              const Icon(
                                Iconsax.clock,
                                size: 16,
                              ),
                            ],
                          )
                        : TextButton(
                            onPressed: () {
                              setState(() {
                                isTimerOn = true;
                                duration =
                                    duration = const Duration(minutes: 2);
                              });
                              context.auth.sendSMS(widget.phoneNumber);
                            },
                            child: const YxText(
                              'دریافت کد مجدد',
                              fontSize: 11,
                              color: AppColor.primary,
                            ),
                          ),
                  ],
                ).marginV(16).marginH(20),
                YxButton(
                  color: state is AuthenticationLoadingState
                      ? AppColor.loading
                      : AppColor.primary,
                  title: 'ورود',
                  onPressed: () {
                    if (controller.text.length < 5) {
                      showSnackbar(
                        context,
                        'لطفا کد را کامل وارد کنید.',
                        SnackBarType.error,
                      );
                    } else {
                      context.auth.verifyCode(code, widget.phoneNumber);
                    }
                  },
                  child: state is AuthenticationLoadingState
                      ? const CircularProgressIndicator(
                          color: AppColor.white,
                        ).sizedBox(height: 10, width: 10)
                      : null,
                )
                    .sizedBox(
                      height: 35,
                      width: double.infinity,
                    )
                    .marginH(20),
              ],
            ),
          ),
        );
      },
    );
  }
}
