import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pink_ad/app/data/api_service.dart';
import 'package:pink_ad/app/modules/profile/views/profile_view.dart';
import 'package:pink_ad/app/modules/shop_details/controllers/shop_details_controller.dart';
import 'package:pink_ad/utilities/custom_widgets/custom_appbar_user.dart';
import 'package:pink_ad/utilities/utils.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utilities/colors/colors.dart';
import '../../../../utilities/custom_widgets/custom_appbar.dart';
import '../../../../utilities/custom_widgets/custom_button.dart';
import '../../../../utilities/custom_widgets/text_utils.dart';

class ShopDetailsView extends GetView {
  final shopDetailsController = Get.put(ShopDetailsController());
  final arguments = Get.arguments as Map<String, dynamic>;

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final token = box.read('user_token');
    final data = arguments['data'] ?? '';
    final seller = arguments['seller'] ?? '';
    String facebookUrl = 'fb://${data['seller']['faecbook_page']}' ??
        'fb://https://www.facebook.com/';
    // const String facebookUrl = "https://www.facebook.com/";
    String logoUrl = data['seller']['coverimage'] != null
        ? ApiService.imageBaseUrl + data['seller']['coverimage']
        : "https://www.pulsecarshalton.co.uk/wp-content/uploads/2016/08/jk-placeholder-image.jpg";
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
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            // 'Shop Name',
                            data['name'] ?? '',
                            style: CustomTextView.getStyle(context,
                                fontSize: 20.sp,
                                colorLight: Colors.black,
                                fontFamily: Utils.poppinsBold)),
                        const SizedBox(height: 10.0),
                        // RatingBar.builder(
                        //   initialRating: 3,
                        //   minRating: 1,
                        //   itemSize: 15,
                        //   direction: Axis.horizontal,
                        //   allowHalfRating: true,
                        //   itemCount: 5,
                        //   itemPadding:
                        //   const EdgeInsets.symmetric(horizontal: 1.0),
                        //   itemBuilder: (context, _) => const Icon(
                        //     Icons.star,
                        //     color: Colors.amber,
                        //   ),
                        //   onRatingUpdate: (rating) {
                        //     print(rating);
                        //   },
                        // ),
                        SizedBox(height: 15.0.h),
                        Text(
                          // 'www.yourwebsite.com',
                          data['seller']['web_url'] ?? '',
                          style: CustomTextView.getStyle(
                            context,
                            fontSize: 16.sp,
                            colorLight: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 15.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // GestureDetector(
                            //   onTap: () {
                            //     Get.to(ShopDetailsView());
                            //   },
                            //   child: Container(
                            //       height: 40.h,
                            //       width: 139.w,
                            //       decoration: BoxDecoration(
                            //         color: secondary,
                            //         borderRadius: BorderRadius.circular(8.0),
                            //         border: Border.all(
                            //           color: secondary,
                            //         ),
                            //       ),
                            //       child: Center(
                            //           child: Text("Follow",
                            //               style: CustomTextView.getStyle(
                            //                   context,
                            //                   fontSize: 16.sp,
                            //                   colorLight: Colors.white,
                            //                   fontFamily:
                            //                       Utils.poppinsMedium)))),
                            // ),
                            GestureDetector(
                              onTap: () async {
                                // Share.share(facebookUrl);

                                if (await canLaunchUrl(
                                    Uri.parse(facebookUrl))) {
                                  await launchUrl(Uri.parse(facebookUrl));
                                } else {
                                  // If the Facebook app is not installed, open the Facebook website
                                  await launchUrl(Uri.parse(facebookUrl));
                                }
                              },
                              child: Container(
                                  height: 40.h,
                                  width: 40.w,
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
                            SizedBox(width: 15.w),
                            GestureDetector(
                              onTap: () async {
                                // final appInstalled = await canLaunchUrl(
                                //     Uri.parse('whatsapp://'));
                                // if (appInstalled) {
                                print(data);
                                await launchUrl(Uri.parse(
                                    // 'whatsapp://send?phone=03001234567'));
                                    'whatsapp://send?phone=${data['seller']['whatsapp']}'));
                                // 'whatsapp://send?text=${data['name']},contact ${data['seller']['phone']}. $appUrl'));

                                // 'whatsapp://send?text=${data['seller']['whatsapp']}'));
                                // } else {
                                //   await launchUrl(Uri.parse(
                                //       'https://api.whatsapp.com/send?phone=03001234567'));
                                // }
                              },
                              child: Container(
                                  height: 40.h,
                                  width: 40.w,
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
                            SizedBox(width: 15.w),
                            GestureDetector(
                              onTap: () async {
                                // Share.share(data['seller']['insta_page']);

                                print(data['seller']['insta_page']);
                                final url = Uri.parse(
                                    'instagram://${data['seller']['insta_page']}');

                                if (data['seller']['insta_page'] != null) {
                                  // await launchUrl(Uri.parse('instagram://'));
                                  await launchUrl(url);
                                } else {
                                  await launchUrl(
                                      Uri.parse('https://www.instagram.com/'));
                                }
                              },
                              child: Container(
                                  height: 40.h,
                                  width: 40.w,
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
                          ],
                        ),
                      ],
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 10.0),
                    //   child: Align(
                    //     alignment: Alignment.centerRight,
                    //     child:
                    //         SvgPicture.asset("assets/svgIcons/cert_icon.svg"),
                    //   ),
                    // )
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
                            image: NetworkImage(logoUrl),
                            fit: BoxFit.cover, // or any other value for fit
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Address',
                                  style: CustomTextView.getStyle(context,
                                      colorLight: Colors.black,
                                      fontSize: 16.sp,
                                      fontFamily: Utils.poppinsSemiBold),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  data['address'] ?? '',
                                  // 'Lorem ipsum dolor sit amet onstetur adipiscing elit ',
                                  style: CustomTextView.getStyle(
                                    context,
                                    colorLight: textColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  'Description',
                                  style: CustomTextView.getStyle(context,
                                      colorLight: Colors.black,
                                      fontSize: 16.sp,
                                      fontFamily: Utils.poppinsSemiBold),
                                ),
                                const SizedBox(height: 5),
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
              seller
                  // true
                  ? GlobalButton(
                      title: "Delete Shop",
                      onPressed: () {
                        shopDetailsController.showAwesomeDialog();
                      },
                      textColor: Colors.white,
                      buttonColor: errorColor,
                    )
                  : GlobalButton(
                      title: "Go To Seller Website",
                      onPressed: () async {
                        await launchUrl(Uri.parse(data['seller']['web_url']));
                      },
                      textColor: Colors.white,
                      buttonColor: data['seller']['web_url'] == null
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
