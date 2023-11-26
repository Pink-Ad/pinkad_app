import 'package:flutter/material.dart';
import 'package:get/get.dart';


  //success
  void showSnackBarSuccess(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 2),
      colorText: Colors.white,
    );
  }

  // Error

  void showSnackBarError(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 2),
      colorText: Colors.white,
    );
  }
  // Processing

  void showSnackBarProcessing(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.blue,
      duration: const Duration(seconds: 2),
      colorText: Colors.white,
    );
  }

  // Retry

  void showSnackBarRetry(String title, String message , void Function() onPressed) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      duration: const Duration(seconds: 5),
      isDismissible: true,
      reverseAnimationCurve: Curves.linearToEaseOut,
      colorText: Colors.white,
      mainButton:  TextButton( onPressed: onPressed, child: const Text("Retry"))
    );
  }



