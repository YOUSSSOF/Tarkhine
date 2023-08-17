import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rxdart/rxdart.dart';

import '../../../common/common.dart';
import '../../../core/core.dart';
import '../../../logic/cubits/authentication_cubit.dart';
import '../screens.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});
  final BehaviorSubject<bool> accepted = BehaviorSubject()..add(false);
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      buildWhen: (previous, current) => current is! AuthenticationActionState,
      listenWhen: (previous, current) => current is AuthenticationActionState,
      listener: (context, state) {
        switch (state.runtimeType) {
          case AuthenticationSentNavigateToVerifyActionState:
            context.to(VerifyScreen(
              phoneNumber: controller.text,
            ));
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
            body: StreamBuilder<Object>(
                stream: accepted.stream,
                builder: (context, snapshot) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(Assets.vectors.mainLogo),
                      const SizedBox(
                        height: 60,
                      ),
                      const YxText(
                        'ورود / ثبت‌نام',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const YxText(
                        'شماره همراه خود را وارد کنید.',
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      YxField(
                        hint: 'شماره همراه',
                        controller: controller,
                        keyboardType: TextInputType.phone,
                      ),
                      AbsorbPointer(
                        absorbing: !accepted.value,
                        child: YxButton(
                          color: state is AuthenticationLoadingState
                              ? AppColor.loading
                              : accepted.value
                                  ? AppColor.primary
                                  : AppColor.loading,
                          title: 'ارسال کد',
                          onPressed: () {
                            if (controller.text.isEmpty) {
                              showSnackbar(
                                context,
                                'لطفا تمامی فیلد ها را پر کنید.',
                                SnackBarType.error,
                              );
                              return;
                            } else if (controller.text.length < 10 ||
                                controller.text.length > 12) {
                              showSnackbar(
                                context,
                                'شماره تلفن معتبر نیست.',
                                SnackBarType.error,
                              );
                              return;
                            }
                            state is AuthenticationLoadingState
                                ? null
                                : context.auth.sendSMS(controller.text);
                          },
                          child: state is AuthenticationLoadingState
                              ? const CircularProgressIndicator(
                                  color: AppColor.white,
                                ).sizedBox(
                                  height: 10,
                                  width: 10,
                                )
                              : null,
                        ),
                      )
                          .sizedBox(
                            height: 35,
                            width: double.infinity,
                          )
                          .marginH(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '.',
                                  style: TextStyle(
                                    fontFamily: 'Estedad',
                                    fontSize: 10,
                                  ),
                                ),
                                TextSpan(
                                  text: 'من',
                                  style: TextStyle(
                                    fontFamily: 'Estedad',
                                    fontSize: 10,
                                  ),
                                ),
                                TextSpan(
                                  text: ' قوانین و مقررات ',
                                  style: TextStyle(
                                    fontFamily: 'Estedad',
                                    fontSize: 10,
                                    color: AppColor.primary,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                TextSpan(
                                  text: 'ارائه خدمات توسط ترخینه را می‌پذیرم',
                                  style: TextStyle(
                                    fontFamily: 'Estedad',
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Checkbox(
                            activeColor: AppColor.primary,
                            value: accepted.value,
                            onChanged: (val) {
                              accepted.add(val!);
                            },
                          ),
                        ],
                      ).margin(3),
                    ],
                  ).center;
                }),
          ),
        );
      },
    );
  }
}
