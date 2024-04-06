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
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../utilities/colors/colors.dart';
import '../../../../utilities/custom_widgets/custom_appbar.dart';
import '../../../../utilities/custom_widgets/text_utils.dart';

class AllShopsView extends GetView<AllShopsController> {
  const AllShopsView({super.key});

  @override
  Widget build(BuildContext context) {
    // AllShopsController allShopsController = AllShopsController();
    final box = GetStorage();
    final refreshController = RefreshController();
    final userType = box.read('user_type');
    // List<dynamic> shops = [];

    // print("Shops data: $shops");

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomBgDashboard(
        child: SafeArea(
          child: GetBuilder(
            init: AllShopsController(),
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
                            title: 'All Shops',
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
                    height: 25.h,
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
                      key: controller.filterKey,
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 5.0,
                      ),
                      child: Center(
                        child: TypeAheadField<dynamic>(
                          animationStart: 0,
                          animationDuration: Duration.zero,
                          textFieldConfiguration: TextFieldConfiguration(
                            controller: controller.searchController,
                            autofocus: false,
                            style: TextStyle(fontSize: 15),
                            decoration: InputDecoration(
                              hintText: 'Search Sellers',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.filter_list,
                                  color: Colors.black,
                                  size: 25,
                                ),
                                onPressed: () {
                                  controller.showShopFilterDialog(context);
                                },
                              ),
                              border: InputBorder.none,
                              focusColor: tertiary,
                            ),
                          ),
                          hideOnError: true,
                          suggestionsCallback: (pattern) {
                            List matches = [];
                            matches.addAll(controller.allShops);
                            matches.retainWhere((s) {
                              return s['user']['name'].toLowerCase().contains(pattern.toLowerCase());
                            });
                            return matches.take(6);
                          },
                          itemBuilder: (context, offer) {
                            return GestureDetector(
                              onTap: () {
                                Get.find<AllShopsController>().getShopDetail(offer['shop'][0]['id']);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 2.w,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ),
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.travel_explore,
                                    color: primary,
                                  ),
                                  title: Text(
                                    offer['user']['name'],
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
                                    offer['description'] ?? '',
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
                              ),
                            );
                          },
                          onSuggestionSelected: (suggestion) {
                            // widget.callback(suggestion);
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SmartRefresher(
                      controller: refreshController,
                      onRefresh: () async {
                        try {
                          await controller.refreshShops();
                          refreshController.refreshCompleted();
                        } catch (e) {
                          refreshController.refreshFailed();
                        }
                      },
                      child: ListView.builder(
                        padding: EdgeInsets.only(
                          bottom: 20.h,
                          top: 3.h,
                        ),
                        itemCount: controller.shops.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              controller.getShopDetail(
                                controller.shops[index]['shop'][0]['id'],
                              );
                            },
                            child: allSellerList(
                              controller.shops,
                              index,
                              context,
                              controller,
                            ),
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
      ),
    );
  }

  Container allSellerList(
    List<dynamic> shops,
    int index,
    BuildContext context,
    AllShopsController allShopsController,
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
                    ApiService.imageBaseUrl + shops[index]['logo'],
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
                      shops[index]['user']['name'] ?? '',
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
                      shops[index]['business_address'] ?? '',
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
    );
  }
}
