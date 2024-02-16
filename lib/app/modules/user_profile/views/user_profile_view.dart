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
import 'package:pink_ad/app/routes/app_pages.dart';
import 'package:pink_ad/utilities/colors/colors.dart';
import 'package:pink_ad/utilities/custom_widgets/area_dropdown.dart';
import 'package:pink_ad/utilities/custom_widgets/custom_button.dart';
import 'package:pink_ad/utilities/custom_widgets/custom_text_field.dart';
import 'package:pink_ad/utilities/custom_widgets/phone_input_field.dart';
import 'package:pink_ad/utilities/custom_widgets/text_utils.dart';
import 'package:pink_ad/utilities/functions/loading_wrapper.dart';
import 'package:pink_ad/utilities/utils.dart';

import '../../../../utilities/custom_widgets/custom_appbar_user.dart';
import '../../../../utilities/custom_widgets/scafflod_dashboard.dart';

class UserProfileView extends GetView<UserProfileController> {
  final box = GetStorage();
  final allShopsController = AllShopsController();
  final userProfileController = Get.find<UserProfileController>();

  UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBgDashboard(
      isUserProfileView: true,
      child: SafeArea(
        child: Column(
          children: [
            UserAppBar(
              profileIconVisibility: false,
              backButton: true,
              title: 'Profile',
              onMenuTap: () {
                print('object');
              },
              onProfileTap: () {
                print('object');
                Get.to(ProfileView());
              },
            ),
            SizedBox(height: 10.h),
            // Buttons for "Profile" and "Change Password"
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Obx(
                      () => ElevatedButton(
                        onPressed: () => controller.selectButton(0),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: controller.selectedButton.value == 0 ? secondary : Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                              // topLeft: Radius.circular(8),
                              // topRight: Radius.circular(8.0),
                            ),
                          ),
                          padding: EdgeInsets.all(16.0),
                        ),
                        child: Text(
                          'Profile',
                          style: CustomTextView.getStyle(
                            context,
                            colorLight: controller.selectedButton.value == 0 ? Colors.white : Colors.black,
                            fontFamily: Utils.poppinsSemiBold,
                            fontSize: 13.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w), // Space between buttons
                  Expanded(
                    child: Obx(
                      () => ElevatedButton(
                        onPressed: () => controller.selectButton(1),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: controller.selectedButton.value == 1 ? secondary : Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                              // topLeft: Radius.circular(8),
                              // topRight: Radius.circular(8.0),
                            ),
                          ),
                          padding: EdgeInsets.all(16.0),
                        ),
                        child: Text(
                          'Change Password',
                          style: CustomTextView.getStyle(
                            context,
                            colorLight: controller.selectedButton.value == 1 ? Colors.white : Colors.black,
                            fontFamily: Utils.poppinsSemiBold,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h),
            // Content based on selected button
            Expanded(
              child: Obx(() {
                switch (controller.selectedButton.value) {
                  case 0:
                    return ProfileContent(); // Your Profile content widget
                  case 1:
                    return ChangePasswordContent(); // Your Change Password content widget
                  default:
                    return ProfileContent(); // Default view
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class ChangePasswordContent extends GetView<UserProfileController> {
  final userProfileController = Get.find<UserProfileController>();

  FocusNode currentpasswordFocus = FocusNode();
  FocusNode newpasswordFocus = FocusNode();
  FocusNode confirmpasswordFocus = FocusNode();
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Obx(
                () => ShadowedTextField(
                  hintText: 'Current Password',
                  iconName: 'current password',
                  keyboardType: TextInputType.text,
                  controller: userProfileController.currentpasswordController.value,
                  obscureText: !userProfileController.isCurrentPasswordVisible.value,
                  suffixIcon: IconButton(
                    onPressed: () => userProfileController.isCurrentPasswordVisible.toggle(),
                    icon: userProfileController.isCurrentPasswordVisible.value
                        ? const Icon(Icons.visibility_off, color: textColor)
                        : const Icon(Icons.visibility, color: textColor),
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              Obx(
                () => ShadowedTextField(
                  hintText: 'New Password',
                  iconName: 'new password',
                  keyboardType: TextInputType.text,
                  controller: userProfileController.newpasswordController.value,
                  obscureText: !userProfileController.isNewPasswordVisible.value,
                  suffixIcon: IconButton(
                    onPressed: () => userProfileController.isNewPasswordVisible.toggle(),
                    icon: userProfileController.isNewPasswordVisible.value
                        ? const Icon(Icons.visibility_off, color: textColor)
                        : const Icon(Icons.visibility, color: textColor),
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              Obx(
                () => ShadowedTextField(
                  hintText: 'Confirm Password',
                  iconName: 'confirm password',
                  keyboardType: TextInputType.text,
                  controller: userProfileController.confirmpasswordController.value,
                  obscureText: !userProfileController.isConfirmPasswordVisible.value,
                  suffixIcon: IconButton(
                    onPressed: () => userProfileController.isConfirmPasswordVisible.toggle(),
                    icon: userProfileController.isConfirmPasswordVisible.value
                        ? const Icon(Icons.visibility_off, color: textColor)
                        : const Icon(Icons.visibility, color: textColor),
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Obx(
                () => userProfileController.isLoading.value
                    ? Center(
                        child: const CircularProgressIndicator(
                        color: primary,
                      ))
                    : GlobalButton(
                        title: 'Change Password',
                        onPressed: () {
                          userProfileController.onChange();
                        },
                        textColor: Colors.white,
                        buttonColor: secondary,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileContent extends GetView<UserProfileController> {
  final box = GetStorage();
  final allShopsController = AllShopsController();
  final userProfileController = Get.find<UserProfileController>();
  ProfileContent({super.key});
  @override
  Widget build(BuildContext context) {
    List<dynamic> sellerShop = box.read('sellerShop') ?? [];
    LoginResponse data = box.read('user_data');
    FocusNode nameFocus = FocusNode();
    FocusNode phoneFocus = FocusNode();
    FocusNode whatsappFocus = FocusNode();
    FocusNode emailFocus = FocusNode();
    FocusNode businessAddressFocus = FocusNode();
    FocusNode facebookFocus = FocusNode();
    FocusNode instagramFocus = FocusNode();
    FocusNode websiteUrlFocus = FocusNode();
    final userProfileController = Get.find<UserProfileController>();
    return SafeArea(
      child: Column(
        children: [
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
                              ShadowedTextField(
                                //onChanged: controller.username,
                                focusNode: nameFocus,
                                onFieldSubmitted: (v) {
                                  FocusScope.of(context).requestFocus(phoneFocus);
                                },
                                controller: userProfileController.nameController.value,
                                hintText: 'Seller / Shop Name',
                                iconName: 'email_user',
                                keyboardType: TextInputType.text,
                              ),
                              CustomPhoneInputField(
                                focusNode: phoneFocus,
                                onFieldSubmitted: (v) {
                                  FocusScope.of(context).requestFocus(whatsappFocus);
                                },
                                controller: userProfileController.phoneNoController.value,
                                hintText: 'XXX-XXXXXXX',
                                iconName: 'phone',
                                textInputAction: TextInputAction.next,
                              ),
                              CustomPhoneInputField(
                                focusNode: whatsappFocus,
                                onFieldSubmitted: (v) {
                                  FocusScope.of(context).requestFocus(emailFocus);
                                },
                                controller: userProfileController.whatsappNoController.value,
                                hintText: 'XXX-XXXXXXX',
                                iconName: 'whatsapp_icon',
                                textInputAction: TextInputAction.next,
                              ),
                              ShadowedTextField(
                                focusNode: businessAddressFocus,
                                onFieldSubmitted: (v) {
                                  FocusScope.of(context).requestFocus(facebookFocus);
                                },
                                //onChanged: controller.username,
                                controller: userProfileController.businessAddressController.value,
                                hintText: 'Business Address',
                                iconName: 'business_map',
                                keyboardType: TextInputType.text,
                              ),
                              ShadowedTextField(
                                focusNode: facebookFocus,
                                onFieldSubmitted: (v) {
                                  FocusScope.of(context).requestFocus(instagramFocus);
                                },
                                //onChanged: controller.username,
                                controller: userProfileController.facebookController.value,
                                hintText: 'Facebook URL (Optional)',
                                // hintText: 'e.g page/page_id',
                                iconName: 'facebook',
                                keyboardType: TextInputType.text,
                              ),
                              ShadowedTextField(
                                focusNode: instagramFocus,
                                onFieldSubmitted: (v) {
                                  FocusScope.of(context).requestFocus(websiteUrlFocus);
                                },
                                //onChanged: controller.username,
                                controller: userProfileController.instagramController.value,
                                hintText: 'Instagram URL (Optional)',
                                // hintText: 'e.g user?username=pinkad.pk',
                                iconName: 'insta',
                                keyboardType: TextInputType.text,
                              ),
                              ShadowedTextField(
                                focusNode: websiteUrlFocus,
                                //onChanged: controller.username,
                                controller: userProfileController.webSiteController.value,
                                hintText: 'Website URL (optional)',
                                iconName: 'website',
                                keyboardType: TextInputType.text,
                              ),
                              Obx(() {
                                return AreaDropDown(
                                  areas: userProfileController.areaName.toList(),
                                  cities: userProfileController.citiesName.toList(),
                                  onAreaChanged: (value) {
                                    userProfileController.selectedarea.value = value;
                                  },
                                  onCityChanged: (value) {
                                    userProfileController.selectedCity.value = value;
                                    userProfileController.selectedarea.value = null;
                                    userProfileController.areaName.value = [];
                                    loadingWrapper(() => userProfileController.getAreas(value!.id));
                                  },
                                  selectedArea: userProfileController.selectedarea.value,
                                  selectedCity: userProfileController.selectedCity.value,
                                );
                              }),
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
                                                  userProfileController.logoName.value.isNotEmpty
                                                      ? userProfileController.logoName.value
                                                      : 'Profile Picture',
                                                  style: CustomTextView.getStyle(
                                                    context,
                                                    colorLight: textColor,
                                                    fontSize: 15.sp,
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
                                          userProfileController.pickImage();
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
                                                width: 200.w,
                                                child: Text(
                                                  userProfileController.coverLogoName.value.isNotEmpty
                                                      ? userProfileController.coverLogoName.value
                                                      : 'Cover/Promotional Image',
                                                  style: CustomTextView.getStyle(
                                                    context,
                                                    colorLight: textColor,
                                                    fontSize: 13.sp,
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
                                          userProfileController.pickCoverImage();
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
                              Container(
                                height: 100.h,
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
                                        controller: userProfileController.descriptionController.value,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Description',
                                          hintStyle: CustomTextView.getStyle(
                                            context,
                                            fontSize: 15.sp,
                                          ),
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
                              // Align(
                              //   alignment: Alignment.centerLeft,
                              //   child: Container(
                              //     margin: EdgeInsets.only(
                              //       left: 20.w,
                              //     ),
                              //     child: Text(
                              //       'This image will be used for your profile promotion (Recommended size 1080px by 1080px)',
                              //       style: TextStyle(
                              //         fontSize: 11.sp,
                              //         color: Colors.red,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              SizedBox(height: 10.h),
                              Obx(
                                () => userProfileController.isLoading.value
                                    ? const CircularProgressIndicator(
                                        color: primary,
                                      )
                                    : GlobalButton(
                                        title: 'Update',
                                        onPressed: () {
                                          userProfileController.onSubmit();
                                          // Get.toNamed(Routes.User_Bottom_Nav_Bar);
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
                            topRight: Radius.circular(20.0),
                          ),
                        ),
                        child: Stack(
                          children: [
                            ListView.builder(
                              itemCount: sellerShop.length, // number of items in the list
                              itemBuilder: (BuildContext context, int index) {
                                print(sellerShop[index]);
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.0.w,
                                    vertical: 3.h,
                                  ),
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
                                    child: Stack(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
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
                                                    backgroundImage: sellerShop[index]['logo'] != null
                                                        ? NetworkImage(
                                                            ApiService.imageBaseUrl + sellerShop[index]['logo'],
                                                          )
                                                        : const NetworkImage(
                                                            'https://www.pulsecarshalton.co.uk/wp-content/uploads/2016/08/jk-placeholder-image.jpg',
                                                          ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                    left: 10.0.w,
                                                    top: 5.0.h,
                                                  ),
                                                  width: 140.w,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        sellerShop[index]['branch_name'] ?? '',
                                                        style: CustomTextView.getStyle(
                                                          context,
                                                          fontSize: 18.sp,
                                                          fontFamily: Utils.poppinsSemiBold,
                                                          colorLight: Colors.black,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                      const SizedBox(
                                                        height: 8.0,
                                                      ),
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
                                                    allShopsController.getShopDetail(
                                                      sellerShop[index]['id'],
                                                    );

                                                    // Get.toNamed(
                                                    //     Routes.SHOP_DETAILS);
                                                  },
                                                  child: Container(
                                                    height: 40.h,
                                                    width: 88.w,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(30.0),
                                                      border: Border.all(
                                                        color: secondary,
                                                        width: 1.5,
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        'Open',
                                                        style: CustomTextView.getStyle(
                                                          context,
                                                          colorLight: secondary,
                                                          fontSize: 16.sp,
                                                          fontFamily: Utils.poppinsSemiBold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
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
