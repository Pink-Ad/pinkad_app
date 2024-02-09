import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pink_ad/app/data/api_service.dart';
import 'package:pink_ad/app/modules/all_offers/controllers/all_offers_controller.dart';
import 'package:pink_ad/app/modules/profile/views/profile_view.dart';
import 'package:pink_ad/utilities/custom_widgets/custom_appbar_user.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../utilities/colors/colors.dart';
import '../../../../utilities/custom_widgets/custom_appbar.dart';
import '../../../../utilities/custom_widgets/scafflod_dashboard.dart';
import '../../../../utilities/custom_widgets/text_utils.dart';
import '../../../../utilities/utils.dart';

class AllOffersView extends GetView<AllOffersController> {
  AllOffersView({super.key});
  final box = GetStorage();
  final refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    final userType = box.read('user_type');
    //List<dynamic> offers = box.read('offers');
    return CustomBgDashboard(
      child: SafeArea(
        child: GetBuilder(
          init: AllOffersController(),
          builder: (controller) {
            return Column(
              children: [
                userType == 'guest'
                    ? MyAppBar(
                        backButton: false,
                        title: 'PinkAd',
                        onMenuTap: () {
                          print('object');
                        },
                        onProfileTap: () {
                          print('object');
                          Get.to(ProfileView());
                        },
                      )
                    : SizedBox(
                        height: 45.h,
                        child: UserAppBar(
                          showBanner: true,
                          backButton: false,
                          title: 'All Offers',
                          onMenuTap: () {
                            print('object');
                          },
                          onProfileTap: () {
                            print('object');
                            Get.to(ProfileView());
                          },
                          profileIconVisibility: true,
                        ),
                      ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  height: 50.h,
                  margin: EdgeInsets.symmetric(
                    horizontal: 20.w,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1, color: tertiary),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    key: controller.filterKey,
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      top: 10.0,
                      bottom: 0.0,
                      right: 5.0,
                    ),
                    child: TypeAheadField<dynamic>(
                      animationStart: 0,
                      animationDuration: Duration.zero,
                      textFieldConfiguration: TextFieldConfiguration(
                        autofocus: false,
                        controller: controller.searchController,
                        style: TextStyle(fontSize: 15),
                        decoration: InputDecoration(
                          hintText: 'Search Offers',
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.filter_list,
                              color: Colors.black,
                              size: 30,
                            ),
                            onPressed: () {
                              Get.find<AllOffersController>().showOfferFilterDialog(context);
                            },
                          ),
                          //    hintStyle: CustomTextView.getStyle(co
                          border: InputBorder.none,
                          focusColor: tertiary,
                        ),
                      ),

                      // suggestionsBoxDecoration:
                      //     SuggestionsBoxDecoration(color: Colors.lightBlue[50]),
                      suggestionsCallback: (pattern) {
                        List<dynamic> matches = <dynamic>[];
                        matches.addAll(controller.allOffers);

                        matches.retainWhere((s) {
                          return s.title!.toLowerCase().contains(pattern.toLowerCase());
                        });
                        return matches.take(6);
                      },
                      itemBuilder: (context, offer) {
                        return GestureDetector(
                          onTap: () {
                            Get.find<AllOffersController>().getOfferDetail(offer.id!);
                          },
                          child: Container(
                            // margin: EdgeInsets.only(
                            //     left: 20.0.w,
                            //     top: 20.h,
                            //     right: 20.0.w,
                            // color: Colors.white,

                            //     bottom: 10.h),
                            // padding: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              // color: containerColor,
                              color: Colors.white,
                              // borderRadius: BorderRadius.circular(10.0),
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: Colors.grey.withOpacity(0.5),
                              //     spreadRadius: 2,
                              //     blurRadius: 3,
                              //     offset: const Offset(0, 3),
                              //   ),
                              // ],
                              border: Border(
                                bottom: BorderSide(
                                  width: 2.w,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                            child: ListTile(
                              leading: const Icon(Icons.travel_explore, color: primary),
                              title: Text(
                                offer.title!,
                                style: CustomTextView.getStyle(
                                  context,
                                  colorLight: const Color.fromARGB(255, 41, 39, 39),
                                  fontSize: 13.sp,
                                  fontFamily: Utils.poppinsSemiBold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                offer!.description,
                                style: CustomTextView.getStyle(
                                  context,
                                  colorLight: const Color.fromARGB(255, 66, 66, 66),
                                  fontSize: 11.sp,
                                  fontFamily: Utils.poppinsLight,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            // child: Container(
                            //   margin: EdgeInsets.only(
                            //       left: 20.0.w, top: 20.h, right: 20.0.w),
                            //   padding: const EdgeInsets.all(20.0),
                            //   decoration: BoxDecoration(
                            //     color: containerColor,
                            //     borderRadius: BorderRadius.circular(10.0),
                            //     boxShadow: [
                            //       BoxShadow(
                            //         color: Colors.grey.withOpacity(0.5),
                            //         spreadRadius: 2,
                            //         blurRadius: 3,
                            //         offset: const Offset(0, 3),
                            //       ),
                            //     ],
                            //   ),
                            //   child: Stack(children: [
                            //     Column(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         Row(
                            //           crossAxisAlignment: CrossAxisAlignment.start,
                            //           mainAxisAlignment: MainAxisAlignment.start,
                            //           children: [
                            //             SizedBox(
                            //               width: 200.w,
                            //               child: Column(
                            //                 crossAxisAlignment:
                            //                     CrossAxisAlignment.start,
                            //                 children: [
                            //                   Text(
                            //                     offer.title!,
                            //                     // 'Offer ${index + 1}',
                            //                     style: CustomTextView.getStyle(
                            //                         context,
                            //                         colorLight: subHeadingColor,
                            //                         fontSize: 18.sp,
                            //                         fontFamily:
                            //                             Utils.poppinsSemiBold),
                            //                     maxLines: 2,
                            //                     overflow: TextOverflow.ellipsis,
                            //                   ),
                            //                   const SizedBox(height: 10.0),
                            //                   Text(
                            //                     offer.shop!.name!,
                            //                     style: CustomTextView.getStyle(
                            //                         context,
                            //                         colorLight: subHeadingColor,
                            //                         fontSize: 16.sp,
                            //                         fontFamily: Utils.poppinsMedium),
                            //                     maxLines: 2,
                            //                     overflow: TextOverflow.ellipsis,
                            //                   ),
                            //                 ],
                            //               ),
                            //             )
                            //           ],
                            //         ),
                            //         const SizedBox(height: 10.0),
                            //         Text(
                            //           offer.description!,
                            //           // 'Lorem ipsum dolor sit amet, consectetur adipiscing elit ${index + 1}',
                            //           style: CustomTextView.getStyle(
                            //             context,
                            //             colorLight: textColor,
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //     Align(
                            //       alignment: Alignment.centerRight,
                            //       child: GestureDetector(
                            //         onTap: () {
                            //           Get.find<AllOffersController>().getOfferDetail(offer.id!);
                            //         },
                            //         child: Container(
                            //             height: 40.h,
                            //             width: 115.w,
                            //             decoration: BoxDecoration(
                            //               color: containerColor,
                            //               borderRadius: BorderRadius.circular(50.0),
                            //               border: Border.all(
                            //                 color: secondary,
                            //                 width: 2,
                            //               ),
                            //             ),
                            //             child: Center(
                            //                 child: Text(
                            //               "View Offer",
                            //               style: CustomTextView.getStyle(context,
                            //                   colorLight: secondary,
                            //                   fontSize: 16.sp,
                            //                   fontFamily: Utils.poppinsSemiBold),
                            //             ))),
                            //       ),
                            //     ),
                            //   ]),
                            // ),
                          ),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        // widget.callback(suggestion);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: SmartRefresher(
                    controller: refreshController,
                    onRefresh: () async {
                      try {
                        await controller.refreshOffers();
                        refreshController.refreshCompleted();
                      } catch (e) {
                        refreshController.refreshFailed();
                      }
                    },
                    child: ListView.builder(
                      padding: EdgeInsets.only(bottom: 20.0.h, top: 10.h),
                      itemCount: controller.offers.length, // number of items in the list
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            // print(inspect(offers[index].shop.logo));
                            controller.getOfferDetail(controller.offers[index].id);
                          },
                          child: offerListItem(controller.offers, index, context),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Container offerListItem(
    List<dynamic> offers,
    int index,
    BuildContext context,
  ) {
    return Container(
      margin: EdgeInsets.only(left: 20.0.w, top: 10.h, right: 20.0.w),
      padding: const EdgeInsets.all(10.0),
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
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  // borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 147, 147, 147).withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(3, 0),
                    ),
                  ],
                ),
                child: ClipRRect(
                  child: Image.network(
                    offers[index]!.banner != null
                        ? ApiService.imageBaseUrl + offers[index]!.banner
                        : 'https://www.pulsecarshalton.co.uk/wp-content/uploads/2016/08/jk-placeholder-image.jpg',
                    width: 60.w,
                    height: 60.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${offers[index]!.title!.toString()} ',
                      //'By ${offers[index]!.shop!.name!.toString()}',
                      style: CustomTextView.getStyle(
                        context,
                        colorLight: subHeadingColor,
                        fontSize: 12.sp,
                        fontFamily: Utils.poppinsSemiBold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      offers[index]!.description!.toString(),
                      style: CustomTextView.getStyle(
                        fontSize: 10.sp,
                        context,
                        colorLight: textColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),

      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Row(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       children: [
      //         SizedBox(
      //           width: 160.w,
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Image.network(
      //                   ApiService.imageBaseUrl + offers[index]!.shop!.logo),
      //               Text(
      //                 offers[index]!.title.toString() ?? "",
      //                 // 'Offer ${index + 1}',
      //                 style: CustomTextView.getStyle(context,
      //                     colorLight: subHeadingColor,
      //                     fontSize: 18.sp,
      //                     fontFamily: Utils.poppinsSemiBold),
      //                 maxLines: 2,
      //                 overflow: TextOverflow.ellipsis,
      //               ),
      //               const SizedBox(height: 10.0),
      //               Text(
      //                 offers[index]!.shop!.name.toString() ?? '',
      //                 style: CustomTextView.getStyle(context,
      //                     colorLight: subHeadingColor,
      //                     fontSize: 16.sp,
      //                     fontFamily: Utils.poppinsMedium),
      //                 maxLines: 2,
      //                 overflow: TextOverflow.ellipsis,
      //               ),
      //             ],
      //           ),
      //         )
      //       ],
      //     ),
      //     const SizedBox(height: 10.0),
      //     Text(
      //       offers[index]!.description.toString() ?? "",
      //       // 'Lorem ipsum dolor sit amet, consectetur adipiscing elit ${index + 1}',
      //       style: CustomTextView.getStyle(
      //         context,
      //         colorLight: textColor,
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
