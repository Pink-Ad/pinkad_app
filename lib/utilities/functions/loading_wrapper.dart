import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pink_ad/utilities/colors/colors.dart';

import 'show_toast.dart';

Future<T?> loadingWrapper<T>(Future<T> Function() func) async {
  Get.context?.loaderOverlay.show(
    widgetBuilder: (progress) {
      return const Center(child: CircularProgressIndicator(color: primary));
    },
  );
  try {
    final response = await func();
    return response;
  } catch (e, s) {
    print('loadingWrapper unknown error: ${e.toString()}\n${s.toString()}');
    showToast(message: e.toString());
  } finally {
    Get.context?.loaderOverlay.hide();
  }
  return null;
}
