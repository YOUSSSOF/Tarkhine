import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tarkhine/common/common.dart';
import 'package:tarkhine/core/core.dart';
import 'package:tarkhine/logic/cubits/authentication_cubit.dart';
import 'package:tarkhine/presentation/screens/FAQ/faq_screen.dart';
import 'package:tarkhine/presentation/screens/auth/auth_screen.dart';
import 'package:tarkhine/presentation/screens/rules/rules_screen.dart';
import 'package:tarkhine/presentation/screens/user%20information/user_information_screen.dart';
import 'package:tarkhine/presentation/screens/wishlist/wishlist_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case AuthenticationSuccedNavigateToAuthActionState:
            context.toOffAll(AuthScreen());
        }
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: AppColor.primary,
              height: context.percentHeight(20),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    Assets.images.profile,
                    height: 80,
                    width: 80,
                  ).marginOnly(bottom: 10),
                  YxText(
                    context.auth.user!.username!,
                    color: AppColor.white,
                    fontSize: 14,
                  ),
                ],
              ),
            ).center.marginOnly(bottom: 25),
            ProfileItem(
              text: 'اطلاعات حساب کاربری',
              icon: Iconsax.user,
              onTap: () => context.to(
                BlocProvider.value(
                  value: context.auth,
                  child: const UserInformationScreen(),
                ),
              ),
            ),
            ProfileItem(
              text: 'علاقمندی‌ها',
              icon: Iconsax.heart,
              onTap: () => context.to(
                MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: context.delivery,
                    ),
                    BlocProvider.value(
                      value: context.cart,
                    ),
                  ],
                  child: WishlistScreen(),
                ),
              ),
            ),
            ProfileItem(
              text: 'آدرس‌ها',
              icon: Iconsax.location,
              onTap: () => showSnackbar(
                context,
                'بخش آدرس ها توسعه نیافته.',
                SnackBarType.warning,
              ),
            ),
            ProfileItem(
              text: 'سوالات متداول',
              icon: Iconsax.message_question,
              onTap: () => context.to(const FaqScreen()),
            ),
            ProfileItem(
              text: 'قوانین',
              icon: Iconsax.info_circle,
              onTap: () => context.to(const RulesScreen()),
            ),
            ProfileItem(
              text: 'تماس با ما',
              icon: Iconsax.call_calling,
              onTap: () => showSnackbar(
                context,
                'بخش آدرس ها توسعه نیافته.',
                SnackBarType.warning,
              ),
            ),
            ProfileItem(
              text: 'خروج',
              icon: Iconsax.logout,
              color: AppColor.error,
              onTap: context.auth.logout,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    Key? key,
    required this.text,
    required this.icon,
    required this.onTap,
    this.color = AppColor.black,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final VoidCallback onTap;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          YxText(
            text,
            color: color,
            fontSize: 14,
          ).marginOnly(right: 5),
          Icon(
            icon,
            color: color,
          ),
        ],
      ).paddingV(10).paddingH(20),
    );
  }
}
