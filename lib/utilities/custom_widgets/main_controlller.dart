// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pink_ad/utilities/custom_widgets/text_utils.dart';

import '../colors/colors.dart';
import '../utils.dart';

class MainControllers extends GetxController {
  void showCustomDialog(var temp) {
    print(temp);
    AwesomeDialog(
      dialogType: DialogType.noHeader,
      context: Get.overlayContext!,
      animType: AnimType.scale,
      btnOkColor: secondary,
      showCloseIcon: true,
      closeIcon: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(
          Icons.close,
          color: tertiary,
          size: 20,
        ),
      ),
      btnCancelColor: bodyTextColor,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Share',
              style: CustomTextView.getStyle(Get.context!,
                  colorLight: secondary,
                  fontSize: 24.sp,
                  fontFamily: Utils.poppinsSemiBold),
            ),
            Text(
              'Share this link via',
              style: CustomTextView.getStyle(
                Get.context!,
                colorLight: textColor,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.snackbar(
                        snackPosition: SnackPosition.BOTTOM,
                        "Instagram",
                        "Click");
                  },
                  child: Container(
                      height: 40.h,
                      width: 45.w,
                      decoration: BoxDecoration(
                        color: socialMediabg,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.facebook,
                          size: 30.sp,
                          // "assets/svgIcons/facebook.svg",
                          color: const Color(0xFF4B69B1),
                        ),
                      )),
                ),
                SizedBox(width: 10.w),

                GestureDetector(
                  onTap: () {
                    Get.snackbar(
                        snackPosition: SnackPosition.BOTTOM,
                        "Instagram",
                        "Click");
                  },
                  child: Container(
                      height: 40.h,
                      width: 45.w,
                      decoration: BoxDecoration(
                        color: socialMediabg,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          height: 20.h,
                          "assets/svgIcons/insta.svg",
                          color: const Color(0xFFE32C48),
                        ),
                      )),
                ),
                SizedBox(width: 10.w),

                // GestureDetector(
                //   onTap: () {
                //     Get.snackbar(
                //         snackPosition: SnackPosition.BOTTOM,
                //         "Instagram",
                //         "Click");
                //   },
                //   child: Container(
                //       height: 40.h,
                //       width: 45.w,
                //       decoration: BoxDecoration(
                //         color: socialMediabg,
                //         borderRadius: BorderRadius.circular(10.0),
                //       ),
                //       child: Center(
                //         child: SvgPicture.asset("assets/svgIcons/twitter.svg"),)),
                // ),
                // GestureDetector(
                //   onTap: () {
                //     Get.snackbar(
                //         snackPosition: SnackPosition.BOTTOM,
                //         "Instagram",
                //         "Click");
                //   },
                //   child: Container(
                //       height: 40.h,
                //       width: 45.w,
                //       decoration: BoxDecoration(
                //         color: socialMediabg,
                //         borderRadius: BorderRadius.circular(10.0),

                //       ),
                //       child: Center(
                //         child: SvgPicture.asset("assets/svgIcons/snapchat.svg"),)),
                // ),

                GestureDetector(
                  onTap: () {
                    Get.snackbar(
                        snackPosition: SnackPosition.BOTTOM,
                        "Instagram",
                        "Click");
                  },
                  child: Container(
                      height: 40.h,
                      width: 45.w,
                      decoration: BoxDecoration(
                        color: socialMediabg,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          height: 20.h,
                          "assets/svgIcons/whatsapp.svg",
                          color: const Color(0xFF29A835),
                        ),
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Or copy link",
              style: CustomTextView.getStyle(
                Get.context!,
                colorLight: textColor,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 50.0.h,
              decoration: BoxDecoration(
                color: lightGray,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      width: 320.w,
                      margin: EdgeInsets.only(left: 10.0.w, right: 10.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset("assets/svgIcons/share_icon.svg"),
                          SizedBox(
                            width: 3.h,
                          ),
                          SizedBox(
                            width: 150.w,
                            child: Text(
                              "example.com/share",
                              style: CustomTextView.getStyle(
                                Get.context!,
                                colorLight: textColor,
                                fontSize: 12.sp,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: Get.height,
                      width: 60.w,
                      decoration: BoxDecoration(
                        color: secondary,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Center(
                          child: Text(
                        'Copy',
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 15.h)
          ],
        ),
      ),
    ).show();
  }
}
