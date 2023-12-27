import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pink_ad/app/modules/home/controllers/home_controller.dart';
import 'package:pink_ad/app/modules/profile/views/profile_view.dart';
import 'package:pink_ad/utilities/colors/colors.dart';
import 'package:pink_ad/utilities/custom_widgets/area_dropdown_upload.dart';
import 'package:pink_ad/utilities/custom_widgets/categories_dropdown.dart';
import 'package:pink_ad/utilities/custom_widgets/image_recommended_size.dart';
import 'package:pink_ad/utilities/custom_widgets/loader.dart';
import 'package:pink_ad/utilities/custom_widgets/text_utils.dart';
import 'package:pink_ad/utilities/utils.dart';

import '../../../../utilities/custom_widgets/custom_appbar_user.dart';
import '../../../../utilities/custom_widgets/custom_button.dart';
import '../../../../utilities/custom_widgets/custom_text_field.dart';
import '../../../../utilities/custom_widgets/scafflod_dashboard.dart';
import '../controllers/upload_offer_controller.dart';

class UploadOfferView extends GetView {
  final uploadOfferController = Get.put(UploadOfferController());
  HomeController homeController = Get.put(HomeController());

  UploadOfferView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> options = ['Shop1', 'Shop2'];
    List<String> selectedOption = [];

    return CustomBgDashboard(
      child: SafeArea(
        child: Column(
          children: [
            UserAppBar(
              profileIconVisibility: true,
              showBanner: true,
              backButton: false,
              title: 'Upload Offer',
              onMenuTap: () {
                print('object');
              },
              onProfileTap: () {
                print('object');
                Get.to(ProfileView());
              },
            ),
            Expanded(
              child: ListView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                children: [
                  Center(
                    child: Container(
                      width: Get.width,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: const BoxDecoration(
                        color: containerColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // uploadOfferController.emailVerified == null
                                //     ? Container(
                                //         margin:
                                //             EdgeInsets.only(left: 20.w, top: 20.h),
                                //         child: Text(
                                //           'Note: Please verify your email',
                                //           style: TextStyle(
                                //               fontSize: 16.sp, color: Colors.red),
                                //         ),
                                //       )
                                //     : SizedBox(),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 20.w,
                                    bottom: 10.h,
                                  ),
                                  child: Text(
                                    'Add Offer',
                                    style: CustomTextView.getStyle(
                                      context,
                                      colorLight: Colors.black,
                                      fontFamily: Utils.poppinsBold,
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ),
                                ShadowedTextField(
                                  //onChanged: controller.username,
                                  hintText: 'Title',
                                  iconName: 'tag',
                                  controller: uploadOfferController.titleController.value,
                                  keyboardType: TextInputType.text,
                                ),
                                // ShadowedTextField(
                                //   hintText: 'Description',
                                //   iconName: 'description',
                                //   controller: uploadOfferController
                                //       .descriptionController.value,
                                //   keyboardType: TextInputType.multiline,
                                // ),
                                Container(
                                  height: 80.h,
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 20.w,
                                    vertical: 10.h,
                                  ),
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
                                          controller: uploadOfferController.descriptionController.value,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Description',
                                            hintStyle: TextStyle(fontSize: 18.sp),
                                            isDense: true,
                                            contentPadding: EdgeInsets.symmetric(
                                              vertical: 10.h,
                                            ),
                                          ),
                                          style: TextStyle(fontSize: 14.sp),
                                          maxLines: null,
                                          keyboardType: TextInputType.multiline,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 50.0.h,
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 20.w,
                                    vertical: 10.h,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5.0,
                                    vertical: 5.0,
                                  ),
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
                                            left: 15.0.w,
                                            right: 50.w,
                                          ),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                'assets/svgIcons/image_icon.svg',
                                              ),
                                              SizedBox(
                                                width: 10.h,
                                              ),
                                              Obx(
                                                () => SizedBox(
                                                  width: 170.w,
                                                  child: Text(
                                                    uploadOfferController.imageName.value.isNotEmpty
                                                        ? uploadOfferController.imageName.value
                                                        : 'Upload Image',
                                                    style: CustomTextView.getStyle(
                                                      context,
                                                      colorLight: textColor,
                                                      fontSize: 16.sp,
                                                    ),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: GestureDetector(
                                          onTap: () {
                                            uploadOfferController.pickImage();
                                          },
                                          child: Container(
                                            height: Get.height,
                                            width: 50.w,
                                            decoration: BoxDecoration(
                                              color: secondary,
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
                                            child: Padding(
                                              padding: const EdgeInsets.all(15),
                                              child: SvgPicture.asset(
                                                'assets/svgIcons/upload_file.svg',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const ImageRecommendedSizeText(),
                                // ShadowedTextField(
                                //   //onChanged: controller.username,
                                //   hintText: 'Hashtag',
                                //   iconName: 'hashtag',
                                //   controller:
                                //       uploadOfferController.hashtagController.value,
                                //   keyboardType: TextInputType.text,
                                // ),
                                CategoriesDropDown(),
                                AreaDropDownUpload(),
                                // Container(
                                //   height: 50.h,
                                //   width: Get.width,
                                //   margin: EdgeInsets.symmetric(
                                //       horizontal: 20.w, vertical: 10.h),
                                //   padding: EdgeInsets.only(
                                //       left: 20.0.w,
                                //       right: 20.w,
                                //       top: 5.h,
                                //       bottom: 5.h),
                                //   decoration: BoxDecoration(
                                //     color: Colors.white,
                                //     borderRadius: BorderRadius.circular(8.0),
                                //     boxShadow: [
                                //       BoxShadow(
                                //         color: Colors.grey.withOpacity(0.5),
                                //         spreadRadius: 0,
                                //         blurRadius: 5,
                                //         offset: const Offset(0, 3),
                                //       ),
                                //     ],
                                //   ),
                                //   child: DropDownMultiSelect(
                                //     selected_values_style: CustomTextView.getStyle(
                                //         context,
                                //         colorLight: textColor,
                                //         fontSize: 15.sp),
                                //     onChanged: (List<String> value) {
                                //       selectedOption = value;
                                //       // setState(() {
                                //       // });
                                //     },
                                //     // options: list,
                                //     selectedValues: selectedOption,
                                //     decoration: const InputDecoration(
                                //       border: InputBorder.none,
                                //     ),

                                //     whenEmpty: 'Select Shops', options: options,
                                //   ),
                                // ),

                                Container(
                                  margin: EdgeInsets.only(
                                    left: 20.w,
                                    right: 10.w,
                                    top: 10.h,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Featured Now?',
                                        style: CustomTextView.getStyle(
                                          context,
                                          colorLight: textColor,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                      Obx(
                                        () => Switch(
                                          thumbIcon: MaterialStatePropertyAll(
                                            Icon(
                                              Icons.circle,
                                              color: secondary,
                                            ),
                                          ),
                                          value: uploadOfferController.switchValue.value,
                                          onChanged: (bool newValue) {
                                            uploadOfferController.toggleSwitchValue();
                                            uploadOfferController.activeColor.value = newValue ? Colors.green : Colors.red;
                                          },

                                          inactiveThumbColor: secondary,
                                          activeColor: secondary,
                                          // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 20.w,
                                  ),
                                  child: Text(
                                    'Note: Offer will be visible for 7 days only',
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 25.h),
                                Obx(
                                  () => uploadOfferController.isLoading.value
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                            color: primary,
                                          ),
                                        )
                                      : GlobalButton(
                                          title: 'Upload',
                                          onPressed: () {
                                            // controller.isFormValid() ? controller.registerUser : showSnackBarError("Error", "Fill all fields");
                                            // uploadOfferController.uploadOffers();
                                            // Get.toNamed(Routes.Bottom_Nav_Bar);
                                            // uploadOfferController.emailVerified ==
                                            //         null
                                            //     ? uploadOfferController
                                            //         .showUnverifiedDialog()
                                            //     :
                                            uploadOfferController.showAwesomeDialog();
                                          },
                                          textColor: Colors.white,
                                          buttonColor: secondary,
                                        ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                            Obx(
                              () => homeController.isLoading.isTrue ? const MyLoading() : Container(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
