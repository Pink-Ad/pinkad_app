import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:pink_ad/app/modules/profile/views/profile_view.dart';
import 'package:pink_ad/utilities/custom_widgets/custom_appbar_user.dart';
import 'package:pink_ad/utilities/custom_widgets/scafflod_dashboard.dart';

import '../controllers/terms_controller.dart';

class TermsView extends GetView<TermsController> {
  const TermsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomBgDashboard(
      child: SafeArea(
        child: Column(
          children: [
            UserAppBar(
              profileIconVisibility: true,
              backButton: true,
              title: "Terms & Condition",
              size: 18,
              onMenuTap: () {
                print("object");
              },
              onProfileTap: () {
                print("object");
                Get.to(ProfileView());
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 30.h),
              padding: EdgeInsets.only(left: 20.w),
              alignment: Alignment.centerLeft,
              child: const Text('Terms And Conditions',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 70.h),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      description(
                          'These Terms and Conditions govern your use of the PinkAd mobile app as seller provided by pinkad.pk, and set forth the rights and obligations between you and pinkad.pk. By downloading, installing, accessing, or using the App, you agree to be bound by these Terms. If you do not agree with these Terms, please do not use the App.'),
                      SizedBox(height: 10.h),
                      heading('App Usage and Access :'),
                      SizedBox(height: 10.h),
                      description(
                          '1.1 Seller Account: You are responsible for maintaining the confidentiality of your account credentials and are liable for any activities conducted through your account.'),
                      SizedBox(height: 10.h),
                      heading('User Content :'),
                      SizedBox(height: 10.h),
                      description(
                          '2.1 Responsibility: By using the App, you may generate or provide content, such as text, images, or other materials. You retain ownership of your User Content, but by submitting it, you grant the App Provider a worldwide, non-exclusive, royalty-free license to use, reproduce, modify, adapt, publish, translate, distribute, and display your User Content.'),
                      description(
                          '2.2 Compliance: You agree that your User Content will not violate any applicable laws, regulations, or third-party rights. pinkad.pk reserves the right to remove or disable any User Content that violates these our seller guideline or is deemed inappropriate or harmful.'),
                      SizedBox(height: 10.h),
                      heading('Privacy :'),
                      SizedBox(height: 10.h),
                      description(
                          '3.1 Data Collection: The App may collect and process certain personal information in accordance with the App Provider’s Privacy Policy. By using the App, you consent to such data collection and processing.'),
                      description(
                          '3.2 Third-Party Services: We may engage trusted third-party service providers to assist us in delivering and improving our services. These service providers may have access to your personal information but are obligated to maintain its confidentiality and only process it as instructed by us.'),
                      SizedBox(height: 10.h),
                      heading('Disclaimers and Limitations of Liability :'),
                      SizedBox(height: 10.h),
                      description(
                          '4.1 Disclaimer of Warranties: The App may collect and process certain personal information in accordance with the App Provider’s Privacy Policy. By using the App, you consent to such data collection and processing.'),
                      description(
                          '4.2 Limitation of Liability: We may engage trusted third-party service providers to assist us in delivering and improving our services. These service providers may have access to your personal information but are obligated to maintain its confidentiality and only process it as instructed by us.'),
                      SizedBox(height: 10.h),
                      heading('Termination :'),
                      SizedBox(height: 10.h),
                      description(
                          '4.1 Termination: The App may collect and process certain personal information in accordance with the PinkAd Privacy Policy. By using the App, you consent to such data collection and processing.'),
                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Text description(String description) {
    return Text(description,
        textAlign: TextAlign.justify,
        style: const TextStyle(color: Colors.black));
  }

  Text heading(String heading) {
    return Text(
      heading,
      style: const TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      textAlign: TextAlign.start,
    );
  }
}
