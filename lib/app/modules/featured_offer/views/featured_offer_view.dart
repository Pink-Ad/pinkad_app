import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:listview_infinite_pagination/listview_infinite_pagination.dart';
import 'package:pink_ad/app/data/api_service.dart';
import 'package:pink_ad/app/modules/all_offers/controllers/all_offers_controller.dart';
import 'package:pink_ad/app/modules/profile/views/profile_view.dart';
import 'package:pink_ad/utilities/colors/colors.dart';
import 'package:pink_ad/utilities/custom_widgets/custom_appbar.dart';
import 'package:pink_ad/utilities/custom_widgets/custom_appbar_user.dart';
import 'package:pink_ad/utilities/custom_widgets/scafflod_dashboard.dart';
import 'package:pink_ad/utilities/custom_widgets/text_utils.dart';
import 'package:pink_ad/utilities/utils.dart';

import '../controllers/featured_offer_controller.dart';

class FeaturedOfferView extends GetView<FeaturedOfferController> {
  FeaturedOfferView({Key? key}) : super(key: key);
  final arguments = Get.arguments as Map<dynamic, dynamic>;
  final ApiService _apiService = ApiService(http.Client());

  @override
  Widget build(BuildContext context) {
    final AllOffersController allOffersController = AllOffersController();
    final box = GetStorage();
    final token = box.read('user_token');
    final data = arguments['sellerData'];
    final seller = arguments['seller'];
    return CustomBgDashboard(
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
                    title: "All Offers",
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
                      hintText: '',
                      suffixIcon: Icon(
                        Icons.search_rounded,
                        color: Colors.black,
                        size: 30,
                      ),
                      //    hintStyle: CustomTextView.getStyle(co
                      border: InputBorder.none,
                      focusColor: tertiary,
                    ),
                  ),
                  suggestionsCallback: (pattern) {
                    List matches = [];
                    matches.addAll(data);
                    matches.retainWhere((s) {
                      return s['title']
                          .toLowerCase()
                          .contains(pattern.toLowerCase());
                    });
                    return matches;
                  },
                  itemBuilder: (context, offer) {
                    return GestureDetector(
                      onTap: () {
                        allOffersController.getOfferDetail(offer['id']);
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
                            offer['title'],
                            style: CustomTextView.getStyle(context,
                                colorLight:
                                    const Color.fromARGB(255, 41, 39, 39),
                                fontSize: 13.sp,
                                fontFamily: Utils.poppinsSemiBold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            offer['description'],
                            style: CustomTextView.getStyle(context,
                                colorLight:
                                    const Color.fromARGB(255, 66, 66, 66),
                                fontSize: 11.sp,
                                fontFamily: Utils.poppinsLight),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    // widget.callback(suggestion);
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50.h),
              height: 450.h,
              child: ListviewInfinitePagination(
                  initialLoader: const CircularProgressIndicator(
                      backgroundColor: primary, color: secondary),
                  primary: true,
                  loadMoreLoader: const CircularProgressIndicator(
                      backgroundColor: primary, color: secondary),
                  onFinished: const Text(''),
                  toRefresh: true,
                  dataFetcher: (page) => dataFetchApi(page, seller),
                  itemBuilder: (index, item) {
                    return GestureDetector(
                      onTap: () {
                        allOffersController.getOfferDetail(item['id']);
                      },
                      child: allOfferLists(item, context, allOffersController),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Container allOfferLists(
      item, BuildContext context, AllOffersController allOffersController) {
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
                  child: item["shop"]["logo"] != null
                      ? Image.network(
                          ApiService.imageBaseUrl + item["shop"]["logo"],
                          width: 60.w,
                          height: 60.h,
                          fit: BoxFit.cover,
                        )
                      : SizedBox(width: 60.w, height: 60.h),
                ),
              ),
              SizedBox(width: 10.w),
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${item["title"]} By ${item["shop"]["name"]}",
                      style: CustomTextView.getStyle(context,
                          colorLight: subHeadingColor,
                          fontSize: 12.sp,
                          fontFamily: Utils.poppinsSemiBold),
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      item['description'],
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
