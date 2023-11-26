import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pink_ad/app/data/api_service.dart';
import 'package:pink_ad/app/modules/home/controllers/home_controller.dart';
import 'package:pink_ad/app/modules/profile/views/profile_view.dart';
import 'package:pink_ad/utilities/custom_widgets/custom_appbar_user.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utilities/colors/colors.dart';
import '../../../../utilities/custom_widgets/custom_appbar.dart';
import '../../../../utilities/custom_widgets/custom_button.dart';
import '../../../../utilities/custom_widgets/main_controlller.dart';
import '../../../../utilities/custom_widgets/text_utils.dart';
import '../../../../utilities/utils.dart';
import 'package:http/http.dart' as http;

class AllOfferDetailsView extends GetView {
  AllOfferDetailsView({super.key});
  final arguments = Get.arguments as Map<String, dynamic>;
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final token = box.read('user_token');
    final data = arguments['data'];
    final seller = arguments['seller'];
    print(data);
    HomeController homeController = HomeController();
    final MainControllers mainControllers = MainControllers();
    final ApiService _apiService = ApiService(http.Client());

    const String facebookUrl = "https://www.facebook.com/";
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg_home.png"),
            fit: BoxFit.cover,
          ),
        ),
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
                      title: "All Shops",
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
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                padding:
                    EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.h),
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data['title'],
                        style: CustomTextView.getStyle(context,
                            fontSize: 20.sp,
                            colorLight: Colors.black,
                            fontFamily: Utils.poppinsBold)),
                    const SizedBox(height: 10.0),
                    Text(
                      data['shop']['name'] ?? '',
                      style: CustomTextView.getStyle(
                        context,
                        fontSize: 15.sp,
                        colorLight: textColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            // Share.share(
                            //     data['shop']['seller']['faecbook_page']);
                            if (await canLaunchUrl(Uri.parse(
                                data['shop']['seller']['faecbook_page']))) {
                              await launchUrl(Uri.parse(
                                  'fb://${data['shop']['seller']['faecbook_page']}'));
                            } else {
                              // If the Facebook app is not installed, open the Facebook website
                              await launchUrl(Uri.parse(facebookUrl));
                            }
                          },
                          child: Container(
                              height: 40.h,
                              width: 45.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Center(
                                    child: SvgPicture.asset(
                                  "assets/svgIcons/facebook.svg",
                                )),
                              )),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        GestureDetector(
                          onTap: () async {
                            // final appInstalled = await canLaunchUrl(
                            //     Uri.parse('whatsapp://'));
                            // if (appInstalled) {
                            await launchUrl(Uri.parse(
                                // 'whatsapp://send?text=${data['title']}, ${data['description']},${data['shop']['name']},contact ${data['shop']['seller']['phone']}. $appUrl'));

                                'whatsapp://send?phone=${data['shop']['seller']['whatsapp']}'));
                            // } else {
                            //   await launchUrl(Uri.parse(
                            //       'https://api.whatsapp.com/send?phone=03001234567'));
                            // }
                          },
                          child: Container(
                              height: 40.h,
                              width: 45.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                    "assets/svgIcons/whatsapp_icon.svg"),
                              )),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        GestureDetector(
                          onTap: () async {
                            // Share.share(data['shop']['seller']['insta_page']);
                            if (data['shop']['seller']['insta_page'] != null) {
                              await launchUrl(Uri.parse(
                                  'instagram://${data['shop']['seller']['insta_page']}'));
                            } else {
                              await launchUrl(
                                  Uri.parse('https://www.instagram.com/'));
                            }
                          },
                          child: Container(
                              height: 40.h,
                              width: 45.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                    "assets/svgIcons/insta.svg"),
                              )),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        GestureDetector(
                          onTap: () async {
                            Share.share(
                                "${data['title']}, ${data['description']},${data['shop']['name'] ?? ''},contact ${data['shop']['seller']['faecbook_page']}. $appUrl");

                            // homeController.showCustomDialog(data);
                          },
                          child: Container(
                              height: 40.h,
                              width: 45.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Icon(Icons.share),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  height: 360.h,
                  decoration: BoxDecoration(
                    color: containerGray,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.9),
                        spreadRadius: 1,
                        blurRadius: 9,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 167.h,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0)),
                          image: DecorationImage(
                            image: NetworkImage(
                                ApiService.imageBaseUrl + data['banner']),
                            fit: BoxFit.cover, // or any other value for fit
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 20.0),
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text(
                                //   'Address',
                                //   style: CustomTextView.getStyle(context,
                                //       colorLight: Colors.black,
                                //       fontSize: 16.sp,
                                //       fontFamily: Utils.poppinsSemiBold),
                                // ),
                                // const SizedBox(height: 8),
                                // Text(
                                //   'Lorem ipsum dolor sit amet onstetur adipiscing elit ',
                                //   style: CustomTextView.getStyle(
                                //     context,
                                //     colorLight: textColor,
                                //   ),
                                // ),
                                Text(
                                  'Description',
                                  style: CustomTextView.getStyle(context,
                                      colorLight: Colors.black,
                                      fontSize: 16.sp,
                                      fontFamily: Utils.poppinsSemiBold),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  data['description'] ?? '',
                                  // 'Lorem ipsum dolor sit amet onstetur adipiscing elit ',
                                  style: CustomTextView.getStyle(
                                    context,
                                    colorLight: textColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              GlobalButton(
                title: "Go To Seller Website",
                onPressed: () async {
                  await launchUrl(Uri.parse(data["shop"]["seller"]["web_url"]));
                  Map data1 = {
                    "offer_id": data['id'].toString(),
                    "reach": 1.toString()
                  };
                  await _apiService.postData('insights/update', data1);
                },
                textColor: Colors.white,
                buttonColor: data["shop"]["seller"]["web_url"] == null
                    ? Colors.grey
                    : secondary,
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
