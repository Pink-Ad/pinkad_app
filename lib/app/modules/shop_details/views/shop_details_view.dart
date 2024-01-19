import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pink_ad/app/data/api_service.dart';
import 'package:pink_ad/app/modules/profile/views/profile_view.dart';
import 'package:pink_ad/app/modules/shop_details/controllers/shop_details_controller.dart';
import 'package:pink_ad/app/routes/app_pages.dart';
import 'package:pink_ad/utilities/custom_widgets/custom_appbar_user.dart';
import 'package:pink_ad/utilities/utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utilities/colors/colors.dart';
import '../../../../utilities/custom_widgets/custom_appbar.dart';
import '../../../../utilities/custom_widgets/custom_button.dart';
import '../../../../utilities/custom_widgets/text_utils.dart';

class ShopDetailsView extends GetView {
  final shopDetailsController = Get.put(ShopDetailsController());
  final arguments = Get.arguments as Map<String, dynamic>;

  ShopDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final userType = box.read('user_type');
    final data = arguments['data'] ?? '';
    final seller = arguments['seller'] ?? '';
    // String facebookUrl = 'fb://${data['seller']['faecbook_page']}';
    String? facebookUrl = data['seller']['faecbook_page'];
    // const String facebookUrl = "https://www.facebook.com/";
    String logoUrl = data['seller']['coverimage'] != null
        ? ApiService.imageBaseUrl + data['seller']['coverimage']
        : 'https://www.pulsecarshalton.co.uk/wp-content/uploads/2016/08/jk-placeholder-image.jpg';
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg_home.png'),
              fit: BoxFit.cover,
            ),
          ),
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
                        title: 'All Shops',
                        onMenuTap: () {
                          print('object');
                        },
                        onProfileTap: () {
                          print('object');
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
                            style: CustomTextView.getStyle(
                              context,
                              fontSize: 20.sp,
                              colorLight: Colors.black,
                              fontFamily: Utils.poppinsBold,
                            ),
                          ),
                          // Text(
                          //   'Description',
                          //   style: CustomTextView.getStyle(
                          //     context,
                          //     colorLight: Colors.black,
                          //     fontSize: 16.sp,
                          //     fontFamily: Utils.poppinsSemiBold,
                          //   ),
                          // ),
                          const SizedBox(height: 5),
                          Text(
                            data['description'] ?? '',
                            // 'Lorem ipsum dolor sit amet onstetur adipiscing elit ',
                            style: CustomTextView.getStyle(
                              context,
                              colorLight: textColor,
                              fontSize: 15.sp,
                            ),
                          ),
                          //const SizedBox(height: 10.0),
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
                          //SizedBox(height: 15.0.h),
                          // Text(
                          //   // 'www.yourwebsite.com',
                          //   data['seller']['web_url'] ?? '',
                          //   style: CustomTextView.getStyle(
                          //     context,
                          //     fontSize: 16.sp,
                          //     colorLight: Colors.black,
                          //   ),
                          //   maxLines: 1,
                          //   overflow: TextOverflow.ellipsis,
                          // ),
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
                                onTap: facebookUrl != null &&
                                        facebookUrl.isNotEmpty
                                    ? () async {
                                        // Share.share(facebookUrl);
                                        print(facebookUrl);
                                        final Uri nativeUrl;
                                        if (facebookUrl!
                                            .toLowerCase()
                                            .contains('facebook.com')) {
                                          if (!facebookUrl!
                                              .startsWith('http')) {
                                            facebookUrl =
                                                'https://' + facebookUrl!;
                                          }
                                          nativeUrl = Uri.parse(
                                            'fb://facewebmodal/f?href=$facebookUrl',
                                          );
                                        } else {
                                          nativeUrl =
                                              Uri.parse('fb://$facebookUrl');
                                        }
                                        try {
                                          final success =
                                              await launchUrl(nativeUrl);
                                          if (!success) throw '';
                                        } catch (e) {
                                          // If the Facebook app is not installed, open the Facebook website
                                          if (!facebookUrl!
                                              .startsWith('http')) {
                                            facebookUrl =
                                                'https://facebook.com/${nativeUrl.pathSegments.last}';
                                          }
                                          await launchUrl(
                                            Uri.parse(facebookUrl!),
                                            mode:
                                                LaunchMode.externalApplication,
                                          );
                                        }
                                      }
                                    : null,
                                child: Opacity(
                                  opacity: facebookUrl != null &&
                                          facebookUrl!.isNotEmpty
                                      ? 1
                                      : 0.7,
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
                                          'assets/svgIcons/facebook.svg',
                                          color: facebookUrl != null &&
                                                  facebookUrl!.isNotEmpty
                                              ? null
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 15.w),
                              GestureDetector(
                                onTap: data['seller']['whatsapp'] != null &&
                                        data['seller']['whatsapp'].isNotEmpty
                                    ? () async {
                                        // Replace 'whatsapp://send?phone=${data['seller']['whatsapp']}' with your actual logic to launch WhatsApp.
                                        await launchUrl(
                                          Uri.parse(
                                            'whatsapp://send?phone=${data['seller']['whatsapp']}',
                                          ),
                                        );
                                      }
                                    : null, // Disable the onTap when WhatsApp number is not available
                                child: Opacity(
                                  opacity: data['seller']['whatsapp'] != null &&
                                          data['seller']['whatsapp'].isNotEmpty
                                      ? 1
                                      : 0.5, // Make icon translucent if disabled
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
                                        'assets/svgIcons/whatsapp_icon.svg',
                                        color: data['seller']['whatsapp'] !=
                                                    null &&
                                                data['seller']['whatsapp']
                                                    .isNotEmpty
                                            ? null
                                            : Colors
                                                .grey, // Change color if disabled
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 15.w),
                              GestureDetector(
                                onTap: data['seller']['insta_page'] != null &&
                                        data['seller']['insta_page'].isNotEmpty
                                    ? () async {
                                        String? instaUrl =
                                            data['seller']['insta_page'];
                                        if (instaUrl == null) return;
                                        final Uri nativeUrl;
                                        if (instaUrl
                                            .toLowerCase()
                                            .contains('instagram.com')) {
                                          if (!instaUrl.startsWith('http')) {
                                            instaUrl = 'https://' + instaUrl;
                                          }
                                          final uri = Uri.parse(instaUrl);
                                          // Invalid URL
                                          if (uri.pathSegments.isEmpty) return;
                                          nativeUrl = Uri.parse(
                                            'instagram://user?username=${uri.pathSegments.first}',
                                          );
                                        } else {
                                          nativeUrl = Uri.parse(
                                            'instagram://$instaUrl',
                                          );
                                        }
                                        try {
                                          final success =
                                              await launchUrl(nativeUrl);
                                          if (!success) throw '';
                                        } catch (e) {
                                          if (!instaUrl.startsWith('http')) {
                                            instaUrl =
                                                'https://instagram.com/${nativeUrl.queryParameters['username']}';
                                          }
                                          await launchUrl(
                                            Uri.parse(instaUrl),
                                            mode:
                                                LaunchMode.externalApplication,
                                          );
                                        }
                                      }
                                    : null, // Disable onTap when Instagram page is not available
                                child: Opacity(
                                  opacity:
                                      data['seller']['insta_page'] != null &&
                                              data['seller']['insta_page']
                                                  .isNotEmpty
                                          ? 1
                                          : 0.7, // Adjust opacity if disabled
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
                                        'assets/svgIcons/insta.svg',
                                        color: data['seller']['insta_page'] !=
                                                    null &&
                                                data['seller']['insta_page']
                                                    .isNotEmpty
                                            ? null
                                            : Colors
                                                .grey, // Change color if disabled
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 15.w),
                              GestureDetector(
                                onTap: data['seller']['web_url'] != null &&
                                        Uri.tryParse(
                                              data['seller']['web_url'],
                                            ) !=
                                            null
                                    ? () async {
                                        final url = Uri.parse(
                                          data['seller']['web_url'],
                                        );
                                        await launchUrl(
                                          url,
                                          mode: LaunchMode.externalApplication,
                                        );
                                      }
                                    : null,
                                child: Opacity(
                                  opacity: data['seller']['web_url'] != null &&
                                          Uri.tryParse(
                                                data['seller']['web_url'],
                                              ) !=
                                              null
                                      ? 0.6
                                      : 0.5, // Adjust opacity if disabled
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
                                      child: Icon(
                                        Icons.language,
                                        color:
                                            data['seller']['web_url'] != null &&
                                                    Uri.tryParse(
                                                          data['seller']
                                                              ['web_url'],
                                                        ) !=
                                                        null
                                                ? null
                                                : Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 15.w),
                              GestureDetector(
                                onTap: data['address'] != null
                                    ? () async {
                                        shopDetailsController.showAwesomeDialog(
                                          title: 'Address',
                                          content: data['address'] ??
                                              'No address available',
                                          confirmButtonText: 'Close',
                                          confirmButtonColor: bodyTextColor,
                                          onConfirm: () => Get.back(),
                                          showCancelButton: false,
                                        );
                                      }
                                    : null, // Disable onTap when address is not available
                                child: Opacity(
                                  opacity: data['address'] != null
                                      ? 1
                                      : 0.5, // Adjust opacity if disabled
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
                                      padding: const EdgeInsets.only(left: 2.0),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          'assets/svgIcons/location.svg',
                                          color: data['address'] != null
                                              ? null
                                              : Colors
                                                  .grey, // Change color if disabled
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
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
                SizedBox(
                  width: MediaQuery.of(context).size.width - 10.w,
                  height: MediaQuery.of(context).size.width - 40.w,
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      child: Image.network(
                        logoUrl,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                seller
                    // true
                    ? GlobalButton(
                        title: 'Delete Shop',
                        onPressed: () {
                          shopDetailsController.showAwesomeDialog(
                            title: 'Are you sure?',
                            content: 'Do you really want to delete this shop?',
                            confirmButtonText: 'Delete',
                            confirmButtonColor: errorColor,
                            onConfirm: () {
                              // Code to handle deletion
                            },
                          );
                        },
                        textColor: Colors.white,
                        buttonColor: errorColor,
                      )
                    : GlobalButton(
                        title: 'Go To Seller Profile',
                        onPressed: () {
                          // await launchUrl(
                          //   Uri.parse(data['seller']['web_url']),
                          //   mode: LaunchMode.externalApplication,
                          // );
                          var sellerId = data['seller']
                              ['id']; // Get the seller ID from the data
                          Get.toNamed(
                            Routes.SPECIFIC_SELLER,
                            arguments: {'seller_id': sellerId},
                          );
                        },
                        textColor: Colors.white,
                        buttonColor: secondary,

                        // buttonColor: data['seller']['web_url'] == null
                        //     ? Colors.grey
                        //     : secondary,
                      ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
