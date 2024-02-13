import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pink_ad/utilities/colors/colors.dart';
import 'package:pink_ad/utilities/custom_widgets/text_utils.dart';
import 'package:pink_ad/utilities/utils.dart';

Future<T?> showCustomDialog<T>({
  required String message,
  String? title,
  String? confirmText,
  String? cancelText,
  FutureOr<T?>? Function()? confirmCallback,
}) async {
  final result = await AwesomeDialog(
    dialogType: DialogType.noHeader,
    context: Get.overlayContext!,
    animType: AnimType.scale,
    btnOkColor: secondary,
    padding: EdgeInsets.symmetric(vertical: 10.h),
    btnCancelColor: bodyTextColor,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // SvgPicture.asset("assets/svgIcons/dialog_icon.svg"),
        // SizedBox(
        //   height: 20.h,
        // ),
        if (title != null)
          Text(
            title,
            style: CustomTextView.getStyle(
              Get.context!,
              colorLight: secondary,
              fontSize: 20.sp,
              fontFamily: Utils.poppinsBold,
            ),
          ),
        SizedBox(
          height: 15.h,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: CustomTextView.getStyle(
              Get.context!,
              colorLight: textColor,
              fontSize: 14.sp,
            ),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    ),
    btnOk: confirmText != null
        ? GestureDetector(
            onTap: () async {
              if (confirmCallback == null) {
                Get.back(result: true);
              } else {
                Get.back(result: await confirmCallback());
              }
            },
            child: Container(
              width: 138.0.w,
              height: 50.0.h,
              decoration: BoxDecoration(
                color: secondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  confirmText,
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
    btnCancel: cancelText != null
        ? GestureDetector(
            onTap: () {
              Get.back(result: null);
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
                  cancelText,
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
  return result;
}
