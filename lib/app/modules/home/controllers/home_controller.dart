import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pink_ad/app/modules/splash/controllers/splash_controller.dart';
import 'package:pink_ad/utilities/custom_widgets/snackbars.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utilities/colors/colors.dart';
import '../../../../utilities/custom_widgets/text_utils.dart';
import '../../../../utilities/utils.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final box = GetStorage();
  RxBool isLoading = false.obs;

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    box.listen(() {
      update();
    });
  }

  void setLoading() {
    isLoading.value = !isLoading.value;
  }

  Future<void> refreshDashboard() async {
    await Get.find<SplashController>().getHomeData();
    update();
  }

  void showCustomDialog(var temp) {
    print(temp);
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Share',
                  style: CustomTextView.getStyle(Get.context!, colorLight: secondary, fontSize: 24.sp, fontFamily: Utils.poppinsSemiBold),
                ),
                GestureDetector(
                  onTap: Get.back,
                  child: const Icon(
                    Icons.close,
                    color: Colors.red,
                    size: 30,
                  ),
                ),
              ],
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
                  onTap: () async {
                    Share.share(
                      "${temp['title']}, ${temp['description']},${temp['shop']['name'] ?? ''},contact ${temp['shop']['seller']['faecbook_page']}. $appUrl",
                    );
                    // if (await canLaunchUrl(
                    //     Uri.parse(temp['shop']['seller']['faecbook_page']))) {
                    //   await launchUrl(
                    //       Uri.parse(temp['shop']['seller']['faecbook_page']));
                    // } else {
                    //   // If the Facebook app is not installed, open the Facebook website
                    //   await launchUrl(Uri.parse('www.facebook.com'));
                    // }
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
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                GestureDetector(
                  onTap: () async {
                    Share.share(
                      "${temp['title']}, ${temp['description']},${temp['shop']['name'] ?? ''},contact ${temp['shop']['seller']['insta_page']}. $appUrl",
                    );
                    // final appInstalled = await canLaunchUrl(Uri.parse(
                    //     'instagram://${temp['shop']['seller']['insta_page']}'));
                    // if (appInstalled) {
                    //   await launchUrl(Uri.parse(
                    //       'instagram://${temp['shop']['seller']['insta_page']}'));
                    // } else {
                    //   await launchUrl(Uri.parse('https://www.instagram.com/'));
                    // }
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
                        'assets/svgIcons/insta.svg',
                        height: 20.h,
                        color: const Color(0xFFE32C48),
                      ),
                    ),
                  ),
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
                  onTap: () async {
                    await launchUrl(
                      Uri.parse(
                        'whatsapp://send?text=${temp['title']}, ${temp['description']},${temp['shop']['name'] ?? ''},contact ${temp['shop']['seller']['phone']}. $appUrl',
                      ),
                    );
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
                        'assets/svgIcons/whatsapp.svg',
                        height: 20.h,
                        color: const Color(0xFF29A835),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Or copy link',
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
                          SvgPicture.asset('assets/svgIcons/share_icon.svg'),
                          SizedBox(
                            width: 3.h,
                          ),
                          SizedBox(
                            width: 150.w,
                            child: Text(
                              temp['shop']['seller']['web_url'] ?? '',
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
                  InkWell(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: temp['shop']['seller']['web_url'] ?? '')).then(
                        (value) => showSnackBarSuccess(
                          'Message',
                          'Link Copied Successfully',
                        ),
                      );
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
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
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h),
          ],
        ),
      ),
    ).show();
  }
}
