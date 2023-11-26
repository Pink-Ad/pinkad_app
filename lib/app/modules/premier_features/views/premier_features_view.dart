import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pink_ad/app/modules/premier_features/controllers/premier_features_controller.dart';
import 'package:pink_ad/app/modules/profile/views/profile_view.dart';
import 'package:pink_ad/utilities/colors/colors.dart';

import '../../../../utilities/custom_widgets/custom_appbar_user.dart';
import '../../../../utilities/custom_widgets/custom_button.dart';
import '../../../../utilities/custom_widgets/scafflod_dashboard.dart';
import '../../../../utilities/custom_widgets/text_utils.dart';
import '../../../../utilities/utils.dart';
import '../../upload_offer/controllers/upload_offer_controller.dart';

class PremierFeaturesView extends GetView {
  @override
  Widget build(BuildContext context) {
    final premierFeaturesController = Get.find<PremierFeaturesController>();
    final uploadOfferController = Get.put(UploadOfferController());
    return CustomBgDashboard(
      child: SafeArea(
        child: Column(
          children: [
            UserAppBar(
              profileIconVisibility: true,
              backButton: true,
              title: "Add Banner",
              onMenuTap: () {
                print("object");
              },
              onProfileTap: () {
                print("object");
                Get.to(ProfileView());
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Obx(
                //       () => SizedBox(
                //     height: 50.h,
                //     width: 165.w,
                //     child: ElevatedButton(
                //       onPressed: () {
                //         premierFeaturesController.selectButton(0);
                //       },
                //       style: ElevatedButton.styleFrom(
                //           backgroundColor:
                //           premierFeaturesController.selectedButton.value ==
                //               0
                //               ? secondary
                //               : Colors.white,
                //           shape: const RoundedRectangleBorder(
                //             borderRadius: BorderRadius.only(
                //                 topLeft: Radius.circular(8),
                //                 topRight: Radius.circular(8.0)),
                //           )),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           SvgPicture.asset(
                //             "assets/svgIcons/package.svg",
                //             color: premierFeaturesController
                //                 .selectedButton.value ==
                //                 0
                //                 ? Colors.white
                //                 : Colors.black,
                //           ),
                //           SizedBox(
                //             width: 10.w,
                //           ),
                //           Text(
                //             "Packages",
                //             style: CustomTextView.getStyle(context,
                //                 colorLight: premierFeaturesController
                //                     .selectedButton.value ==
                //                     0
                //                     ? Colors.white
                //                     : Colors.black,
                //                 fontFamily: Utils.poppinsSemiBold,
                //                 fontSize: 16.sp),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // Obx(
                //   () => SizedBox(
                //     height: 50.h,
                //     width: 165.w,
                //     child: ElevatedButton(
                //       onPressed: () {
                //         premierFeaturesController.selectButton(1);
                //       },
                //       style: ElevatedButton.styleFrom(
                //           backgroundColor:
                //               premierFeaturesController.selectedButton.value ==
                //                       1
                //                   ? secondary
                //                   : Colors.white,
                //           shape: const RoundedRectangleBorder(
                //             borderRadius: BorderRadius.only(
                //                 topLeft: Radius.circular(8),
                //                 topRight: Radius.circular(8.0)),
                //           )),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           SvgPicture.asset(
                //             "assets/svgIcons/banner.svg",
                //             color: premierFeaturesController
                //                         .selectedButton.value ==
                //                     0
                //                 ? Colors.black
                //                 : Colors.white,
                //           ),
                //           SizedBox(
                //             width: 10.w,
                //           ),
                //           Text(
                //             "Banner",
                //             style: CustomTextView.getStyle(context,
                //                 colorLight: premierFeaturesController
                //                             .selectedButton.value ==
                //                         0
                //                     ? Colors.black
                //                     : Colors.white,
                //                 fontFamily: Utils.poppinsSemiBold,
                //                 fontSize: 16.sp),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // )
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
                          child: premierFeaturesController
                                  .detailsVisibility.value
                              ? ListView.builder(
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  itemCount: 5, // number of items in the list
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        premierFeaturesController
                                            .detailsVisibility.value = false;
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 20),
                                        padding: const EdgeInsets.all(16.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Package ${index + 1}',
                                                  style:
                                                      CustomTextView.getStyle(
                                                          context,
                                                          fontSize: 18.sp,
                                                          fontFamily: Utils
                                                              .poppinsSemiBold,
                                                          colorLight:
                                                              Colors.black),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    premierFeaturesController
                                                        .detailsVisibility
                                                        .value = false;
                                                  },
                                                  child: Container(
                                                    height: 40.h,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20.0.w),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0),
                                                      border: Border.all(
                                                        color: secondary,
                                                        width: 2,
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text("PKR 300",
                                                          style: CustomTextView
                                                              .getStyle(context,
                                                                  colorLight:
                                                                      secondary,
                                                                  fontSize:
                                                                      16.sp,
                                                                  fontFamily: Utils
                                                                      .poppinsSemiBold)),
                                                    ),
                                                  ),
                                                )
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
                                )
                              : Container(
                                  margin: EdgeInsets.only(
                                      left: 20.h,
                                      right: 20.w,
                                      bottom: 30.h,
                                      top: 10.h),
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
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 20.0.w,
                                            top: 20.h,
                                            right: 20.w),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                GestureDetector(
                                                    onTap: () {
                                                      premierFeaturesController
                                                          .detailsVisibility
                                                          .value = true;
                                                    },
                                                    child: const Icon(
                                                        Icons.arrow_back_ios)),
                                                Text(
                                                  'Package Title',
                                                  style:
                                                      CustomTextView.getStyle(
                                                          context,
                                                          colorLight:
                                                              Colors.black,
                                                          fontSize: 20.sp,
                                                          fontFamily: Utils
                                                              .poppinsSemiBold),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Text(
                                              'PKR 300',
                                              style: CustomTextView.getStyle(
                                                  context,
                                                  colorLight: secondary,
                                                  fontSize: 24.sp,
                                                  fontFamily:
                                                      Utils.poppinsSemiBold),
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
                                                          style: CustomTextView
                                                              .getStyle(
                                                            context,
                                                            colorLight:
                                                                textColor,
                                                            fontSize: 15.sp,
                                                          ),
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
                                        title: "Activate",
                                        onPressed: () {
                                          premierFeaturesController
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
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0.w, vertical: 5.0.h),
                                      child: Text(
                                        "Add New Banner",
                                        style: CustomTextView.getStyle(context,
                                            colorLight: Colors.black,
                                            fontSize: 20.sp,
                                            fontFamily: Utils.poppinsSemiBold),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        height: 110.h,
                                        width: Get.width,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            image: const DecorationImage(
                                              image: AssetImage(
                                                  "assets/icons/dashes_border.png"),
                                              fit: BoxFit.contain,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 2,
                                                blurRadius: 7,
                                                offset: const Offset(0, 3),
                                              ),
                                            ]),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons
                                                    .add_photo_alternate_outlined,
                                                size: 60,
                                                color: secondary,
                                              ),
                                              Text('Add your file here',
                                                  style:
                                                      CustomTextView.getStyle(
                                                          context,
                                                          colorLight: textColor,
                                                          fontSize: 12.sp,
                                                          fontFamily: Utils
                                                              .poppinsMedium)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Container(
                                    //   height: 55.0.h,
                                    //   margin: EdgeInsets.symmetric(
                                    //       horizontal: 20.w, vertical: 10.h),
                                    //   padding: EdgeInsets.only(
                                    //       left: 20.0.w, right: 20.0.h),
                                    //   decoration: BoxDecoration(
                                    //     color: Colors.white,
                                    //     borderRadius:
                                    //         BorderRadius.circular(10.0),
                                    //     boxShadow: [
                                    //       BoxShadow(
                                    //         color: Colors.grey.withOpacity(0.5),
                                    //         spreadRadius: 2,
                                    //         blurRadius: 7,
                                    //         offset: const Offset(0, 3),
                                    //       ),
                                    //     ],
                                    //   ),
                                    //   child: Row(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.spaceBetween,
                                    //     children: [
                                    //       SizedBox(
                                    //         width: 200.w,
                                    //         child: Text(
                                    //           "From Date",
                                    //           style: CustomTextView.getStyle(
                                    //             context,
                                    //             colorLight: textColor,
                                    //             fontSize: 16.sp,
                                    //           ),
                                    //           maxLines: 2,
                                    //           overflow: TextOverflow.ellipsis,
                                    //         ),
                                    //       ),
                                    //       SvgPicture.asset(
                                    //           "assets/svgIcons/calendar.svg"),
                                    //     ],
                                    //   ),
                                    // ),
                                    // Container(
                                    //   height: 55.0.h,
                                    //   margin: EdgeInsets.symmetric(
                                    //       horizontal: 20.w, vertical: 10.h),
                                    //   padding: EdgeInsets.only(
                                    //       left: 20.0.w, right: 20.0.h),
                                    //   decoration: BoxDecoration(
                                    //     color: Colors.white,
                                    //     borderRadius:
                                    //         BorderRadius.circular(10.0),
                                    //     boxShadow: [
                                    //       BoxShadow(
                                    //         color: Colors.grey.withOpacity(0.5),
                                    //         spreadRadius: 2,
                                    //         blurRadius: 7,
                                    //         offset: const Offset(0, 3),
                                    //       ),
                                    //     ],
                                    //   ),
                                    //   child: Row(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.spaceBetween,
                                    //     children: [
                                    //       SizedBox(
                                    //         width: 200.w,
                                    //         child: Text(
                                    //           "To Date",
                                    //           style: CustomTextView.getStyle(
                                    //             context,
                                    //             colorLight: textColor,
                                    //             fontSize: 16.sp,
                                    //           ),
                                    //           maxLines: 2,
                                    //           overflow: TextOverflow.ellipsis,
                                    //         ),
                                    //       ),
                                    //       SvgPicture.asset(
                                    //           "assets/svgIcons/calendar.svg"),
                                    //     ],
                                    //   ),
                                    // ),
                                    // Container(
                                    //   height: 55.h,
                                    //   margin: EdgeInsets.symmetric(
                                    //       horizontal: 20.w, vertical: 10.h),
                                    //   padding: EdgeInsets.only(
                                    //       left: 20.0.w,
                                    //       right: 5.w,
                                    //       top: 5.h,
                                    //       bottom: 5.h),
                                    //   decoration: BoxDecoration(
                                    //     color: Colors.white,
                                    //     borderRadius:
                                    //         BorderRadius.circular(10.0),
                                    //     boxShadow: [
                                    //       BoxShadow(
                                    //         color: Colors.grey.withOpacity(0.5),
                                    //         spreadRadius: 2,
                                    //         blurRadius: 7,
                                    //         offset: const Offset(0, 3),
                                    //       ),
                                    //     ],
                                    //   ),
                                    //   child: Row(
                                    //     children: [
                                    //       Expanded(
                                    //         child: Center(
                                    //           child: TextFormField(
                                    //             obscureText: false,
                                    //             keyboardType:
                                    //                 TextInputType.number,
                                    //             cursorColor: textColor,
                                    //             style: CustomTextView.getStyle(
                                    //                 context,
                                    //                 colorLight: textColor),
                                    //             decoration: InputDecoration(
                                    //               hintText: "Amount",
                                    //               hintStyle:
                                    //                   CustomTextView.getStyle(
                                    //                       context,
                                    //                       colorLight: textColor,
                                    //                       fontSize: 15.sp),
                                    //               border: InputBorder.none,
                                    //               errorStyle: const TextStyle(
                                    //                   color: Colors.redAccent),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),

                                    Container(
                                      height: 55.h,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 20.w, vertical: 10.h),
                                      padding: EdgeInsets.only(
                                          left: 20.0.w,
                                          right: 5.w,
                                          top: 5.h,
                                          bottom: 5.h),
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
                                        children: [
                                          Expanded(
                                            child: Center(
                                              child: TextFormField(
                                                obscureText: false,
                                                keyboardType:
                                                    TextInputType.text,
                                                cursorColor: textColor,
                                                style: CustomTextView.getStyle(
                                                    context,
                                                    colorLight: textColor),
                                                decoration: InputDecoration(
                                                  hintText: "Redirection URL",
                                                  hintStyle:
                                                      CustomTextView.getStyle(
                                                          context,
                                                          colorLight: textColor,
                                                          fontSize: 15.sp),
                                                  border: InputBorder.none,
                                                  errorStyle: const TextStyle(
                                                      color: Colors.redAccent),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 25.h),
                                    GlobalButton(
                                      title: "Add Banner",
                                      onPressed: () {
                                        uploadOfferController
                                            .showAwesomeDialog();
                                      },
                                      textColor: Colors.white,
                                      buttonColor: secondary,
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
