import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pink_ad/utilities/custom_widgets/text_utils.dart';

import '../colors/colors.dart';

class BottomButtons extends StatelessWidget {
  final String? buttonText;
  final VoidCallback? onTap;
  const BottomButtons({Key? key, this.buttonText, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Expanded(
        //   flex: 1,
        //   child: GestureDetector(
        //     onTap: onTap,
        //     child: Container(
        //       height: 50.h,
        //       decoration: const BoxDecoration(
        //         color: secondary,
        //       ),
        //       child: Center(
        //         child: Text(buttonText!,
        //             style: CustomTextView.getStyle(context,
        //                 colorLight: Colors.white,
        //                 fontFamily: "Poppins-Medium")),
        //       ),
        //     ),
        //   ),
        // ),
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              // Get.toNamed(Routes.Bottom_Nav_Bar);
              Get.back();
            },
            child: Container(
              height: 50.h,
              decoration: const BoxDecoration(
                color: secondary,
              ),
              child: Center(
                child: Text(
                  'BACK',
                  style: CustomTextView.getStyle(
                    context,
                    colorLight: Colors.white,
                    fontFamily: 'Poppins-Medium',
                    fontSize: 18.sp,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
