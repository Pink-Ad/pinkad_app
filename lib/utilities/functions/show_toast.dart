import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pink_ad/utilities/colors/colors.dart';

SnackbarController? snackBar;

Future showToast({
  required String message,
  Function(SnackbarStatus?)? snackbarStatus,
  String? title,
  Widget? trailing,
  Widget? imageWidget,
  String? imagePath,
  SnackPosition snackPosition = SnackPosition.BOTTOM,
}) {
  if (SnackbarController.isSnackbarBeingShown) {
    snackBar?.close(withAnimations: false);
  }
  snackBar = Get.showSnackbar(
    GetSnackBar(
      snackbarStatus: (status) => snackbarStatus,
      snackPosition: snackPosition,
      maxWidth: 0.8.sw,
      icon: (imageWidget ?? imagePath) != null
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: imageWidget ??
                  Image.asset(
                    imagePath!,
                    color: Get.theme.colorScheme.onSurface,
                  ),
            )
          : null,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(10),
      backgroundGradient: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          bottomActiveColor,
          secondary,
        ],
      ),
      borderRadius: 10,
      messageText: Text(
        message,
        maxLines: 2,
        style: const TextStyle(color: Colors.white),
      ),
      mainButton: trailing,
      titleText: title != null
          ? Text(
              title,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          : null,
    ),
  );
  return snackBar!.future;
}
