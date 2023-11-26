import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pink_ad/app/models/cites_model.dart';

import '../../../../utilities/colors/colors.dart';
import '../../../../utilities/custom_widgets/text_utils.dart';
import '../../../../utilities/utils.dart';

class UserDashboardController extends GetxController {
  //TODO: Implement UserDashboardController
  final box = GetStorage();
  RxList<City> shopName = <City>[].obs;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    print("called12");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void showCustomDialog() {
    AwesomeDialog(
      dialogType: DialogType.noHeader,
      context: Get.overlayContext!,
      animType: AnimType.scale,
      btnOkColor: secondary,
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
                          "assets/svgIcons/insta.svg",
                          height: 20.h,
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
                          "assets/svgIcons/whatsapp.svg",
                          height: 20.h,
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
                          Container(
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
                    child: InkWell(
                      onTap: () {
                        Clipboard.setData(const ClipboardData(text: ''));
                      },
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
