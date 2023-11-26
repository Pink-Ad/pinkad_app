import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            ShadowedTextField(
              hintText: 'Description',
              iconName: "description",
              controller: feedbackController.descriptionController.value,
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
    );
  }
}
