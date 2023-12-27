import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pink_ad/app/modules/forgot_password/controllers/forgot_password_controller.dart';

import '../../../../utilities/colors/colors.dart';
import '../../../../utilities/custom_widgets/custom_bottom_button.dart';
import '../../../../utilities/custom_widgets/custom_button.dart';
import '../../../../utilities/custom_widgets/custom_text_field.dart';
import '../../../../utilities/custom_widgets/my_scafflod.dart';
import '../../../../utilities/custom_widgets/text_utils.dart';
import '../../../routes/app_pages.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  ForgotPasswordController forgotPasswordController = ForgotPasswordController();
  @override
  Widget build(BuildContext context) {
    bool isChecked = false;
    final isVerifiedByPhone = false.obs;
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
                  'Forgot Password',
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
                  style: CustomTextView.getStyle(context, colorLight: Colors.white),
                ),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * .7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Obx(
                            //   () => CustomCheckbox(
                            //     value: isVerifiedByPhone.value,
                            //     onChanged: (value) =>
                            //         isVerifiedByPhone.value = value!,
                            //   ),
                            // ),
                            // Text(
                            //   "Verify by phone",
                            //   style: CustomTextView.getStyle(context,
                            //       colorLight: bodyTextColor),
                            // ),
                            // Obx(() => CustomCheckbox(
                            //       value: !isVerifiedByPhone.value,
                            //       onChanged: (value) =>
                            //           isVerifiedByPhone.value = !value!,
                            //     )),
                            // Text(
                            //   "Verify by email",
                            //   style: CustomTextView.getStyle(context,
                            //       colorLight: bodyTextColor),
                            // ),
                          ],
                        ),
                      ),
                      Obx(
                        () => ShadowedTextField(
                          controller: forgotPasswordController.emailController.value,
                          hintText: isVerifiedByPhone.value ? 'Enter your phone number' : 'Enter your email',
                          iconName: isVerifiedByPhone.value ? 'phone' : 'email',
                          keyboardType: isVerifiedByPhone.value ? TextInputType.phone : TextInputType.emailAddress,
                        ),
                      ),
                      SizedBox(height: 25.h),
                      Obx(
                        () => forgotPasswordController.loading.value
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: primary,
                                ),
                              )
                            : GlobalButton(
                                title: 'Forget Password',
                                onPressed: () {
                                  forgotPasswordController.loginCheck();
                                  // Get.toNamed(Routes.OTP);
                                },
                                textColor: Colors.white,
                                buttonColor: secondary,
                              ),
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
