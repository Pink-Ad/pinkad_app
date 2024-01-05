import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pink_ad/app/data/api_service.dart';
import 'package:pink_ad/app/models/login_response.dart';
import 'package:pink_ad/app/modules/all_offers/controllers/all_offers_controller.dart';
import 'package:pink_ad/app/modules/shops_insight/controllers/shops_insight_controller.dart';
import 'package:pink_ad/utilities/colors/colors.dart';
import 'package:pink_ad/utilities/custom_widgets/custom_appbar_user.dart';
import 'package:pink_ad/utilities/custom_widgets/text_utils.dart';

import '../../../../utilities/custom_widgets/scafflod_dashboard.dart';
import '../../../../utilities/utils.dart';
import '../../profile/views/profile_view.dart';

class ShopsInsightView extends GetView {
  final box = GetStorage();

  ShopsInsightView({super.key});
  @override
  Widget build(BuildContext context) {
    LoginResponse data = box.read('user_data');
    final premierFeaturesController = Get.find<ShopsInsightController>();
    final allOffersController = AllOffersController();
    return CustomBgDashboard(
      child: SafeArea(
        child: Column(
          children: [
            UserAppBar(
              backButton: true,
              title: 'Insight',
              onMenuTap: () {
                print('object');
              },
              onProfileTap: () {
                print('object');
                Get.to(ProfileView());
              },
              profileIconVisibility: true,
            ),
            Container(
              margin: EdgeInsets.only(
                top: 40.w,
                left: 8.w,
                right: 8.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Obx(
                      () => SizedBox(
                        height: 50.h,
                        child: ElevatedButton(
                          onPressed: () {
                            premierFeaturesController.selectButton(0);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: premierFeaturesController
                                        .selectedButton.value ==
                                    0
                                ? secondary
                                : Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                                // topLeft: Radius.circular(8),
                                // topRight: Radius.circular(8.0),
                              ),
                            ),
                            padding: EdgeInsets.all(16.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/svgIcons/package.svg',
                                color: premierFeaturesController
                                            .selectedButton.value ==
                                        0
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                'Active Offers',
                                style: CustomTextView.getStyle(
                                  context,
                                  colorLight: premierFeaturesController
                                              .selectedButton.value ==
                                          0
                                      ? Colors.white
                                      : Colors.black,
                                  fontFamily: Utils.poppinsSemiBold,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Obx(
                      () => SizedBox(
                        height: 50.h,
                        child: ElevatedButton(
                          onPressed: () {
                            premierFeaturesController.selectButton(1);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: premierFeaturesController
                                        .selectedButton.value ==
                                    1
                                ? secondary
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                                // topLeft: Radius.circular(8),
                                // topRight: Radius.circular(8.0),
                              ),
                            ),
                            padding: EdgeInsets.all(16.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/svgIcons/package.svg',
                                color: premierFeaturesController
                                            .selectedButton.value ==
                                        0
                                    ? Colors.black
                                    : Colors.white,
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                'Inactive Offers',
                                style: CustomTextView.getStyle(
                                  context,
                                  colorLight: premierFeaturesController
                                              .selectedButton.value ==
                                          0
                                      ? Colors.black
                                      : Colors.white,
                                  fontFamily: Utils.poppinsSemiBold,
                                  fontSize: 13.45.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Container(
            //   height: 90.h,
            //   margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.w),
            //   padding: const EdgeInsets.all(10.0),
            //   decoration: BoxDecoration(
            //     color: containerColor,
            //     borderRadius: BorderRadius.circular(10.0),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.grey.withOpacity(0.5),
            //         spreadRadius: 2,
            //         blurRadius: 2,
            //         offset: const Offset(0, 2),
            //       ),
            //     ],
            //   ),
            //   child: Row(
            //     children: [
            //       const SizedBox(
            //         width: 10.0,
            //       ),
            //       Container(
            //         width: 50.0.w,
            //         height: 50.0.h,
            //         decoration: const BoxDecoration(
            //           shape: BoxShape.circle,
            //         ),
            //         child: const CircleAvatar(
            //           radius: 38.0,
            //           backgroundImage:
            //               AssetImage('assets/images/shop_image.png'),
            //         ),
            //       ),
            //       SizedBox(
            //         width: 20.0.w,
            //       ),
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Text(
            //             "Hi, Welcome ${data.user!.name!}",
            //             overflow: TextOverflow.ellipsis,
            //             style: CustomTextView.getStyle(context,
            //                 fontSize: 20.sp,
            //                 colorLight: Colors.black,
            //                 fontFamily: Utils.poppinsBold),
            //           ),
            //           SizedBox(
            //             height: 8.h,
            //           ),
            //           Text(
            //             "Good Afternoon",
            //             style: CustomTextView.getStyle(
            //               context,
            //               fontSize: 16.sp,
            //               colorLight: textColor,
            //             ),
            //           ),
            //         ],
            //       )
            //     ],
            //   ),

            // ),

            Column(
              children: [
                Container(
                  // width: double.infinity,
                  // padding: const EdgeInsets.all(5.0),
                  decoration: const BoxDecoration(
                      // color: containerColor,
                      // borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                  // height: Get.height * .25,
                  margin: EdgeInsets.only(top: 20.h),
                  // margin: EdgeInsets.symmetric(
                  //     horizontal: 20.0.w, vertical: 20.w),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20.h),
                        child: Obx(
                          () =>
                              premierFeaturesController.selectedButton.value ==
                                      0
                                  ? SizedBox(
                                      height: Get.height * 0.52,
                                      child:
                                          premierFeaturesController
                                                  .isLoading.value
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: primary,
                                                  ),
                                                )
                                              : premierFeaturesController
                                                      .active.isEmpty
                                                  ? const Center(
                                                      child: Text(
                                                        'No Active Offers',
                                                      ),
                                                    )
                                                  : ListView.builder(
                                                      // scrollDirection: Axis.horizontal,
                                                      itemCount:
                                                          premierFeaturesController
                                                              .active.length,
                                                      shrinkWrap: true,
                                                      itemBuilder: (
                                                        BuildContext context,
                                                        int index,
                                                      ) {
                                                        return InkWell(
                                                          onTap: () =>
                                                              allOffersController
                                                                  .getOfferDetail(
                                                            premierFeaturesController
                                                                    .active[
                                                                index]['id'],
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              left: 20.w,
                                                              right: 20.w,
                                                              bottom: 10,
                                                            ),
                                                            child: Container(
                                                              width: 217.w,
                                                              height: 325.h,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    lightGray,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                  8.0,
                                                                ),
                                                              ),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    // width: 220.w,
                                                                    height:
                                                                        210.h,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color:
                                                                          lightGray,
                                                                      borderRadius:
                                                                          const BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(
                                                                          10.0,
                                                                        ),
                                                                        topLeft:
                                                                            Radius.circular(
                                                                          10.0,
                                                                        ),
                                                                      ),
                                                                      image:
                                                                          DecorationImage(
                                                                        image:
                                                                            NetworkImage(
                                                                          ApiService.imageBaseUrl +
                                                                              premierFeaturesController.active[index]['banner'],
                                                                        ),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    margin:
                                                                        EdgeInsets
                                                                            .only(
                                                                      top: 5.0,
                                                                      left:
                                                                          10.h,
                                                                      right: 10,
                                                                    ),
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          premierFeaturesController.active[index]
                                                                              [
                                                                              'title'],
                                                                          style:
                                                                              CustomTextView.getStyle(
                                                                            context,
                                                                            colorLight:
                                                                                Colors.black,
                                                                            fontSize:
                                                                                16.sp,
                                                                            fontFamily:
                                                                                Utils.poppinsBold,
                                                                          ),
                                                                        ),
                                                                        Row(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              premierFeaturesController.active[index]['shop']['name'],
                                                                              style: CustomTextView.getStyle(
                                                                                context,
                                                                                colorLight: secondary,
                                                                                fontSize: 16.sp,
                                                                                fontFamily: Utils.poppinsMedium,
                                                                              ),
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                GestureDetector(
                                                                                  onTap: () async {
                                                                                    premierFeaturesController.showCustomDialog(
                                                                                      view: premierFeaturesController.active[index]['views'],
                                                                                      conversion: premierFeaturesController.active[index]['conversion'],
                                                                                      impression: premierFeaturesController.active[index]['impression'],
                                                                                      reach: premierFeaturesController.active[index]['reach'],
                                                                                    );
                                                                                  },
                                                                                  child: Container(
                                                                                    height: 25.h,
                                                                                    width: 30.w,
                                                                                    decoration: BoxDecoration(
                                                                                      color: secondary,
                                                                                      borderRadius: BorderRadius.circular(5.0),
                                                                                    ),
                                                                                    child: const Icon(
                                                                                      Icons.remove_red_eye_outlined,
                                                                                      color: Colors.white,
                                                                                      size: 20,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 10.w,
                                                                                ),
                                                                                GestureDetector(
                                                                                  onTap: () async {
                                                                                    premierFeaturesController.showAwesomeDialog(
                                                                                      offerId: premierFeaturesController.active[index]['id'],
                                                                                    );
                                                                                  },
                                                                                  child: Container(
                                                                                    height: 25.h,
                                                                                    width: 30.w,
                                                                                    decoration: BoxDecoration(
                                                                                      color: Colors.red,
                                                                                      borderRadius: BorderRadius.circular(5.0),
                                                                                    ),
                                                                                    child: const Icon(
                                                                                      Icons.delete,
                                                                                      color: Colors.white,
                                                                                      size: 20,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 10.w,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5.h,
                                                                        ),
                                                                        Text(
                                                                          premierFeaturesController.active[index]
                                                                              [
                                                                              'description'],
                                                                          // 'Lorem ipsum dolor sit amet,\nconsect adipiscin askdjsaldja akdjasl',
                                                                          maxLines:
                                                                              2,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style:
                                                                              CustomTextView.getStyle(
                                                                            context,
                                                                            colorLight:
                                                                                textColor,
                                                                            fontSize:
                                                                                13.sp,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                    )
                                  : SizedBox(
                                      height: Get.height * 0.52,
                                      child:
                                          premierFeaturesController
                                                  .isLoading.value
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: primary,
                                                  ),
                                                )
                                              : premierFeaturesController
                                                      .deActive.isEmpty
                                                  ? const Center(
                                                      child: Text(
                                                        'No Inactive Offers',
                                                      ),
                                                    )
                                                  : ListView.builder(
                                                      // scrollDirection: Axis.horizontal,
                                                      itemCount:
                                                          premierFeaturesController
                                                              .deActive.length,
                                                      // shrinkWrap: true,
                                                      itemBuilder: (
                                                        BuildContext context,
                                                        int index,
                                                      ) {
                                                        return Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            left: 20.w,
                                                            right: 20.w,
                                                            bottom: 10,
                                                          ),
                                                          child: Container(
                                                            width: 217.w,
                                                            height: 325.h,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: lightGray,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                8.0,
                                                              ),
                                                            ),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  // width: 220.w,
                                                                  height: 210.h,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color:
                                                                        lightGray,
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .only(
                                                                      topRight:
                                                                          Radius
                                                                              .circular(
                                                                        10.0,
                                                                      ),
                                                                      topLeft:
                                                                          Radius
                                                                              .circular(
                                                                        10.0,
                                                                      ),
                                                                    ),
                                                                    image:
                                                                        DecorationImage(
                                                                      image:
                                                                          NetworkImage(
                                                                        ApiService.imageBaseUrl +
                                                                            premierFeaturesController.deActive[index]['banner'],
                                                                      ),
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  margin:
                                                                      EdgeInsets
                                                                          .only(
                                                                    top: 5.0,
                                                                    left: 10.h,
                                                                    right: 10,
                                                                  ),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        premierFeaturesController.deActive[index]
                                                                            [
                                                                            'title'],
                                                                        style: CustomTextView
                                                                            .getStyle(
                                                                          context,
                                                                          colorLight:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              16.sp,
                                                                          fontFamily:
                                                                              Utils.poppinsBold,
                                                                        ),
                                                                      ),
                                                                      Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            premierFeaturesController.deActive[index]['shop']['name'],
                                                                            style:
                                                                                CustomTextView.getStyle(
                                                                              context,
                                                                              colorLight: secondary,
                                                                              fontSize: 16.sp,
                                                                              fontFamily: Utils.poppinsMedium,
                                                                            ),
                                                                          ),
                                                                          premierFeaturesController.deActive[index]['status'] == '0'
                                                                              ? Row(
                                                                                  children: [
                                                                                    GestureDetector(
                                                                                      onTap: () async {
                                                                                        premierFeaturesController.showCustomDialog(
                                                                                          view: premierFeaturesController.deActive[index]['views'],
                                                                                          conversion: premierFeaturesController.deActive[index]['conversion'],
                                                                                          impression: premierFeaturesController.deActive[index]['impression'],
                                                                                          reach: premierFeaturesController.deActive[index]['reach'],
                                                                                        );
                                                                                      },
                                                                                      child: Container(
                                                                                        height: 25.h,
                                                                                        width: 30.w,
                                                                                        decoration: BoxDecoration(
                                                                                          color: secondary,
                                                                                          borderRadius: BorderRadius.circular(5.0),
                                                                                        ),
                                                                                        child: const Icon(
                                                                                          Icons.remove_red_eye_outlined,
                                                                                          color: Colors.white,
                                                                                          size: 20,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 10.w,
                                                                                    ),
                                                                                    GestureDetector(
                                                                                      onTap: () async {
                                                                                        premierFeaturesController.showRevisionDialog(
                                                                                          offerId: premierFeaturesController.deActive[index]['id'],
                                                                                        );
                                                                                      },
                                                                                      child: Container(
                                                                                        height: 25.h,
                                                                                        width: 30.w,
                                                                                        decoration: BoxDecoration(
                                                                                          color: secondary,
                                                                                          borderRadius: BorderRadius.circular(5.0),
                                                                                        ),
                                                                                        child: const Icon(
                                                                                          Icons.sync,
                                                                                          color: Colors.white,
                                                                                          size: 20,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 10.w,
                                                                                    ),
                                                                                    GestureDetector(
                                                                                      onTap: () async {
                                                                                        premierFeaturesController.showAwesomeDialog(
                                                                                          offerId: premierFeaturesController.deActive[index]['id'],
                                                                                        );
                                                                                      },
                                                                                      child: Container(
                                                                                        height: 25.h,
                                                                                        width: 30.w,
                                                                                        decoration: BoxDecoration(
                                                                                          color: Colors.red,
                                                                                          borderRadius: BorderRadius.circular(5.0),
                                                                                        ),
                                                                                        child: const Icon(
                                                                                          Icons.delete,
                                                                                          color: Colors.white,
                                                                                          size: 20,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 10.w,
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              : const Row(
                                                                                  children: [
                                                                                    Text('Pending'),
                                                                                    SizedBox(width: 10),
                                                                                    Icon(
                                                                                      Icons.timelapse_outlined,
                                                                                      color: Colors.grey,
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            5.h,
                                                                      ),
                                                                      Text(
                                                                        premierFeaturesController.deActive[index]
                                                                            [
                                                                            'description'],
                                                                        // 'Lorem ipsum dolor sit amet,\nconsect adipiscin askdjsaldja akdjasl',
                                                                        maxLines:
                                                                            2,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: CustomTextView
                                                                            .getStyle(
                                                                          context,
                                                                          colorLight:
                                                                              textColor,
                                                                          fontSize:
                                                                              13.sp,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                    ),
                          // SizedBox(
                          //   height: 280.h,
                          //   child: DashboardPageSlider()),
                        ),
                      ),
                    ],
                  ),
                  // child: DChartBar(
                  //   data: const [
                  //     {
                  //       'id': 'Bar',
                  //       'data': [
                  //         {'domain': 'Jan', 'measure': 600},
                  //         {'domain': 'Feb', 'measure': 400},
                  //         {'domain': 'Mar', 'measure': 200},
                  //         {'domain': 'Apr', 'measure': 100},
                  //         {'domain': 'May', 'measure': 250},
                  //         {'domain': 'Jun', 'measure': 123},
                  //         {'domain': 'Jul', 'measure': 343},
                  //         {'domain': 'Aug', 'measure': 123},
                  //         {'domain': 'Sep', 'measure': 434},
                  //         {'domain': 'Oct', 'measure': 123},
                  //         {'domain': 'Nov', 'measure': 12},
                  //         {'domain': 'Dec', 'measure': 34},
                  //       ],
                  //     },
                  //   ],
                  //   domainLabelPaddingToAxisLine: 16,
                  //   axisLineTick: 2,
                  //   axisLinePointTick: 2,
                  //   axisLinePointWidth: 10,
                  //   axisLineColor: containerColor,
                  //   measureLabelPaddingToAxisLine: 8,
                  //   barColor: (barData, index, id) => barColor.withAlpha(128),
                  //   showBarValue: true,
                  // ),
                ),
                // SizedBox(height: 180.h, child: HomePageSlider()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
