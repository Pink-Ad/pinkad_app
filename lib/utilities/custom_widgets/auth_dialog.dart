import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pink_ad/app/modules/splash/controllers/splash_controller.dart';
import 'package:pink_ad/app/routes/app_pages.dart';
import 'package:pink_ad/utilities/colors/colors.dart';
import 'package:pink_ad/utilities/custom_widgets/text_utils.dart';
import 'package:pink_ad/utilities/functions/loading_wrapper.dart';
import 'package:pink_ad/utilities/utils.dart';

class AuthDialog extends StatelessWidget {
  AuthDialog({super.key});
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black45,
      child: Center(
        child: Container(
          width: 0.85.sw,
          height: 0.21.sh,
          decoration: BoxDecoration(
            color: Get.theme.cardColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: kElevationToShadow[1],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // SvgPicture.asset("assets/svgIcons/dialog_icon.svg"),
                // SizedBox(
                //   height: 20.h,
                // ),
                Text(
                  'Use App',
                  style: CustomTextView.getStyle(
                    Get.context!,
                    colorLight: secondary,
                    fontSize: 20.sp,
                    fontFamily: Utils.poppinsBold,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                //   child: Text(
                //     'Dialog Message',
                //     textAlign: TextAlign.center,
                //     style: CustomTextView.getStyle(Get.context!, colorLight: textColor, fontSize: 14.sp),
                //   ),
                // ),
                // SizedBox(
                //   height: 20.h,
                // ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            loadingWrapper(() => Get.find<SplashController>().guestLogin());
                          },
                          child: Container(
                            height: 50.0.h,
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'As Guest',
                                style: CustomTextView.getStyle(
                                  Get.context!,
                                  colorLight: Colors.white,
                                  fontSize: 16.sp,
                                  fontFamily: Utils.poppinsSemiBold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      10.horizontalSpace,
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            Get.toNamed(Routes.LOGIN);
                          },
                          child: Container(
                            height: 50.0.h,
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'As Seller',
                                style: CustomTextView.getStyle(
                                  Get.context!,
                                  colorLight: Colors.white,
                                  fontSize: 16.sp,
                                  fontFamily: Utils.poppinsSemiBold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
