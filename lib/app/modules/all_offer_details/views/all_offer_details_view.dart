import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pink_ad/app/data/api_service.dart';
import 'package:pink_ad/app/modules/all_offer_details/controllers/all_offer_details_controller.dart';
import 'package:pink_ad/app/modules/profile/views/profile_view.dart';
import 'package:pink_ad/utilities/custom_widgets/custom_appbar_user.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utilities/colors/colors.dart';
import '../../../../utilities/custom_widgets/custom_appbar.dart';
import '../../../../utilities/custom_widgets/text_utils.dart';
import '../../../../utilities/utils.dart';

class AllOfferDetailsView extends GetView {
  final allOfferDetailsController = Get.put(AllOfferDetailsController());
  final arguments = Get.arguments as Map<String, dynamic>;
  AllOfferDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final userType = box.read('user_type');
    final data = arguments['data'] ?? '';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
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
                padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.h),
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['title'],
                      style: CustomTextView.getStyle(
                        context,
                        fontSize: 20.sp,
                        colorLight: Colors.black,
                        fontFamily: Utils.poppinsBold,
                      ),
                    ),
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
                    const SizedBox(height: 15.0),
                    Text(
                      'Seller\'s contacts',
                      style: CustomTextView.getStyle(
                        context,
                        colorLight: Colors.black,
                        fontSize: 16.sp,
                        fontFamily: Utils.poppinsSemiBold,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 45.h,
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
                          child: IconButton(
                            onPressed: () async {
                              String? facebookUrl = data['shop']?['seller']?['faecbook_page'];
                              if (facebookUrl == null) return;
                              try {
                                final String nativeUrl;
                                if (facebookUrl.toLowerCase().contains('facebook.com')) {
                                  if (!facebookUrl.startsWith('http')) {
                                    facebookUrl = 'https://' + facebookUrl;
                                  }
                                  nativeUrl = 'fb://facewebmodal/f?href=$facebookUrl';
                                } else {
                                  nativeUrl = 'fb://$facebookUrl';
                                }
                                await launchUrl(Uri.parse(nativeUrl));
                              } catch (e) {
                                // If the Facebook app is not installed, open the Facebook website
                                if (facebookUrl!.startsWith('http')) {
                                  await launchUrl(Uri.parse(facebookUrl));
                                }
                              }
                            },
                            icon: Center(
                              child: FaIcon(
                                FontAwesomeIcons.facebook,
                                size: 30.h,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Container(
                          height: 45.h,
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
                          child: IconButton(
                            onPressed: () async {
                              // final appInstalled = await canLaunchUrl(
                              //     Uri.parse('whatsapp://'));
                              // if (appInstalled) {
                              await launchUrl(
                                Uri.parse(
                                  // 'whatsapp://send?text=${data['title']}, ${data['description']},${data['shop']['name']},contact ${data['shop']['seller']['phone']}. $appUrl'));

                                  'whatsapp://send?phone=${data['shop']?['seller']?['whatsapp']}',
                                ),
                              );
                              // } else {
                              //   await launchUrl(Uri.parse(
                              //       'https://api.whatsapp.com/send?phone=03001234567'));
                              // }
                            },
                            icon: Center(
                              child: FaIcon(
                                FontAwesomeIcons.whatsapp,
                                size: 30.h,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Container(
                          height: 45.h,
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
                          child: IconButton(
                            onPressed: () async {
                              String? instaUrl = data['shop']?['seller']?['insta_page'];
                              print(instaUrl);
                              if (instaUrl == null) return;
                              try {
                                final String nativeUrl;
                                if (instaUrl.toLowerCase().contains('instagram.com')) {
                                  if (!instaUrl.startsWith('http')) {
                                    instaUrl = 'https://' + instaUrl;
                                  }
                                  final uri = Uri.parse(instaUrl);
                                  // Invalid URL
                                  if (uri.pathSegments.isEmpty) return;
                                  print(uri.pathSegments);
                                  nativeUrl = 'instagram://user?username=${uri.pathSegments.first}';
                                } else {
                                  nativeUrl = 'instagram://$instaUrl';
                                }
                                await launchUrl(Uri.parse(nativeUrl));
                              } catch (e) {
                                if (instaUrl!.startsWith('http')) {
                                  await launchUrl(Uri.parse(instaUrl));
                                }
                              }
                            },
                            icon: Center(
                              child: FaIcon(
                                FontAwesomeIcons.instagram,
                                size: 30.h,
                                color: Color(0xFFE4405D),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Container(
                          height: 45.h,
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
                          child: IconButton(
                            onPressed: () async {
                              final sellerUrl = data['shop']['seller']['seller_link'];
                              Share.share(
                                "${data['title']}"
                                "\n\n${data['description']} by ${data['shop']?['name'] ?? ''}"
                                '\n\n$sellerUrl'
                                '\n\n$appUrl',
                              );
                            },

                            icon: Center(
                              child: Icon(
                                Icons.share,
                                size: 25.h,
                              ),
                            ),
                            // FaIcon(
                            //   FontAwesomeIcons.shareFromSquare,
                            //   size: 30.h,
                            //   // color: Color(0xFFE4405D),
                            // ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
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
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 10.w,
                          height: MediaQuery.of(context).size.width - 40.w,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 10.h,
                            ),
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
                                ApiService.imageBaseUrl + data['banner'],
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 8.0,
                          ),
                          // alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Description',
                                style: CustomTextView.getStyle(
                                  context,
                                  colorLight: Colors.black,
                                  fontSize: 16.sp,
                                  fontFamily: Utils.poppinsSemiBold,
                                ),
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
                      ],
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 15.h,
              // ),
              // GlobalButton(
              //   title: 'Go To Seller Profile',
              //   onPressed: () {
              //     var sellerId = data['shop']['id'];
              //     Get.toNamed(
              //       Routes.SPECIFIC_SELLER,
              //       arguments: {'seller_id': sellerId},
              //     );
              //   },
              //   textColor: Colors.white,
              //   buttonColor: secondary,
              // ),
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
