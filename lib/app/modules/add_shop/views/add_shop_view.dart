import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pink_ad/app/modules/add_shop/controllers/add_shop_controller.dart';
import 'package:pink_ad/app/modules/profile/views/profile_view.dart';
import 'package:pink_ad/utilities/colors/colors.dart';
import 'package:pink_ad/utilities/custom_widgets/area_dropdown_shop.dart';
import 'package:pink_ad/utilities/custom_widgets/text_utils.dart';

import '../../../../utilities/custom_widgets/custom_appbar_user.dart';
import '../../../../utilities/custom_widgets/custom_button.dart';
import '../../../../utilities/custom_widgets/custom_text_field.dart';
import '../../../../utilities/custom_widgets/scafflod_dashboard.dart';

class AddShopView extends GetView<AddShopController> {
  const AddShopView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBgDashboard(
      child: Column(
        children: [
          UserAppBar(
            profileIconVisibility: false,
            backButton: true,
            title: 'Add Shop',
            onMenuTap: () {
              print('object');
            },
            onProfileTap: () {
              print('object');
              Get.to(ProfileView());
            },
          ),
          Expanded(
            child: Center(
              child: Container(
                height: Get.height,
                width: Get.width,
                decoration: BoxDecoration(
                  color: containerColor,
                  border: Border.all(width: .5, color: secondary),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      // ShadowedTextField(
                      //   //onChanged: controller.username,
                      //   hintText: ' Name',
                      //   iconName: 'email_user',
                      //   controller: controller.nameController.value,
                      //   keyboardType: TextInputType.text,
                      // ),
                      ShadowedTextField(
                        //onChanged: controller.username,
                        hintText: 'Branch Name',
                        iconName: 'business',
                        controller: controller.businessNameController.value,
                        keyboardType: TextInputType.text,
                      ),
                      ShadowedTextField(
                        //onChanged: controller.username,
                        hintText: 'Branch Contact Number',
                        iconName: 'phone',
                        controller: controller.phoneController.value,
                        keyboardType: TextInputType.phone,
                      ),
                      ShadowedTextField(
                        //onChanged: controller.username,
                        hintText: 'Branch Address',
                        controller: controller.addressController.value,
                        iconName: 'business_map',
                        keyboardType: TextInputType.text,
                      ),
                      ShopAreaDropDown(),
                      Container(
                        height: 55.0.h,
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
                                          controller.logoName.value.isNotEmpty
                                              ? controller.logoName.value
                                              : 'Promotional Cover',
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
                                  controller.pickImage();
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
                                    padding: const EdgeInsets.all(15.0),
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
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 20.w,
                          ),
                          child: Text(
                            'This image will be used for your profile promotion (Recommended size 1080px by 1080px)',
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      // ShadowedTextField(
                      //   //onChanged: controller.username,
                      //   hintText: 'Email address',
                      //   iconName: 'email',
                      //   keyboardType: TextInputType.emailAddress,
                      // ),
                      // ShadowedTextField(
                      //   //onChanged: controller.username,
                      //   hintText: 'Business Name',
                      //   iconName: 'business',
                      //   keyboardType: TextInputType.text,
                      // ),

                      // ShadowedTextField(
                      //   //onChanged: controller.username,
                      //   hintText: 'Business Address',
                      //   iconName: 'business_map',
                      //   keyboardType: TextInputType.text,
                      // ),
                      // ShadowedTextField(
                      //   //onChanged: controller.username,
                      //   hintText: 'Facebook Page',
                      //   iconName: 'facebook',
                      //   keyboardType: TextInputType.text,
                      // ),
                      // ShadowedTextField(
                      //   //onChanged: controller.username,
                      //   hintText: 'Website URL',
                      //   iconName: 'website',
                      //   keyboardType: TextInputType.text,
                      // ),
                      ShadowedTextField(
                        //onChanged: controller.username,
                        hintText: 'Description',
                        controller: controller.descriptionController.value,
                        iconName: 'description',
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 25.h),
                      Obx(
                        () => controller.isLoading.value
                            ? const CircularProgressIndicator(
                                color: primary,
                              )
                            : GlobalButton(
                                title: 'Add Shop',
                                onPressed: () {
                                  controller.onSubmit();
                                },
                                textColor: Colors.white,
                                buttonColor: secondary,
                              ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
