import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pink_ad/app/data/api_service.dart';
import 'package:pink_ad/app/models/login_response.dart';
import 'package:pink_ad/app/modules/all_shops/controllers/all_shops_controller.dart';
import 'package:pink_ad/app/modules/profile/views/profile_view.dart';
import 'package:pink_ad/app/modules/user_profile/controllers/user_profile_controller.dart';
import 'package:pink_ad/utilities/colors/colors.dart';
import 'package:pink_ad/utilities/custom_widgets/image_recommended_size.dart';
import 'package:pink_ad/utilities/custom_widgets/text_utils.dart';
import 'package:pink_ad/utilities/utils.dart';

import '../../../../utilities/custom_widgets/custom_appbar_user.dart';
import '../../../../utilities/custom_widgets/custom_button.dart';
import '../../../../utilities/custom_widgets/custom_text_field.dart';
import '../../../../utilities/custom_widgets/scafflod_dashboard.dart';
import '../../../routes/app_pages.dart';

class UserProfileView extends GetView {
  final box = GetStorage();
  final allShopsController = AllShopsController();
  UserProfileController userProfileController = UserProfileController();

  UserProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    List<dynamic> sellerShop = box.read('sellerShop') ?? [];
    LoginResponse data = box.read('user_data');
    FocusNode nameFocus = FocusNode();
    FocusNode phoneFocus = FocusNode();
    FocusNode whatsappFocus = FocusNode();
    FocusNode emailFocus = FocusNode();
    FocusNode businessNameFocus = FocusNode();
    FocusNode businessAddressFocus = FocusNode();
    FocusNode facebookFocus = FocusNode();
    FocusNode addressFocus = FocusNode();
    FocusNode branchNameFocus = FocusNode();
    FocusNode instagramFocus = FocusNode();
    FocusNode websiteUrlFocus = FocusNode();
    final userProfileController = Get.find<UserProfileController>();
    return CustomBgDashboard(
      child: SafeArea(
        child: Column(
          children: [
            UserAppBar(
              profileIconVisibility: false,
              backButton: true,
              title: "Profile",
              onMenuTap: () {
                print("object");
              },
              onProfileTap: () {
                print("object");
                Get.to(ProfileView());
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data.user!.name!,
                          style: CustomTextView.getStyle(context,
                              colorLight: Colors.white,
                              fontSize: 20.sp,
                              fontFamily: Utils.poppinsBold)),
                      const SizedBox(height: 5.0),
                      // RatingBar.builder(
                      //   initialRating: 3,
                      //   minRating: 1,
                      //   itemSize: 20,
                      //   direction: Axis.horizontal,
                      //   allowHalfRating: true,
                      //   itemCount: 5,
                      //   itemPadding:
                      //       const EdgeInsets.symmetric(horizontal: 1.0),
                      //   itemBuilder: (context, _) => const Icon(
                      //     Icons.star,
                      //     color: Colors.amber,
                      //   ),
                      //   onRatingUpdate: (rating) {
                      //     print(rating);
                      //   },
                      // ),
                      SizedBox(height: 5.0.h),
                      // Text(
                      //   'Followers: 150k',
                      //   style: CustomTextView.getStyle(context,
                      //       colorLight: Colors.white,
                      //       fontSize: 14.sp,
                      //       fontFamily: Utils.poppinsMedium),
                      //   maxLines: 1,
                      //   overflow: TextOverflow.ellipsis,
                      // ),
                      // const SizedBox(height: 5.0),
                    ],
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(
                  //       horizontal: 8.0, vertical: 10.0),
                  // child: Align(
                  //   alignment: Alignment.centerRight,
                  //   child: SvgPicture.asset(
                  //     "assets/svgIcons/cert_icon.svg",
                  //     color: Colors.white,
                  //   ),
                  // ),
                  // )
                ],
              ),
            ),
            SizedBox(
              height: 5.0.h,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Obx(
            //       () => SizedBox(
            //         height: 50.h,
            //         width: 330.w,
            //         child: ElevatedButton(
            //           onPressed: () {
            //             userProfileController.selectButton(0);
            //           },
            //           style: ElevatedButton.styleFrom(
            //               backgroundColor:
            //                   userProfileController.selectedButton.value == 0
            //                       ? secondary
            //                       : Colors.white,
            //               shape: const RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.only(
            //                     topLeft: Radius.circular(8),
            //                     topRight: Radius.circular(8.0)),
            //               )),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               SizedBox(
            //                 width: 5.w,
            //               ),
            //               Icon(
            //                 Icons.build_outlined,
            //                 color:
            //                     userProfileController.selectedButton.value == 0
            //                         ? Colors.white
            //                         : Colors.black,
            //               ),
            //               SizedBox(
            //                 width: 10.w,
            //               ),
            //               Text(
            //                 "Setting",
            //                 style: CustomTextView.getStyle(context,
            //                     colorLight: userProfileController
            //                                 .selectedButton.value ==
            //                             0
            //                         ? Colors.white
            //                         : Colors.black,
            //                     fontFamily: Utils.poppinsSemiBold,
            //                     fontSize: 14.sp),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //     // Obx(
            //     //   () => SizedBox(
            //     //     height: 50.h,
            //     //     width: 165.w,
            //     //     child: ElevatedButton(
            //     //       onPressed: () {
            //     //         userProfileController.selectButton(1);
            //     //       },
            //     //       style: ElevatedButton.styleFrom(
            //     //           backgroundColor:
            //     //               userProfileController.selectedButton.value == 1
            //     //                   ? secondary
            //     //                   : Colors.white,
            //     //           shape: const RoundedRectangleBorder(
            //     //             borderRadius: BorderRadius.only(
            //     //                 topLeft: Radius.circular(8),
            //     //                 topRight: Radius.circular(8.0)),
            //     //           )),
            //     //       child: Row(
            //     //         children: [
            //     //           SizedBox(
            //     //             width: 5.w,
            //     //           ),
            //     //           Icon(
            //     //             Icons.account_tree_outlined,
            //     //             color:
            //     //                 userProfileController.selectedButton.value == 1
            //     //                     ? Colors.white
            //     //                     : Colors.black,
            //     //           ),
            //     //           SizedBox(
            //     //             width: 10.w,
            //     //           ),
            //     //           Text(
            //     //             "Branches",
            //     //             style: CustomTextView.getStyle(context,
            //     //                 colorLight: userProfileController
            //     //                             .selectedButton.value ==
            //     //                         0
            //     //                     ? Colors.black
            //     //                     : Colors.white,
            //     //                 fontFamily: Utils.poppinsSemiBold,
            //     //                 fontSize: 14.sp),
            //     //           ),
            //     //         ],
            //     //       ),
            //     //     ),
            //     //   ),
            //     // )
            //   ],
            // ),

            Obx(
              () => userProfileController.selectedButton.value == 0
                  ? Expanded(
                      child: Center(
                        child: Container(
                            height: Get.height,
                            width: Get.width,
                            decoration: BoxDecoration(
                                color: containerColor,
                                border: Border.all(width: .5, color: secondary),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0))),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  ShadowedTextField(
                                    //onChanged: controller.username,
                                    focusNode: phoneFocus,
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context)
                                          .requestFocus(whatsappFocus);
                                    },
                                    controller: userProfileController
                                        .phoneNoController.value,
                                    hintText: '+923001234567',
                                    iconName: "phone",
                                    keyboardType: TextInputType.phone,
                                  ),
                                  ShadowedTextField(
                                    //onChanged: controller.username,
                                    focusNode: whatsappFocus,
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context)
                                          .requestFocus(emailFocus);
                                    },
                                    controller: userProfileController
                                        .whatsappNoController.value,
                                    hintText: '+923001234567',
                                    iconName: "whatsapp_icon",
                                    keyboardType: TextInputType.phone,
                                  ),
                                  // ShadowedTextField(
                                  //   focusNode: businessNameFocus,
                                  //   onFieldSubmitted: (v) {
                                  //     FocusScope.of(context)
                                  //         .requestFocus(branchNameFocus);
                                  //   },
                                  //   //onChanged: controller.username,
                                  //   controller: userProfileController
                                  //       .businessNameController.value,
                                  //   hintText: 'Business Name (optional)',
                                  //   iconName: "business",
                                  //   keyboardType: TextInputType.text,
                                  // ),
                                  ShadowedTextField(
                                    focusNode: businessAddressFocus,
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context)
                                          .requestFocus(facebookFocus);
                                    },
                                    //onChanged: controller.username,
                                    controller: userProfileController
                                        .businessAddressController.value,
                                    hintText: 'Business Address',
                                    iconName: "business_map",
                                    keyboardType: TextInputType.text,
                                  ),
                                  ShadowedTextField(
                                    focusNode: facebookFocus,
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context)
                                          .requestFocus(instagramFocus);
                                    },
                                    //onChanged: controller.username,
                                    controller: userProfileController
                                        .facebookController.value,
                                    hintText: 'Facebook URL',
                                    // hintText: 'e.g page/page_id',
                                    iconName: "facebook",
                                    keyboardType: TextInputType.text,
                                  ),
                                  ShadowedTextField(
                                    focusNode: instagramFocus,
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context)
                                          .requestFocus(websiteUrlFocus);
                                    },
                                    //onChanged: controller.username,
                                    controller: userProfileController
                                        .instagramController.value,
                                    hintText: 'Instagram URL',
                                    // hintText: 'e.g user?username=pinkad.pk',
                                    iconName: "insta",
                                    keyboardType: TextInputType.text,
                                  ),
                                  ShadowedTextField(
                                    focusNode: websiteUrlFocus,
                                    //onChanged: controller.username,
                                    controller: userProfileController
                                        .webSiteController.value,
                                    hintText: 'Website URL  (optional)',
                                    iconName: "website",
                                    keyboardType: TextInputType.text,
                                  ),
                                  Container(
                                    height: 55.0.h,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 20.w, vertical: 10.h),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0, vertical: 5.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 7,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: 15.0.w, right: 50.w),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                    "assets/svgIcons/image_icon.svg"),
                                                SizedBox(
                                                  width: 10.h,
                                                ),
                                                Obx(
                                                  () => SizedBox(
                                                    width: 170.w,
                                                    child: Text(
                                                      userProfileController
                                                              .logoName
                                                              .value
                                                              .isNotEmpty
                                                          ? userProfileController
                                                              .logoName.value
                                                          : 'Promotional Cover',
                                                      style: CustomTextView
                                                          .getStyle(context,
                                                              colorLight:
                                                                  textColor,
                                                              fontSize: 16.sp),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: GestureDetector(
                                            onTap: () {
                                              userProfileController.pickImage();
                                            },
                                            child: Container(
                                              height: Get.height,
                                              width: 50.w,
                                              decoration: BoxDecoration(
                                                color: secondary,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 2,
                                                    blurRadius: 7,
                                                    offset: const Offset(0, 3),
                                                  ),
                                                ],
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: SvgPicture.asset(
                                                    "assets/svgIcons/upload_file.svg"),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Align(
                                      alignment: Alignment.centerLeft,
                                      child: ImageRecommendedSizeText()),
                                  SizedBox(height: 25.h),
                                  Obx(() => userProfileController
                                          .isLoading.value
                                      ? const CircularProgressIndicator(
                                          color: primary,
                                        )
                                      : GlobalButton(
                                          title: "Update",
                                          onPressed: () {
                                            userProfileController.onSubmit();
                                            // Get.toNamed(Routes.User_Bottom_Nav_Bar);
                                          },
                                          textColor: Colors.white,
                                          buttonColor: secondary,
                                        )),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            )),
                      ),
                    )
                  : Expanded(
                      child: Center(
                        child: Container(
                          height: Get.height,
                          width: Get.width,
                          decoration: BoxDecoration(
                              color: containerColor,
                              border: Border.all(width: .5, color: secondary),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0))),
                          child: Stack(children: [
                            ListView.builder(
                              itemCount: sellerShop
                                  .length, // number of items in the list
                              itemBuilder: (BuildContext context, int index) {
                                print(sellerShop[index]);
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0.w, vertical: 3.h),
                                  child: Container(
                                    margin: const EdgeInsets.all(8.0),
                                    padding: const EdgeInsets.all(16.0),
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
                                    child: Stack(children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 50.0.w,
                                                height: 50.0.h,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: CircleAvatar(
                                                  radius: 38.0,
                                                  backgroundColor: Colors.grey,
                                                  backgroundImage: sellerShop[
                                                              index]['logo'] !=
                                                          null
                                                      ? NetworkImage(ApiService
                                                              .imageBaseUrl +
                                                          sellerShop[index]
                                                              ['logo'])
                                                      : const NetworkImage(
                                                          "https://www.pulsecarshalton.co.uk/wp-content/uploads/2016/08/jk-placeholder-image.jpg"),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: 10.0.w, top: 5.0.h),
                                                width: 140.w,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      sellerShop[index]
                                                              ['branch_name'] ??
                                                          '',
                                                      style: CustomTextView
                                                          .getStyle(context,
                                                              fontSize: 18.sp,
                                                              fontFamily: Utils
                                                                  .poppinsSemiBold,
                                                              colorLight:
                                                                  Colors.black),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    const SizedBox(height: 8.0),
                                                    // RatingBar.builder(
                                                    //   initialRating: 3,
                                                    //   minRating: 1,
                                                    //   itemSize: 15,
                                                    //   direction:
                                                    //       Axis.horizontal,
                                                    //   allowHalfRating: true,
                                                    //   itemCount: 5,
                                                    //   itemPadding:
                                                    //       const EdgeInsets
                                                    //               .symmetric(
                                                    //           horizontal: 1.0),
                                                    //   itemBuilder:
                                                    //       (context, _) =>
                                                    //           const Icon(
                                                    //     Icons.star,
                                                    //     color: ratingColor,
                                                    //   ),
                                                    //   onRatingUpdate: (rating) {
                                                    //     print(rating);
                                                    //   },
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  print(sellerShop[index]);
                                                  allShopsController
                                                      .getShopDetail(
                                                          sellerShop[index]
                                                              ['id']);

                                                  // Get.toNamed(
                                                  //     Routes.SHOP_DETAILS);
                                                },
                                                child: Container(
                                                  height: 40.h,
                                                  width: 88.w,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                    border: Border.all(
                                                      color: secondary,
                                                      width: 1.5,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text("Open",
                                                        style: CustomTextView
                                                            .getStyle(context,
                                                                colorLight:
                                                                    secondary,
                                                                fontSize: 16.sp,
                                                                fontFamily: Utils
                                                                    .poppinsSemiBold)),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ]),
                                  ),
                                );
                              },
                            ),
                            Positioned(
                              bottom: 16.0,
                              right: 16.0,
                              child: FloatingActionButton(
                                backgroundColor: secondary,
                                onPressed: () {
                                  Get.toNamed(Routes.ADD_SHOP);
                                  // Add your action here
                                },
                                child: const Icon(Icons.add),
                              ),
                            ),
                          ]),
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
