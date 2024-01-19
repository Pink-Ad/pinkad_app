import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              // Container(
              //   height: 50.h,
              //   margin: EdgeInsets.symmetric(horizontal: 20.w),
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     border: Border.all(width: 1, color: tertiary),
              //     borderRadius: BorderRadius.circular(10),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.white.withOpacity(0.2),
              //         spreadRadius: 1,
              //         blurRadius: 5,
              //         offset: const Offset(0, 3),
              //       ),
              //     ],
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.only(
              //       left: 20.0,
              //       top: 10.0,
              //       bottom: 5.0,
              //       right: 5.0,
              //     ),
              //     child: TypeAheadField<dynamic>(
              //       animationStart: 0,
              //       animationDuration: Duration.zero,
              //       textFieldConfiguration: const TextFieldConfiguration(
              //         autofocus: false,
              //         style: TextStyle(fontSize: 15),
              //         decoration: InputDecoration(
              //           hintText: 'Search Seller',
              //           suffixIcon: Icon(
              //             Icons.shopping_bag_outlined,
              //             color: Colors.black,
              //             size: 30,
              //           ),
              //           border: InputBorder.none,
              //           focusColor: tertiary,
              //         ),
              //       ),
              //       hideOnError: true,
              //       suggestionsCallback: (pattern) {
              //         List matches = [];
              //         matches.addAll(controller.offers);
              //         matches.retainWhere((s) {
              //           return s['user']['name']
              //               .toLowerCase()
              //               .contains(pattern.toLowerCase());
              //         });
              //         return matches;
              //       },
              //       itemBuilder: (context, offer) {
              //         return GestureDetector(
              //           onTap: () {
              //             Get.find<SpecificSellerController>()
              //                 .fetchOffers(offer['shop'][0]['id']);
              //           },
              //           child: Container(
              //             decoration: BoxDecoration(
              //               color: Colors.white,
              //               border: Border(
              //                 bottom: BorderSide(
              //                   width: 2.w,
              //                   color: Colors.grey.shade600,
              //                 ),
              //               ),
              //             ),
              //             child: ListTile(
              //               leading: const Icon(
              //                 Icons.travel_explore,
              //                 color: primary,
              //               ),
              //               title: Text(
              //                 offer['user']['name'],
              //                 style: CustomTextView.getStyle(
              //                   context,
              //                   colorLight:
              //                       const Color.fromARGB(255, 41, 39, 39),
              //                   fontSize: 13.sp,
              //                   fontFamily: Utils.poppinsSemiBold,
              //                 ),
              //                 maxLines: 2,
              //                 overflow: TextOverflow.ellipsis,
              //               ),
              //               subtitle: Text(
              //                 offer['description'] ?? '',
              //                 style: CustomTextView.getStyle(
              //                   context,
              //                   colorLight:
              //                       const Color.fromARGB(255, 66, 66, 66),
              //                   fontSize: 11.sp,
              //                   fontFamily: Utils.poppinsLight,
              //                 ),
              //                 maxLines: 2,
              //                 overflow: TextOverflow.ellipsis,
              //               ),
              //             ),
              //           ),
              //         );
              //       },
              //       onSuggestionSelected: (suggestion) {},
              //     ),
              //   ),
              // ),
              Expanded(
                child: Obx(
                  () {
                    if (controller.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    } else if (controller.offers.isEmpty) {
                      return Center(child: Text('No offers available'));
                    }
                    return ListView.builder(
                      padding: EdgeInsets.only(bottom: 20.h, top: 10.h),
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
                                              ? ApiService.imageBaseUrl +
                                                  offer.banner!
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                            offer.description ??
                                                'No Description',
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

              // Obx(() {
              //   if (controller.offers.isEmpty) {
              //     return Center(child: CircularProgressIndicator());
              //   }
              //   return ListView.builder(
              //     itemCount: controller.offers.length,
              //     itemBuilder: (context, index) {
              //       var offer = controller.offers[index];
              //       return Card(
              //         margin: EdgeInsets.all(10),
              //         child: ListTile(
              //           title: Text(
              //             offer.title ?? 'No Title',
              //             style: TextStyle(
              //               fontSize: 16,
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),
              //           subtitle: Text(offer.description ?? 'No Description'),
              //           leading: offer.banner != null
              //               ? Image.network(
              //                   offer.banner!,
              //                   width: 50,
              //                   height: 50,
              //                   fit: BoxFit.cover,
              //                 )
              //               : SizedBox(width: 50, height: 50),
              //           // Implement onTap or other interactions as needed
              //         ),
              //       );
              //     },
              //   );
              // }),
            ],
          ),
        ),
      ),
    );
  }
}
