import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pink_ad/utilities/colors/colors.dart';
import 'package:pink_ad/utilities/utils.dart';

import '../../../../utilities/custom_widgets/custom_appbar.dart';
import '../../../../utilities/custom_widgets/custom_text_field.dart';
import '../../../../utilities/custom_widgets/scafflod_dashboard.dart';
import '../../../../utilities/custom_widgets/text_utils.dart';

class ProfileView extends GetView {
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    var temp = box.read('customer_data');
    TextEditingController emailController = TextEditingController();
    emailController.text = temp['user']['email'] ?? '';
    print(temp);
    return CustomBgDashboard(
      child: SafeArea(
        child: Column(
          children: [
            MyAppBar(
              backButton: true,
              title: 'User Details',
              onMenuTap: () {
                print('object');
              },
              onProfileTap: () {
                print('object');
                Get.to(ProfileView());
              },
            ),
            Container(
              height: 80.h,
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.w),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: containerColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                children: [
                  // Container(
                  //   width: 80.0,
                  //   height: 90.0.h,
                  //   decoration: BoxDecoration(
                  //     shape: BoxShape.circle,
                  //     border: Border.all(
                  //       color: secondary,
                  //       width: 2.0,
                  //     ),
                  //   ),
                  //   child: const CircleAvatar(
                  //     radius: 38.0,
                  //     backgroundImage: AssetImage('assets/images/profile.png'),
                  //   ),
                  // ),
                  SizedBox(
                    width: 15.0.w,
                  ),
                  Expanded(
                    child: Text(
                      temp['user']['name'] ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextView.getStyle(
                        context,
                        colorLight: Colors.black,
                        fontSize: 20.sp,
                        fontFamily: Utils.poppinsBold,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: Get.height,
                  decoration: const BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      ShadowedTextField(
                        // onChanged: ForgotPasswordController.,
                        controller: emailController,
                        hintText: 'Email',
                        iconName: 'email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      // ShadowedTextField(
                      //   // onChanged: ForgotPasswordController.,
                      //   hintText: 'Interest',
                      //   iconName: "interest",
                      //   keyboardType: TextInputType.text,
                      // ),
                      // ShadowedTextField(
                      //   // onChanged: ForgotPasswordController.,
                      //   hintText: 'Location',
                      //   iconName: "location",
                      //   keyboardType: TextInputType.text,
                      // ),
                      SizedBox(height: 25.h),
                      // GlobalButton(
                      //   title: "Update",
                      //   onPressed: () {
                      //     Get.toNamed(Routes.Bottom_Nav_Bar);
                      //     Get.snackbar("Success",
                      //         "Your profile details has been udpated",
                      //         colorText: Colors.white,
                      //         backgroundColor: primary,
                      //         snackPosition: SnackPosition.BOTTOM);
                      //   },
                      //   textColor: Colors.white,
                      //   buttonColor: secondary,
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
