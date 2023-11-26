import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pink_ad/app/modules/premier_features/controllers/premier_features_controller.dart';
import 'package:pink_ad/app/modules/profile/views/profile_view.dart';
import 'package:pink_ad/utilities/colors/colors.dart';

import '../../../../utilities/custom_widgets/custom_appbar_user.dart';
import '../../../../utilities/custom_widgets/custom_text_field.dart';
import '../../../../utilities/custom_widgets/scafflod_dashboard.dart';
import '../../../routes/app_pages.dart';

class PackageDetailsView extends GetView {
  @override
  Widget build(BuildContext context) {
    final premierFeaturesController = Get.find<PremierFeaturesController>();
    return CustomBgDashboard(
      child: SafeArea(
        child: Column(
          children: [
            UserAppBar(
              profileIconVisibility: true,
              backButton: false,
              title: "Premier Feature",
              onMenuTap: () {
                print("object");
              },
              onProfileTap: () {
                print("object");
                Get.to(ProfileView());
              },
            ),
            SizedBox(
              height: 5.0.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                      () => SizedBox(
                    height: 45.h,
                    width: 150.w,
                    child: ElevatedButton(
                      onPressed: () {
                        premierFeaturesController.selectButton(0);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        premierFeaturesController.selectedButton.value == 0
                            ? secondary
                            : Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/svgIcons/package.svg",
                            color: premierFeaturesController
                                .selectedButton.value ==
                                0
                                ? Colors.white
                                : Colors.black,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "Packages",
                            style: TextStyle(
                              color: premierFeaturesController
                                  .selectedButton.value ==
                                  0
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Obx(
                      () => SizedBox(
                    height: 45.h,
                    width: 150.w,
                    child: ElevatedButton(
                      onPressed: () {
                        premierFeaturesController.selectButton(1);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        premierFeaturesController.selectedButton.value == 1
                            ? secondary
                            : Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/svgIcons/banner.svg",
                            color: premierFeaturesController
                                .selectedButton.value ==
                                0
                                ? Colors.black
                                : Colors.white,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "Banner",
                            style: TextStyle(
                              color: premierFeaturesController
                                  .selectedButton.value ==
                                  0
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Obx(
                  () => premierFeaturesController.selectedButton.value == 0
                  ? Expanded(
                child: Center(
                  child: Container(
                    height: Get.height,
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: containerColor,
                        border: Border.all(width: .5, color: secondary),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0))),
                    child: ListView.builder(
                      itemCount: 5, // number of items in the list
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 10.0.w),
                          child: Container(
                            margin: const EdgeInsets.all(8.0),
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
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Shop Name ${index + 1}',
                                      style: const TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.SHOPS_INSIGHT);
                                      },
                                      child: Container(
                                        height: 40.h,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0.w),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(30.0),
                                          border: Border.all(
                                            color: secondary,
                                            width: 1.5,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "PKR 300",
                                            style: TextStyle(
                                                color: secondary,
                                                fontSize: 14.sp,
                                                fontWeight:
                                                FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  'Description ${index + 1}',
                                  style: const TextStyle(
                                    fontSize: 14.0,
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
              )
                  : Expanded(
                child: Center(
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
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.0.w, vertical: 20.0.h),
                        decoration: const BoxDecoration(
                            color: containerGray,
                            borderRadius:
                            BorderRadius.all(Radius.circular(20.0))),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 20.0.w , vertical: 10.0.h),
                                child: Text(
                                  "Add New Banner",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.sp , fontWeight: FontWeight.w600),
                                  maxLines: 2,
                                  overflow:
                                  TextOverflow.ellipsis,
                                ),
                              ),
                              Center(
                                child: GestureDetector(
                                  onTap: () {

                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    height: 40.h,
                                    width: 120.w,
                                    decoration: BoxDecoration(
                                      color: secondary,
                                      borderRadius:
                                      BorderRadius.circular(10),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Browse',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                height: 45.0.h,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 10.h),
                                padding:  EdgeInsets.symmetric(
                                    horizontal: 15.0.w, vertical: 10.0.h),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 230.w,
                                      child: Text(
                                        "From Date",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 16.sp),
                                        maxLines: 2,
                                        overflow:
                                        TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SvgPicture.asset(
                                        "assets/svgIcons/calendar.svg"),
                                  ],
                                ),
                              ),
                              Container(
                                height: 45.0.h,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 10.h),
                                padding:  EdgeInsets.symmetric(
                                    horizontal: 15.0.w, vertical: 10.0.h),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 220.w,
                                      child: Text(
                                        "To Date",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 16.sp),
                                        maxLines: 2,
                                        overflow:
                                        TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SvgPicture.asset(
                                        "assets/svgIcons/calendar.svg"),
                                  ],
                                ),
                              ),
                              ShadowedTextField(
                                //onChanged: controller.username,
                                hintText: 'Amount',
                                keyboardType: TextInputType.text,

                              ),
                              ShadowedTextField(
                                //onChanged: controller.username,
                                hintText: 'Redirection URL',
                                keyboardType: TextInputType.text,
                              ),
                              const SizedBox(height: 20),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.User_Bottom_Nav_Bar);
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    color: secondary,
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Add Banner',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
