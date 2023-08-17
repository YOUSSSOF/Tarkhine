import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarkhine/common/common.dart';
import 'package:tarkhine/logic/cubits/authentication_cubit.dart';

import '../../../core/core.dart';

class UserInformationScreen extends StatefulWidget {
  const UserInformationScreen({super.key});

  @override
  State<UserInformationScreen> createState() => _UserInformationScreenState();
}

class _UserInformationScreenState extends State<UserInformationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      nameController.text = context.auth.user?.firstName ?? '';
      lastnameController.text = context.auth.user?.lastName ?? '';
      emailController.text = context.auth.user?.email ?? '';
      phoneController.text = context.auth.user?.phoneNumber ?? '';
      birthdateController.text = '';
      usernameController.text = context.auth.user?.username ?? '';
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    birthdateController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  bool isEditing = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const YxAppbar(
          title: 'اطلاعات حساب کاربری',
        ),
        body: Column(
          children: [
            YxField(
              hint: 'نام',
              controller: nameController,
              width: context.percentWidth(90),
              enabled: isEditing,
            ).marginOnly(top: 25),
            YxField(
              hint: 'نام خانوادگی',
              controller: lastnameController,
              width: context.percentWidth(90),
              enabled: isEditing,
            ).marginOnly(top: 25),
            YxField(
              hint: 'آدرس ایمیل',
              controller: emailController,
              width: context.percentWidth(90),
              enabled: isEditing,
            ).marginOnly(top: 25),
            YxField(
              hint: 'شماره همراه',
              controller: phoneController,
              width: context.percentWidth(90),
              enabled: isEditing,
              keyboardType: TextInputType.phone,
            ).marginOnly(top: 25),
            YxField(
              hint: 'تاریخ تولد',
              controller: birthdateController,
              width: context.percentWidth(90),
              enabled: isEditing,
            ).marginOnly(top: 25),
            YxField(
              hint: 'نام نمایشی',
              controller: usernameController,
              width: context.percentWidth(90),
              enabled: isEditing,
            ).marginOnly(top: 25),
            BlocBuilder<AuthenticationCubit, AuthenticationState>(
              builder: (context, state) {
                return YxButton(
                  title: isEditing ? 'اعمال تغییرات ' : 'ویرایش اطاعات',
                  onPressed: state is AuthenticationLoadingState
                      ? null
                      : isEditing
                          ? () {
                              context.auth.updateUser(
                                firstName: nameController.text,
                                lastName: lastnameController.text,
                                emailAddress: emailController.text,
                                phoneNumber: phoneController.text.isEmpty
                                    ? context.auth.user!.phoneNumber
                                    : phoneController.text,
                                username: usernameController.text,
                              );
                              setState(() {
                                isEditing = false;
                              });
                            }
                          : () {
                              setState(() {
                                isEditing = true;
                              });
                            },
                  child: state is AuthenticationLoadingState
                      ? const CircularProgressIndicator(
                          color: AppColor.white,
                        )
                          .sizedBox(
                            height: 10,
                            width: 10,
                          )
                          .paddingH(context.width / 2)
                      : null,
                );
              },
            ).margin(context.percentWidth(5)),
          ],
        ),
      ),
    );
  }
}
