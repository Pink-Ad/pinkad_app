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
                  height: 25.h,
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
                      right: 5.0,
                    ),
                    child: Center(
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
                                size: 25,
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
                              decoration: BoxDecoration(
                                // color: containerColor,
                                color: Colors.white,
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
                        await controller.refreshOffers();
                        refreshController.refreshCompleted();
                      } catch (e) {
                        refreshController.refreshFailed();
                      }
                    },
                    child: ListView.builder(
                      padding: EdgeInsets.only(
                        bottom: 20.0.h,
                        top: 3.h,
                      ),
                      itemCount: controller.offers.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
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
    );
  }
}
