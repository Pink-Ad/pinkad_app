import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pink_ad/app/modules/profile/views/profile_view.dart';
import 'package:pink_ad/utilities/colors/colors.dart';
import 'package:pink_ad/utilities/custom_widgets/custom_appbar.dart';
import 'package:pink_ad/utilities/custom_widgets/custom_appbar_user.dart';
import 'package:pink_ad/utilities/custom_widgets/custom_button.dart';
import 'package:pink_ad/utilities/custom_widgets/custom_text_field.dart';
import 'package:pink_ad/utilities/custom_widgets/scafflod_dashboard.dart';

import '../controllers/feedback_controller.dart';

class FeedbackView extends GetView<FeedbackController> {
  const FeedbackView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    FeedbackController feedbackController = FeedbackController();
    final box = GetStorage();
    final token = box.read('user_token');
    return ListView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      children: [
        CustomBgDashboard(
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
                  margin: EdgeInsets.only(top: 125.h),
                  height: 10,
                ),
                ShadowedTextField(
                  hintText: 'Name',
                  iconName: "email_user",
                  controller: feedbackController.nameController.value,
                ),
                ShadowedTextField(
                  hintText: 'Phone Number',
                  iconName: "phone",
                  keyboardType: TextInputType.number,
                  controller: feedbackController.phoneNoController.value,
                ),
                Container(
                  height: 80.h,
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  padding: EdgeInsets.only(
                      left: 20.0.w, right: 5.w, top: 5.h, bottom: 5.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          "assets/svgIcons/description.svg",
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Expanded(
                        child: TextField(
                          controller:
                              feedbackController.descriptionController.value,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Description',
                            hintStyle: TextStyle(fontSize: 18.sp),
                            isDense: true,
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 10.h),
                          ),
                          style: TextStyle(fontSize: 14.sp),
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25.h),
                Obx(
                  () => feedbackController.isLoading.value
                      ? const CircularProgressIndicator(
                          color: primary,
                        )
                      : GlobalButton(
                          title: "Submit Feedback",
                          onPressed: () {
                            feedbackController.onSubmit();
                          },
                          textColor: Colors.white,
                          buttonColor: secondary,
                        ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
