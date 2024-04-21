import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pink_ad/app/modules/all_categories/controllers/categories_controller.dart';
import 'package:pink_ad/app/modules/all_offers/controllers/all_offers_controller.dart';
import 'package:pink_ad/app/modules/profile/views/profile_view.dart';
import 'package:pink_ad/utilities/colors/colors.dart';
import 'package:pink_ad/utilities/custom_widgets/custom_appbar.dart';
import 'package:pink_ad/utilities/custom_widgets/custom_appbar_user.dart';
import 'package:pink_ad/utilities/custom_widgets/scafflod_dashboard.dart';
import 'package:pink_ad/utilities/custom_widgets/text_utils.dart';
import 'package:pink_ad/utilities/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CategoriesView extends GetView<CategoriesController> {
  CategoriesView({super.key});
  final box = GetStorage();
  final refreshController = RefreshController();
  final allOffersController = Get.find<AllOffersController>();
  final RxBool _isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    final userType = box.read('user_type');
    return CustomBgDashboard(
      child: SafeArea(
        child: GetBuilder(
          init: CategoriesController(),
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
                          title: 'All Categories',
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
                Expanded(
                  child: Obx(() {
                    if (controller.isLoading.isTrue || _isLoading.isTrue) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: primary,
                        ),
                      );
                    } else {
                      return SmartRefresher(
                        controller: refreshController,
                        onRefresh: controller.fetchCategories,
                        child: ListView.builder(
                          padding: EdgeInsets.only(bottom: 20.h, top: 3.h),
                          itemCount: controller.categories.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                _isLoading.value = true; // Start loading
                                await allOffersController.fetchOffersByCategoryId(controller.categories[index].id);
                                _isLoading.value = false; // Stop loading after fetching
                              },
                              child: categoryListItem(controller.categories, index, context),
                            );
                          },
                        ),
                      );
                    }
                  }),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Container categoryListItem(
    List<dynamic> category,
    int index,
    BuildContext context,
  ) {
    return Container(
      margin: EdgeInsets.only(left: 10.0.w, top: 10.h, right: 10.0.w),
      padding: const EdgeInsets.all(20.0),
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
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${category[index]!.name!.toString()} ',
                      style: CustomTextView.getStyle(
                        context,
                        colorLight: subHeadingColor,
                        fontSize: 13.sp,
                        fontFamily: Utils.poppinsSemiBold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.clip,
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
