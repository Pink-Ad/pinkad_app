import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pink_ad/app/modules/profile/views/profile_view.dart';
import 'package:pink_ad/app/modules/sub_categories/controllers/sub_categories_controller.dart';
import 'package:pink_ad/utilities/colors/colors.dart';
import 'package:pink_ad/utilities/custom_widgets/custom_appbar.dart';
import 'package:pink_ad/utilities/custom_widgets/custom_appbar_user.dart';
import 'package:pink_ad/utilities/custom_widgets/scafflod_dashboard.dart';
import 'package:pink_ad/utilities/custom_widgets/text_utils.dart';
import 'package:pink_ad/utilities/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// class SubCategoryView extends GetView<SubCategoryController> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Obx(
//         () => ListView.builder(
//           itemCount: controller.subCategories.length,
//           itemBuilder: (context, index) {
//             final subCategory = controller.subCategories[index];
//             return ListTile(
//               title: Text(subCategory.name ?? ''),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

class SubCategoryView extends GetView<SubCategoryController> {
  SubCategoryView({super.key});
  final box = GetStorage();
  final refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    final userType = box.read('user_type');
    return CustomBgDashboard(
      child: SafeArea(
        child: GetBuilder(
          init: SubCategoryController(),
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
                          title: 'All SubCategories',
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
                  child: SmartRefresher(
                    controller: refreshController,
                    onRefresh: () async {
                      try {
                        await controller.refreshSubCategories();
                        refreshController.refreshCompleted();
                      } catch (e) {
                        refreshController.refreshFailed();
                      }
                    },
                    child: Obx(
                      () => ListView.builder(
                        padding: EdgeInsets.only(
                          bottom: 20.h,
                          top: 3.h,
                        ),
                        itemCount: controller.subCategories.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // if (controller.subCategories[index].id != null) {
                              //   Get.put(AllOffersController()); // Register the controller
                              //   Get.to(() => AllOffersView());
                              //   Get.find<AllOffersController>().filterOffersBySubCategory(controller.subCategories[index].id!);
                              // } else {
                              //   print('Subcategory ID is null');
                              // }
                            },
                            child: subcategoryListItem(controller.subCategories, index, context),
                          );
                        },
                      ),
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

  Container subcategoryListItem(
    List<dynamic> subcategory,
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
                      '${subcategory[index]!.name!.toString()} ',
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
