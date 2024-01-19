import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../utilities/colors/colors.dart';
import '../../../../utilities/custom_widgets/custom_bottom_button.dart';
import '../../../../utilities/custom_widgets/custom_button.dart';
import '../../../../utilities/custom_widgets/my_scafflod.dart';
import '../../../../utilities/custom_widgets/text_utils.dart';
import '../../../routes/app_pages.dart';

class OtpView extends GetView {
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
                  'Enter OTP',
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
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
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
                  height: Get.height * .7,
                  width: Get.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.w),
                        child: OtpTextField(
                          fieldWidth: 65.w,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                          fillColor: Colors.white,
                          numberOfFields: 4,
                          borderWidth: 0.0,
                          enabledBorderColor: Colors
                              .transparent, // set transparent to hide the border color
                          focusedBorderColor: Colors.transparent,
                          borderColor: secondary,
                          cursorColor: textColor,
                          textStyle: CustomTextView.getStyle(
                            context,
                            colorLight: bodyTextColor,
                          ),
                          filled: true,
                          margin: EdgeInsets.all(10),
                          //set to true to show as box or false to show as dash
                          showFieldAsBox: true,
                          //runs when a code is typed in
                          onCodeChanged: (String code) {
                            //handle validation or checks here
                          },
                          //runs when every textfield is filled
                          onSubmit: (String verificationCode) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    'Verification Code',
                                    style: CustomTextView.getStyle(
                                      context,
                                      colorLight: bodyTextColor,
                                    ),
                                  ),
                                  content: Text(
                                    'Code entered is $verificationCode',
                                    style: CustomTextView.getStyle(
                                      context,
                                      colorLight: bodyTextColor,
                                    ),
                                  ),
                                );
                              },
                            );
                          }, // end onSubmit
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Get.snackbar(
                            'Sent',
                            'OTP send to your number',
                            colorText: Colors.white,
                            backgroundColor: primary,
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/svgIcons/resend.svg'),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Resend Code',
                                style: CustomTextView.getStyle(
                                  context,
                                  colorLight: bodyTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 25.h),
                      GlobalButton(
                        title: 'Reset Password',
                        onPressed: () {
                          Get.toNamed(Routes.RESET_PASSWORD);
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
