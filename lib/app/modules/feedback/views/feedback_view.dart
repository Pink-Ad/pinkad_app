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
import 'package:pink_ad/utilities/custom_widgets/phone_input_field.dart';
import 'package:pink_ad/utilities/custom_widgets/scafflod_dashboard.dart';
import 'package:pink_ad/utilities/custom_widgets/text_utils.dart';

import '../controllers/feedback_controller.dart';

class FeedbackView extends GetView<FeedbackController> {
  const FeedbackView({Key? key}) : super(key: key);

  String? validatePakistaniPhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    value = value.replaceAll('-', ''); // Remove dashes before validation
    if (value.length != 11) {
      return 'The phone number must be 10 digits long';
    }
    if (!RegExp(r'^[0-9]{11}$').hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();

    final feedbackController = Get.find<FeedbackController>();
    final userType = GetStorage().read('user_type') ?? 'guest';
    final sellerName =
        userType != 'guest' ? GetStorage().read('seller_name') ?? '' : '';
    final sellerPhoneNumber = userType != 'guest'
        ? GetStorage().read('seller_phone_number') ?? ''
        : '';

    return ListView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      children: [
        CustomBgDashboard(
          isfeedback: true,
          child: SafeArea(
            child: Column(
              children: [
                userType == 'guest'
                    ? MyAppBar(
                        backButton: true,
                        title: 'PinkAd',
                        onMenuTap: () {
                          print('object');
                        },
                        onProfileTap: () {
                          print('object');
                          Get.to(ProfileView());
                        },
                      )
                    : UserAppBar(
                        showBanner: true,
                        backButton: true,
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

                SizedBox(
                  height: 120.h,
                ),
                // ShadowedTextField(
                //   hintText: 'Name',
                //   iconName: 'email_user',
                //   controller: feedbackController.nameController.value,
                // ),
                // ShadowedTextField(
                //   hintText: 'Phone Number',
                //   iconName: 'phone',
                //   keyboardType: TextInputType.number,
                //   controller: feedbackController.phoneNoController.value,
                // ),
                ShadowedTextField(
                  hintText: 'Name',
                  iconName: 'email_user',
                  controller: userType == 'guest'
                      ? feedbackController.nameController.value
                      : TextEditingController(text: sellerName),
                ),
                // ShadowedTextField(
                //   hintText: 'Phone Number',
                //   iconName: 'phone',
                //   keyboardType: TextInputType.number,
                //   controller: userType == 'guest'
                //       ? feedbackController.phoneNoController.value
                //       : TextEditingController(text: sellerPhoneNumber),
                // ),
                CustomPhoneInputField(
                  controller: userType == 'guest'
                      ? feedbackController.phoneNoController.value
                      : TextEditingController(text: sellerPhoneNumber),
                  focusNode:
                      FocusNode(), // Create a new FocusNode or use an existing one
                  hintText: 'XXX-XXXXXXX',
                  iconName: 'phone',
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {
                    // Handle the field submission logic if required
                  },
                  // If you want the prefix '+92' to be displayed for guest users, add it conditionally
                  prefixText: userType == 'guest' ? '+92' : '',
                  validator: validatePakistaniPhoneNumber,
                ),
                Container(
                  height: 100.h,
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  padding: EdgeInsets.only(
                    left: 20.0.w,
                    right: 5.w,
                    top: 5.h,
                    bottom: 5.h,
                  ),
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
                          'assets/svgIcons/description.svg',
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
                            hintStyle: CustomTextView.getStyle(
                              context,
                              fontSize: 15.sp,
                            ),
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
                          title: 'Submit Feedback',
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
