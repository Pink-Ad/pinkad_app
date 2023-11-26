import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pink_ad/app/modules/active_packages/controllers/active_packages_controller.dart';
import 'package:pink_ad/app/modules/profile/views/profile_view.dart';
import 'package:pink_ad/utilities/colors/colors.dart';

import '../../../../utilities/custom_widgets/custom_appbar_user.dart';
import '../../../../utilities/custom_widgets/custom_button.dart';
import '../../../../utilities/custom_widgets/scafflod_dashboard.dart';
import '../../../../utilities/custom_widgets/text_utils.dart';
import '../../../../utilities/utils.dart';
import '../../../routes/app_pages.dart';
import '../controllers/active_package_details_controller.dart';

class ActivePackageDetailsView extends GetView {
  final activePackageDetailsController = Get.find<ActivePackageDetailsController>();

  @override
  Widget build(BuildContext context) {
    return CustomBgDashboard(
      child: SafeArea(
        child: Column(
          children: [
            UserAppBar(
              profileIconVisibility: false,
              backButton: true,
              title: "Active Offer Details",
              onMenuTap: () {
                print("object");
              },
              onProfileTap: () {
                print("object");
                Get.to(ProfileView());
              },
            ),
            Expanded(
              child: Container(
                height: Get.height,
                width: Get.width,
                decoration: BoxDecoration(
                    color: containerColor,
                    border: Border.all(width: .5, color: secondary),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0))),
                child: Container(
                  margin: EdgeInsets.only(left: 20.h , right: 20.w , bottom: 50.h ,top: 20.h),
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
                      Padding(
                        padding: EdgeInsets.only(left: 20.0.w , top: 30.h , right: 20.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                            Text(
                              'Package Title',
                              style: CustomTextView.getStyle(context , colorLight: Colors.black , fontSize: 20.sp , fontFamily: Utils.poppinsSemiBold),
                              maxLines: 1,
                              overflow:
                              TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              'PKR 300',
                              style: CustomTextView.getStyle(context , colorLight: secondary , fontSize: 24.sp , fontFamily: Utils.poppinsSemiBold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount:
                          5, // number of items in the list
                          itemBuilder: (BuildContext context,
                              int index) {
                            return Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(
                                      20.0),
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 15.w,
                                        height: 15.h,
                                        // child: Icon(Icons.arrow_right , size: 30, color: secondary,),
                                        decoration:
                                        const BoxDecoration(
                                          color: secondary,
                                          shape:
                                          BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      SizedBox(
                                        width: 230.w,
                                        child: Text(
                                          'Lorem ipsum dolor sit amet onstetur adipiscing elit ${index + 1}',
                                          style:
                                          CustomTextView.getStyle(context , colorLight: textColor , fontSize: 15.sp , ),
                                          maxLines: 3,
                                          overflow: TextOverflow
                                              .ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  height: 2,
                                  thickness: 2,
                                )
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      GlobalButton(
                        title: "Renew Package",
                        onPressed: () {
                          activePackageDetailsController
                              .showAwesomeDialog();
                        },
                        textColor: Colors.white,
                        buttonColor: secondary,
                      ),
                      SizedBox(
                        height: 20.h,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
