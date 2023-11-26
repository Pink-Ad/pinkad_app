import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../utilities/colors/colors.dart';
import '../../../../utilities/custom_widgets/text_utils.dart';
import '../../../../utilities/utils.dart';
import '../../../routes/app_pages.dart';

class ActivePackageDetailsController extends GetxController {
  //TODO: Implement ActivePackageDetailsController

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
  void showAwesomeDialog() {
    AwesomeDialog(
      dialogBackgroundColor: containerColor,
      dialogType: DialogType.noHeader,
      context: Get.overlayContext!,
      animType: AnimType.scale,
      showCloseIcon: true,
      closeIcon: const Icon(Icons.close , color: tertiary ,size: 20,),
      btnOkColor: secondary,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      btnCancelColor: bodyTextColor,
      body: Center(
        child: Column(
          children:  [
            SvgPicture.asset(
                "assets/svgIcons/dialog_icon.svg"),
            SizedBox(height: 10.h,),
            Text(
                'Thank you',
                style: CustomTextView.getStyle(Get.context! , colorLight: secondary , fontSize: 20.sp , fontFamily: Utils.poppinsBold)
            ),
            SizedBox(height: 10.h,),
            Text(
                'Your package has been successfully\n renewed.',
                textAlign: TextAlign.center,
                style: CustomTextView.getStyle(Get.context! , colorLight: textColor)
            ),
          ],
        ),
      ),

    ).show();
  }
}
