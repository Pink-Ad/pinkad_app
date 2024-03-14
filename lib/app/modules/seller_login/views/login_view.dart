import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utilities/colors/colors.dart';
import '../../../../utilities/custom_widgets/custom_bottom_button.dart';
import '../../../../utilities/custom_widgets/custom_button.dart';
import '../../../../utilities/custom_widgets/custom_text_field.dart';
import '../../../../utilities/custom_widgets/my_scafflod.dart';
import '../../../../utilities/custom_widgets/text_utils.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomBackground(
          header: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 30.0.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Seller Login',
                  style: CustomTextView.getStyle(
                    context,
                    fontSize: 24.sp,
                    colorLight: Colors.white,
                    fontFamily: 'Radomir Tinkov - Gilroy-ExtraBold',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 7.0.h,
                ),
                Text(
                  'Area wise business directory and FREE classified solution for small businesses.',
                  style: CustomTextView.getStyle(
                    context,
                    colorLight: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 80.h,
                ),
                ShadowedTextField(
                  // onChanged: controller.username,
                  focusNode: emailFocus,
                  hintText: 'Email',
                  iconName: 'email_user',
                  onFieldSubmitted: (v) {
                    FocusScope.of(context).requestFocus(passwordFocus);
                  },
                  controller: controller.emailController.value,
                  keyboardType: TextInputType.emailAddress,
                ),
                Obx(
                  () => ShadowedTextField(
                    focusNode: passwordFocus,
                    // onChanged: controller.password,
                    hintText: 'Password',
                    iconName: 'password',
                    keyboardType: TextInputType.text,
                    controller: controller.passwordController.value,
                    obscureText: !controller.isPasswordVisible.value,
                    suffixIcon: IconButton(
                      onPressed: () => controller.isPasswordVisible.toggle(),
                      icon: controller.isPasswordVisible.value
                          ? const Icon(
                              Icons.visibility_off,
                              color: textColor,
                            )
                          : const Icon(
                              Icons.visibility,
                              color: textColor,
                            ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await launch('https://pinkad.pk/portal/password/reset/');
                        },
                        // onTap: () {
                        //   Get.toNamed(Routes.FORGOT_PASSWORD);
                        // },
                        child: Text(
                          'Forgot password?',
                          style: CustomTextView.getStyle(
                            context,
                            colorLight: bodyTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25.h),
                Obx(
                  () => controller.loading.value
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primary,
                          ),
                        )
                      : GlobalButton(
                          title: 'Login',
                          onPressed: () {
                            controller.loginCheck();
                          },
                          textColor: Colors.white,
                          buttonColor: secondary,
                        ),
                ),
                SizedBox(height: 20.h),
                Column(
                  children: [
                    Text(
                      'Don’t have an account?',
                      style: CustomTextView.getStyle(
                        context,
                        colorLight: textColor,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.SIGNUP);
                        // Navigate to sign up screen
                      },
                      child: Text(
                        'Sign Up',
                        style: CustomTextView.getStyle(
                          context,
                          colorLight: secondary,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins-Medium',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0.h,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: BottomButtons(
            buttonText: 'AS USER',
            onTap: () {
              Get.toNamed(Routes.USER_LOGIN);
            },
          ),
        ),
      ],
    );
  }
}
