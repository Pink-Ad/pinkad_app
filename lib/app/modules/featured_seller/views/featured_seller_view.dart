import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:listview_infinite_pagination/listview_infinite_pagination.dart';
import 'package:pink_ad/app/data/api_service.dart';
import 'package:pink_ad/app/modules/all_shops/controllers/all_shops_controller.dart';
import 'package:pink_ad/app/modules/profile/views/profile_view.dart';
import 'package:pink_ad/utilities/colors/colors.dart';
import 'package:pink_ad/utilities/custom_widgets/custom_appbar.dart';
import 'package:pink_ad/utilities/custom_widgets/custom_appbar_user.dart';
import 'package:pink_ad/utilities/custom_widgets/scafflod_dashboard.dart';
import 'package:pink_ad/utilities/custom_widgets/text_utils.dart';
import 'package:pink_ad/utilities/utils.dart';

import '../controllers/featured_seller_controller.dart';

class FeaturedSellerView extends GetView<FeaturedSellerController> {
  FeaturedSellerView({Key? key}) : super(key: key);
  final arguments = Get.arguments as Map<String, dynamic>;
  final ApiService _apiService = ApiService(http.Client());

  @override
  Widget build(BuildContext context) {
    AllShopsController allShopsController = AllShopsController();
    final box = GetStorage();
    final token = box.read('user_token');
    final data = arguments['sellerData'];
    final seller = arguments['seller'];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomBgDashboard(
        child: SafeArea(
          child: Column(
            children: [
              token == null
                  ? MyAppBar(
                      backButton: true,
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
                      backButton: true,
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
                  padding: const EdgeInsets.only(
                      left: 20.0, top: 10.0, bottom: 5.0, right: 5.0),
                  child: TypeAheadField<dynamic>(
                    animationStart: 0,
                    animationDuration: Duration.zero,
                    textFieldConfiguration: const TextFieldConfiguration(
                      autofocus: false,
                      style: TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        hintText: 'Search Shop',
                        suffixIcon: Icon(
                          Icons.shopping_bag_outlined,
                          color: Colors.black,
                          size: 30,
                        ),
                        //    hintStyle: CustomTextView.getStyle(co
                        border: InputBorder.none,
                        focusColor: tertiary,
                      ),
                    ),

                    // suggestionsBoxDecoration:
                    //     SuggestionsBoxDecoration(color: Colors.lightBlue[50]),
                    hideOnError: true,
                    suggestionsCallback: (pattern) {
                      List matches = [];
                      matches.addAll(data);
                      matches.retainWhere((s) {
                        return s['user']['name']
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
                          // margin: EdgeInsets.only(
                          //     left: 20.0.w,
                          //     top: 20.h,
                          //     right: 20.0.w,
                          //     bottom: 10.h),
                          // padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // color: Colors.white,
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
                                    width: 2.w, color: Colors.grey.shade600)),
                          ),
                          child: ListTile(
                            leading: const Icon(
                              Icons.travel_explore,
                              color: primary,
                            ),
                            title: Text(
                              offer['user']['name'],
                              style: CustomTextView.getStyle(context,
                                  colorLight: const Color.fromARGB(255, 41, 39, 39),
                                  fontSize: 13.sp,
                                  fontFamily: Utils.poppinsSemiBold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              offer['description'] ?? '',
                              style: CustomTextView.getStyle(context,
                                  colorLight: const Color.fromARGB(255, 66, 66, 66),
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
              Container(
                  margin: EdgeInsets.only(top: 50.h),
                  height: 450.h,
                  child: ListviewInfinitePagination(
                    itemBuilder: (index, item) {
                      return GestureDetector(
                        onTap: () {
                          allShopsController
                              .getShopDetail(item['shop'][0]['id']);
                          //   Get.toNamed(Routes.SHOP_DETAILS);
                        },
                        child: allShopLists(item, context, allShopsController),
                      );
                    },
                    initialLoader: const Center(
                      child: CircularProgressIndicator(
                          backgroundColor: primary, color: secondary),
                    ),
                    loadMoreLoader: const CircularProgressIndicator(
                        backgroundColor: primary, color: secondary),
                    onFinished: const Text(''),
                    dataFetcher: (page) => dataFetchApi(page, seller),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Container allShopLists(
      item, BuildContext context, AllShopsController allShopsController) {
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
                    ApiService.imageBaseUrl + item["logo"],
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
                      item['user']["name"] ?? "",
                      style: CustomTextView.getStyle(context,
                          colorLight: subHeadingColor,
                          fontSize: 12.sp,
                          fontFamily: Utils.poppinsSemiBold),
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      item['business_address'] ?? "",
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

  Future<List<dynamic>> dataFetchApi(int page, String url) async {
    print(page.toString());
    // const String baseUrl = 'https://jsonplaceholder.typicode.com/posts';
    List<dynamic> testList = [];

    final res = await _apiService.getData("$url?page=$page");
    final result = json.decode(res.body);
    testList.addAll(result['data']);

    return testList;
  }
}
