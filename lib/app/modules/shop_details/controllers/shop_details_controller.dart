import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pink_ad/utilities/colors/colors.dart';
import 'package:pink_ad/utilities/custom_widgets/text_utils.dart';
import 'package:pink_ad/utilities/utils.dart';

class ShopDetailsController extends GetxController {
  //TODO: Implement ShopDetailsController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
  void showAwesomeDialog({
    required String title,
    required String content,
    required String confirmButtonText,
    required Color confirmButtonColor,
    required VoidCallback onConfirm,
    bool showCancelButton = true, // Add this parameter
  }) {
    AwesomeDialog(
      dialogType:
          DialogType.noHeader, // You can change the dialog type if needed
      context: Get.overlayContext!,
      animType: AnimType.scale,
      btnOkColor: confirmButtonColor,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      btnCancelColor: bodyTextColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: CustomTextView.getStyle(
              Get.context!,
              colorLight: secondary,
              fontSize: 20.sp,
              fontFamily: Utils.poppinsBold,
            ),
          ),
          SizedBox(height: 15.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              content,
              textAlign: TextAlign.center,
              style: CustomTextView.getStyle(
                Get.context!,
                colorLight: textColor,
                fontSize: 14.sp,
              ),
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
      btnOk: GestureDetector(
        onTap: onConfirm,
        child: Container(
          width: 138.0.w,
          height: 50.0.h,
          decoration: BoxDecoration(
            color: confirmButtonColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              confirmButtonText,
              style: CustomTextView.getStyle(
                Get.context!,
                colorLight: Colors.white,
                fontSize: 16.sp,
                fontFamily: Utils.poppinsMedium,
              ),
            ),
          ),
        ),
      ),
      btnCancel: showCancelButton
          ? GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                width: 138.0.w,
                height: 50.0.h,
                decoration: BoxDecoration(
                  color: bodyTextColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Cancel',
                    style: CustomTextView.getStyle(
                      Get.context!,
                      colorLight: Colors.white,
                      fontSize: 16.sp,
                      fontFamily: Utils.poppinsMedium,
                    ),
                  ),
                ),
              ),
            )
          : null,
    ).show();
  }
}
