import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pink_ad/app/modules/active_packages/controllers/active_packages_controller.dart';
import 'package:pink_ad/app/modules/profile/views/profile_view.dart';
import 'package:pink_ad/utilities/colors/colors.dart';

import '../../../../utilities/custom_widgets/custom_appbar_user.dart';
import '../../../../utilities/custom_widgets/scafflod_dashboard.dart';
import '../../../../utilities/custom_widgets/text_utils.dart';
import '../../../../utilities/utils.dart';
import '../../../routes/app_pages.dart';

class ActivePackagesView extends GetView {
  final activePackagesController = Get.put(ActivePackagesController());

  @override
  Widget build(BuildContext context) {
    return CustomBgDashboard(
      child: SafeArea(
        child: Column(
          children: [
            UserAppBar(
              profileIconVisibility: true,
              backButton: false,
              title: 'Active Packages',
              onMenuTap: () {
                print('object');
              },
              onProfileTap: () {
                print('object');
                Get.to(ProfileView());
              },
            ),
            Expanded(
              child: Center(
                child: Container(
                  height: Get.height,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: containerColor,
                    border: Border.all(width: .5, color: secondary),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    itemCount: 5, // number of items in the list
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.ACTIVE_PACKAGE_DETAILS);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 20,
                          ),
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Package ${index + 1}',
                                    style: CustomTextView.getStyle(
                                      context,
                                      fontSize: 18.sp,
                                      fontFamily: Utils.poppinsSemiBold,
                                      colorLight: Colors.black,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(
                                        Routes.ACTIVE_PACKAGE_DETAILS,
                                      );
                                    },
                                    child: Container(
                                      height: 40.h,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20.0.w,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                          30.0,
                                        ),
                                        border: Border.all(
                                          color: secondary,
                                          width: 2,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'PKR 300',
                                          style: CustomTextView.getStyle(
                                            context,
                                            colorLight: secondary,
                                            fontSize: 16.sp,
                                            fontFamily: Utils.poppinsSemiBold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'Lorem ipsum dolor sit amet onstetur adipiscing elit ${index + 1}',
                                style: CustomTextView.getStyle(
                                  context,
                                  colorLight: textColor,
                                  fontSize: 16.sp,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
