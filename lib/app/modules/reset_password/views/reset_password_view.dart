import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pink_ad/app/modules/reset_password/controllers/reset_password_controller.dart';

import '../../../../utilities/colors/colors.dart';
import '../../../../utilities/custom_widgets/custom_bottom_button.dart';
import '../../../../utilities/custom_widgets/custom_button.dart';
import '../../../../utilities/custom_widgets/custom_text_field.dart';
import '../../../../utilities/custom_widgets/my_scafflod.dart';
import '../../../../utilities/custom_widgets/text_utils.dart';
import '../../../routes/app_pages.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  @override
  Widget build(BuildContext context) {
    final isVerifiedByPhone = true.obs;
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
                  'Reset Password',
                  style: CustomTextView.getStyle(
                    context,
                    fontSize: 24.sp,
                    fontFamily: 'Radomir Tinkov - Gilroy-ExtraBold',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 7.0.h,
                ),
                Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit', style: CustomTextView.getStyle(context, colorLight: Colors.white)),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * .7,
                  width: Get.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => ShadowedTextField(
                          onChanged: controller.newPassword,
                          hintText: 'New Password',
                          iconName: 'password',
                          keyboardType: TextInputType.text,
                          obscureText: !controller.isNewPasswordVisible.value,
                          suffixIcon: IconButton(
                            onPressed: () => controller.isNewPasswordVisible.toggle(),
                            icon: controller.isNewPasswordVisible.value
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
                      Obx(
                        () => ShadowedTextField(
                          onChanged: controller.confirmPassword,
                          hintText: 'Confirm New Password',
                          iconName: 'password',
                          keyboardType: TextInputType.text,
                          obscureText: !controller.isConfirmPasswordVisible.value,
                          suffixIcon: IconButton(
                            onPressed: () => controller.isConfirmPasswordVisible.toggle(),
                            icon: controller.isConfirmPasswordVisible.value
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
                      SizedBox(height: 25.h),
                      GlobalButton(
                        title: 'Reset Password',
                        onPressed: () {
                          Get.toNamed('/login');
                          Get.snackbar(
                            'Successful',
                            'Your password has been changed.',
                            backgroundColor: primary,
                            colorText: Colors.white,
                            snackPosition: SnackPosition.TOP,
                          );
                        },
                        textColor: Colors.white,
                        buttonColor: secondary,
                      ),
                    ],
                  ),
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
