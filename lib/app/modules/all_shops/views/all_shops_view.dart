import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pink_ad/app/data/api_service.dart';
import 'package:pink_ad/app/modules/all_shops/controllers/all_shops_controller.dart';
import 'package:pink_ad/app/modules/profile/views/profile_view.dart';
import 'package:pink_ad/utilities/custom_widgets/custom_appbar_user.dart';
import 'package:pink_ad/utilities/custom_widgets/scafflod_dashboard.dart';
import 'package:pink_ad/utilities/utils.dart';

import '../../../../utilities/colors/colors.dart';
import '../../../../utilities/custom_widgets/custom_appbar.dart';
import '../../../../utilities/custom_widgets/text_utils.dart';

class AllShopsView extends GetView {
  const AllShopsView({super.key});

  @override
  Widget build(BuildContext context) {
    AllShopsController allShopsController = AllShopsController();
    final box = GetStorage();
    final token = box.read('user_token');
    List<dynamic> shops = box.read('allSeller') ?? [];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomBgDashboard(
        child: SafeArea(
          child: Column(
            children: [
              token == null
                  ? MyAppBar(
                      backButton: false,
                      title: "PinkAd",
                      onMenuTap: () {
                        print("object");
                      },
                      onProfileTap: () {
                        print("object");
                        Get.to(ProfileView());
                      },
                    )
                  : UserAppBar(
                      showBanner: true,
                      backButton: false,
                      title: "All Shops",
                      onMenuTap: () {
                        print("object");
                      },
                      onProfileTap: () {
                        print("object");
                        Get.to(ProfileView());
                      },
                      profileIconVisibility: true,
                    ),
              Container(
                height: 50.h,
                margin: EdgeInsets.symmetric(horizontal: 20.w),
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
                  padding: const EdgeInsets.only(
                      left: 20.0, top: 10.0, bottom: 5.0, right: 5.0),
                  child: TypeAheadField<dynamic>(
                    animationStart: 0,
                    animationDuration: Duration.zero,
                    textFieldConfiguration: const TextFieldConfiguration(
                      autofocus: false,
                      style: TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        hintText: 'Search Seller',
                        suffixIcon: Icon(
                          Icons.shopping_bag_outlined,
                          color: Colors.black,
                          size: 30,
                        ),
                        border: InputBorder.none,
                        focusColor: tertiary,
                      ),
                    ),
                    hideOnError: true,
                    suggestionsCallback: (pattern) {
                      List matches = [];
                      matches.addAll(shops);
                      matches.retainWhere((s) {
                        return s['user']["name"]
                            .toLowerCase()
                            .contains(pattern.toLowerCase());
                      });
                      return matches;
                    },
                    itemBuilder: (context, offer) {
                      return GestureDetector(
                        onTap: () {
                          allShopsController
                              .getShopDetail(offer['shop'][0]['id']);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                bottom: BorderSide(
                                    width: 2.w, color: Colors.grey.shade600)),
                          ),
                          child: ListTile(
                            leading: const Icon(
                              Icons.travel_explore,
                              color: primary,
                            ),
                            title: Text(
                              offer['user']["name"],
                              style: CustomTextView.getStyle(context,
                                  colorLight:
                                      const Color.fromARGB(255, 41, 39, 39),
                                  fontSize: 13.sp,
                                  fontFamily: Utils.poppinsSemiBold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              offer['description'] ?? '',
                              style: CustomTextView.getStyle(context,
                                  colorLight:
                                      const Color.fromARGB(255, 66, 66, 66),
                                  fontSize: 11.sp,
                                  fontFamily: Utils.poppinsLight),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // child: Stack(children: [
                          //   Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Align(
                          //         alignment: Alignment.topLeft,
                          //         child: Text(
                          //           // 'Shop Name ${index + 1}',

                          //           offer['business_name'],
                          //           style: CustomTextView.getStyle(context,
                          //               colorLight: subHeadingColor,
                          //               fontSize: 18.sp,
                          //               fontFamily: Utils.poppinsSemiBold),
                          //         ),
                          //       ),
                          //       const SizedBox(height: 10.0),
                          //       SizedBox(
                          //         width: 210.w,
                          //         child: Text(
                          //           // 'jsdhkasdhjasd asjhdjkashd jhsjsdsad djlkasjdlksja sajdkasjd kljsdkjaskldj jsdhkasdhjasd asjhdjkashd jhsjdhsakdh djlkasjdlksja sajdkasjd kljsdkjaskldjsa ${index + 1}',

                          //           offer['description'] == null
                          //               ? ''
                          //               : offer['description'].toString(),
                          //           style: CustomTextView.getStyle(
                          //             context,
                          //             colorLight: textColor,
                          //           ),
                          //           maxLines: 3,
                          //           overflow: TextOverflow.ellipsis,
                          //         ),
                          //       ),
                          //       const SizedBox(height: 15.0),
                          //       Row(
                          //         mainAxisAlignment: MainAxisAlignment.end,
                          //         children: [
                          //           // RatingBar.builder(
                          //           //   initialRating: 3,
                          //           //   minRating: 1,
                          //           //   itemSize: 15.sp,
                          //           //   direction: Axis.horizontal,
                          //           //   allowHalfRating: true,
                          //           //   itemCount: 5,
                          //           //   tapOnlyMode: false,
                          //           //   itemPadding: const EdgeInsets.symmetric(
                          //           //       horizontal: 1.0),
                          //           //   itemBuilder: (context, _) => const Icon(
                          //           //     Icons.star,
                          //           //     color: ratingColor,
                          //           //   ),
                          //           //   onRatingUpdate: (rating) {},
                          //           // ),
                          //           GestureDetector(
                          //             onTap: () {
                          //               allShopsController
                          //                   .getShopDetail(offer['id']);
                          //               // Get.toNamed(Routes.SHOP_DETAILS,
                          //               //     arguments: {
                          //               //       'id': 123,
                          //               //       'name': 'John Doe',
                          //               //     });
                          //             },
                          //             child: Container(
                          //                 height: 40.h,
                          //                 width: 137.w,
                          //                 decoration: BoxDecoration(
                          //                   color: containerColor,
                          //                   borderRadius:
                          //                       BorderRadius.circular(50.0),
                          //                   border: Border.all(
                          //                     color: secondary,
                          //                     width: 2,
                          //                   ),
                          //                 ),
                          //                 child: Center(
                          //                     child: Text(
                          //                   "View Shop",
                          //                   style: CustomTextView.getStyle(
                          //                       context,
                          //                       colorLight: secondary,
                          //                       fontSize: 16.sp,
                          //                       fontFamily:
                          //                           Utils.poppinsSemiBold),
                          //                 ))),
                          //           )
                          //         ],
                          //       ),
                          //     ],
                          //   ),
                          //   Padding(
                          //     padding:
                          //         const EdgeInsets.symmetric(vertical: 16.0),
                          //     child: Align(
                          //       alignment: Alignment.centerRight,
                          //       child: SvgPicture.asset(
                          //           "assets/svgIcons/cert_icon.svg"),
                          //     ),
                          //   ),
                          // ]),
                        ),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      // widget.callback(suggestion);
                    },
                  ),
                  // child: TextField(
                  //   keyboardType: TextInputType.text,
                  //   style: CustomTextView.getStyle(context,
                  //       colorLight: textColor, fontSize: 15.sp),
                  //   decoration: InputDecoration(
                  //     hintText: 'Search Product',
                  //     suffixIcon: const Icon(
                  //       Icons.search_rounded,
                  //       color: Colors.black,
                  //       size: 30,
                  //     ),
                  //     hintStyle: CustomTextView.getStyle(context,
                  //         colorLight: textColor, fontSize: 15.sp),
                  //     border: InputBorder.none,
                  //     focusColor: tertiary,
                  //   ),
                  // ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 20.h),
                  itemCount: shops.length, // number of items in the list
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        allShopsController
                            .getShopDetail(shops[index]["shop"][0]["id"]);
                        //   Get.toNamed(Routes.SHOP_DETAILS);
                      },
                      child: allSellerList(
                          shops, index, context, allShopsController),
                    );

                    // return GestureDetector(
                    //   onTap: () {
                    //     allShopsController.getShopDetail(shops[index].id);
                    //     //   Get.toNamed(Routes.SHOP_DETAILS);
                    //   },
                    //   child: Container(
                    //     margin: EdgeInsets.only(
                    //         left: 20.0.w, top: 20.h, right: 20.0.w),
                    //     padding: const EdgeInsets.all(20.0),
                    //     decoration: BoxDecoration(
                    //       color: containerColor,
                    //       borderRadius: BorderRadius.circular(10.0),
                    //       boxShadow: [
                    //         BoxShadow(
                    //           color: Colors.grey.withOpacity(0.5),
                    //           spreadRadius: 1,
                    //           blurRadius: 2,
                    //           offset: const Offset(0, 1),
                    //         ),
                    //       ],
                    //     ),
                    //     child: Stack(children: [
                    //       Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Align(
                    //             alignment: Alignment.topLeft,
                    //             child: Text(
                    //               shops[index]!.name ?? '',
                    //               style: CustomTextView.getStyle(context,
                    //                   colorLight: subHeadingColor,
                    //                   fontSize: 18.sp,
                    //                   fontFamily: Utils.poppinsSemiBold),
                    //             ),
                    //           ),
                    //           const SizedBox(height: 10.0),
                    //           SizedBox(
                    //             width: 210.w,
                    //             child: Text(
                    //               // 'jsdhkasdhjasd asjhdjkashd jhsjsdsad djlkasjdlksja sajdkasjd kljsdkjaskldj jsdhkasdhjasd asjhdjkashd jhsjdhsakdh djlkasjdlksja sajdkasjd kljsdkjaskldjsa ${index + 1}',

                    //               shops[index]!.description == null
                    //                   ? ''
                    //                   : shops[index]!.description.toString(),
                    //               style: CustomTextView.getStyle(
                    //                 context,
                    //                 colorLight: textColor,
                    //               ),
                    //               maxLines: 3,
                    //               overflow: TextOverflow.ellipsis,
                    //             ),
                    //           ),
                    //           const SizedBox(height: 15.0),
                    //           Row(
                    //             mainAxisAlignment: MainAxisAlignment.end,
                    //             children: [
                    //               // RatingBar.builder(
                    //               //   initialRating: 3,
                    //               //   minRating: 1,
                    //               //   itemSize: 15.sp,
                    //               //   direction: Axis.horizontal,
                    //               //   allowHalfRating: true,
                    //               //   itemCount: 5,
                    //               //   tapOnlyMode: false,
                    //               //   itemPadding: const EdgeInsets.symmetric(
                    //               //       horizontal: 1.0),
                    //               //   itemBuilder: (context, _) => const Icon(
                    //               //     Icons.star,
                    //               //     color: ratingColor,
                    //               //   ),
                    //               //   onRatingUpdate: (rating) {},
                    //               // ),
                    //               GestureDetector(
                    //                 onTap: () {
                    //                   allShopsController
                    //                       .getShopDetail(shops[index].id);
                    //                   // Get.toNamed(Routes.SHOP_DETAILS,
                    //                   //     arguments: {
                    //                   //       'id': 123,
                    //                   //       'name': 'John Doe',
                    //                   //     });
                    //                 },
                    //                 child: Container(
                    //                     height: 40.h,
                    //                     width: 137.w,
                    //                     decoration: BoxDecoration(
                    //                       color: containerColor,
                    //                       borderRadius:
                    //                           BorderRadius.circular(50.0),
                    //                       border: Border.all(
                    //                         color: secondary,
                    //                         width: 2,
                    //                       ),
                    //                     ),
                    //                     child: Center(
                    //                         child: Text(
                    //                       "View Shop",
                    //                       style: CustomTextView.getStyle(
                    //                           context,
                    //                           colorLight: secondary,
                    //                           fontSize: 16.sp,
                    //                           fontFamily:
                    //                               Utils.poppinsSemiBold),
                    //                     ))),
                    //               )
                    //             ],
                    //           ),
                    //         ],
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.symmetric(vertical: 16.0),
                    //         child: Align(
                    //           alignment: Alignment.centerRight,
                    //           child: SvgPicture.asset(
                    //               "assets/svgIcons/cert_icon.svg"),
                    //         ),
                    //       ),
                    //     ]),
                    //   ),
                    // );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container allSellerList(List<dynamic> shops, int index, BuildContext context,
      AllShopsController allShopsController) {
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
                      color: const Color.fromARGB(255, 147, 147, 147)
                          .withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(3, 0),
                    ),
                  ],
                ),
                child: ClipRRect(
                  child: Image.network(
                    ApiService.imageBaseUrl + shops[index]["logo"],
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
                      shops[index]['user']["name"] ?? "",
                      style: CustomTextView.getStyle(context,
                          colorLight: subHeadingColor,
                          fontSize: 12.sp,
                          fontFamily: Utils.poppinsSemiBold),
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      shops[index]['business_address'] ?? "",
                      style: CustomTextView.getStyle(
                        fontSize: 10.sp,
                        context,
                        colorLight: textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),

      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Align(
      //       alignment: Alignment.topLeft,
      //       child: Text(
      //         // 'Shop Name ${index + 1}',

      //         shops[index]['business_name'] ?? "",
      //         style: CustomTextView.getStyle(context,
      //             colorLight: subHeadingColor,
      //             fontSize: 18.sp,
      //             fontFamily: Utils.poppinsSemiBold),
      //       ),
      //     ),
      //     const SizedBox(height: 10.0),
      //     SizedBox(
      //       width: 210.w,
      //       child: Text(
      //         // 'jsdhkasdhjasd asjhdjkashd jhsjsdsad djlkasjdlksja sajdkasjd kljsdkjaskldj jsdhkasdhjasd asjhdjkashd jhsjdhsakdh djlkasjdlksja sajdkasjd kljsdkjaskldjsa ${index + 1}',

      //         shops[index]['description'] == null
      //             ? ''
      //             : shops[index]['description'].toString(),
      //         style: CustomTextView.getStyle(
      //           context,
      //           colorLight: textColor,
      //         ),
      //         maxLines: 3,
      //         overflow: TextOverflow.ellipsis,
      //       ),
      //     ),
      //     const SizedBox(height: 15.0),
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.end,
      //       children: [
      //         // RatingBar.builder(
      //         //   initialRating: 3,
      //         //   minRating: 1,
      //         //   itemSize: 15.sp,
      //         //   direction: Axis.horizontal,
      //         //   allowHalfRating: true,
      //         //   itemCount: 5,
      //         //   tapOnlyMode: false,
      //         //   itemPadding: const EdgeInsets.symmetric(
      //         //       horizontal: 1.0),
      //         //   itemBuilder: (context, _) => const Icon(
      //         //     Icons.star,
      //         //     color: ratingColor,
      //         //   ),
      //         //   onRatingUpdate: (rating) {},
      //         // ),
      //         GestureDetector(
      //           onTap: () {
      //             allShopsController.getShopDetail(
      //                 shops[index]["shop"][0]["id"]);
      //             // Get.toNamed(Routes.SHOP_DETAILS,
      //             //     arguments: {
      //             //       'id': 123,
      //             //       'name': 'John Doe',
      //             //     });
      //           },
      //           child: Container(
      //               height: 40.h,
      //               width: 137.w,
      //               decoration: BoxDecoration(
      //                 color: containerColor,
      //                 borderRadius:
      //                     BorderRadius.circular(50.0),
      //                 border: Border.all(
      //                   color: secondary,
      //                   width: 2,
      //                 ),
      //               ),
      //               child: Center(
      //                   child: Text(
      //                 "View Shop",
      //                 style: CustomTextView.getStyle(context,
      //                     colorLight: secondary,
      //                     fontSize: 16.sp,
      //                     fontFamily: Utils.poppinsSemiBold),
      //               ))),
      //         )
      //       ],
      //     ),
      //   ],
      // ),
    );
  }
}
