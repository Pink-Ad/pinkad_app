import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pink_ad/app/data/api_service.dart';
import 'package:pink_ad/app/modules/profile/views/profile_view.dart';
import 'package:pink_ad/app/modules/specific_seller/controllers/specific_seller_controllers.dart';
import 'package:pink_ad/utilities/colors/colors.dart';
import 'package:pink_ad/utilities/custom_widgets/custom_appbar.dart';
import 'package:pink_ad/utilities/custom_widgets/custom_appbar_user.dart';
import 'package:pink_ad/utilities/custom_widgets/scafflod_dashboard.dart';
import 'package:pink_ad/utilities/custom_widgets/text_utils.dart';
import 'package:pink_ad/utilities/utils.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SpecificSellerView extends GetView<SpecificSellerController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SpecificSellerController());
    final box = GetStorage();
    final userType = box.read('user_type');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomBgDashboard(
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
                  : SizedBox(
                      height: 45.h,
                      child: UserAppBar(
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
                    ),
              SizedBox(
                height: 15.h,
              ),
              const SizedBox(height: 10.0),
              Text(
                '${controller.shopName.value} ${controller.sellerName.value}',
                style: CustomTextView.getStyle(
                  context,
                  colorLight: Colors.black,
                  fontSize: 16.sp,
                  fontFamily: Utils.poppinsSemiBold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
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
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                          String? facebookUrl = controller.facebookUrl.value;
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

                              'whatsapp://send?phone=${controller.whatsappNumber}',
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
                          String? instaUrl = controller.instaUrl.value;
                          print(instaUrl);
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
                          final sellerUrl = controller.sellerUrl;
                          Share.share(
                            '${controller.shopName} ${controller.sellerName}'
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
              ),
              Expanded(
                child: Obx(
                  () {
                    if (controller.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    } else if (controller.offers.isEmpty) {
                      return Center(child: Text('No offers available'));
                    }
                    return ListView.builder(
                      padding: EdgeInsets.only(bottom: 20.h, top: 5.h),
                      itemCount: controller.offers.length,
                      itemBuilder: (context, index) {
                        var offer = controller.offers[index];
                        return GestureDetector(
                          onTap: () {
                            var offerId = offer.id;
                            if (offerId != null) {
                              print('Tapped offer ID: $offerId');
                              controller.getOfferDetail(offerId);
                            } else {
                              print('Tapped offer ID is null.');
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              left: 20.0.w,
                              top: 10.h,
                              right: 20.0.w,
                            ),
                            padding: const EdgeInsets.all(10.0),
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
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color.fromARGB(
                                              255,
                                              147,
                                              147,
                                              147,
                                            ).withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: const Offset(3, 0),
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        child: Image.network(
                                          offer.banner != null
                                              ? ApiService.imageBaseUrl + offer.banner!
                                              : 'https://www.pulsecarshalton.co.uk/wp-content/uploads/2016/08/jk-placeholder-image.jpg',
                                          width: 60.w,
                                          height: 60.h,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Flexible(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            offer.title ?? 'No Title',
                                            style: CustomTextView.getStyle(
                                              context,
                                              colorLight: subHeadingColor,
                                              fontSize: 12.sp,
                                              fontFamily: Utils.poppinsSemiBold,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.clip,
                                          ),
                                          const SizedBox(height: 10.0),
                                          Text(
                                            offer.description ?? 'No Description',
                                            style: CustomTextView.getStyle(
                                              fontSize: 10.sp,
                                              context,
                                              colorLight: textColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
