import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../colors/colors.dart';

extension DialogExtension on GetxController {
  void showCustomDialog() {
    AwesomeDialog(
      dialogType: DialogType.noHeader,
      context: Get.overlayContext!,
      animType: AnimType.scale,
      btnOkColor: secondary,
      btnCancelColor: bodyTextColor,
      body: Center(
        child: Column(
          children: [
            const Text(
              'Share',
              style: TextStyle(
                  color: secondary,
                  fontStyle: FontStyle.normal,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10.h,
            ),
            const Text(
              'Share this link via',
              style: TextStyle(fontStyle: FontStyle.normal, fontSize: 16),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.snackbar(
                        snackPosition: SnackPosition.BOTTOM,
                        "Instagram",
                        "Click");
                  },
                  child: Container(
                      height: 35.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        border: Border.all(
                          color: containerColor,
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: SvgPicture.asset("assets/svgIcons/facebook.svg"),
                      )),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                GestureDetector(
                  onTap: () {
                    Get.snackbar(
                        snackPosition: SnackPosition.BOTTOM,
                        "Instagram",
                        "Click");
                  },
                  child: Container(
                      height: 35.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        border: Border.all(
                          color: containerColor,
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: SvgPicture.asset("assets/svgIcons/insta.svg"),
                      )),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                GestureDetector(
                  onTap: () {
                    Get.snackbar(
                        snackPosition: SnackPosition.BOTTOM,
                        "Instagram",
                        "Click");
                  },
                  child: Container(
                      height: 35.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        border: Border.all(
                          color: containerColor,
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: SvgPicture.asset("assets/svgIcons/whatsapp.svg"),
                      )),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                GestureDetector(
                  onTap: () {
                    Get.snackbar(
                        snackPosition: SnackPosition.BOTTOM,
                        "Instagram",
                        "Click");
                  },
                  child: Container(
                      height: 35.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        border: Border.all(
                          color: containerColor,
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: SvgPicture.asset("assets/svgIcons/whatsapp.svg"),
                      )),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                GestureDetector(
                  onTap: () {
                    Get.snackbar(
                        snackPosition: SnackPosition.BOTTOM,
                        "Instagram",
                        "Click");
                  },
                  child: Container(
                      height: 35.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        border: Border.all(
                          color: containerColor,
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: SvgPicture.asset("assets/svgIcons/whatsapp.svg"),
                      )),
                ),
                const SizedBox(
                  width: 20.0,
                ),
              ],
            ),
            const Text("Or copy link"),
            Container(
              height: 50.0.h,
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: Colors.grey,
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
                      margin: EdgeInsets.only(left: 10.0.w, right: 50.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/svgIcons/image_icon.svg"),
                          SizedBox(
                            width: 10.h,
                          ),
                          SizedBox(
                            width: 170.w,
                            child: Text(
                              "Image(s)jsdljadjalksjdkladjkaljdklasaldajdlaksdjklas",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 16.sp),
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
                      width: 50.w,
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
                      child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            'Copy',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      btnOk: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Container(
          width: 120.0,
          height: 40.0.h,
          decoration: BoxDecoration(
            color: secondary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
            child: Text(
              'Continue',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      btnCancel: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Container(
          width: 120.0,
          height: 40.0.h,
          decoration: BoxDecoration(
            color: bodyTextColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    ).show();
  }
}
