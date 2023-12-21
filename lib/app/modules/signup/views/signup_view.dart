import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pink_ad/app/modules/signup/controllers/signup_controller.dart';
import 'package:pink_ad/utilities/custom_widgets/image_recommended_size.dart';

import '../../../../utilities/colors/colors.dart';
import '../../../../utilities/custom_widgets/area_dropdown.dart';
import '../../../../utilities/custom_widgets/custom_bottom_button.dart';
import '../../../../utilities/custom_widgets/custom_button.dart';
import '../../../../utilities/custom_widgets/custom_dropdown.dart';
import '../../../../utilities/custom_widgets/custom_text_field.dart';
import '../../../../utilities/custom_widgets/my_scafflod.dart';
import '../../../../utilities/custom_widgets/text_utils.dart';
import '../../../routes/app_pages.dart';

class SignupView extends GetView<SignupController> {
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
  RxList temp = [].obs;

  SignupView({super.key});
  //FocusNode passFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CustomBackground(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding:
                    EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 30.0.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Seller Sign Up",
                        style: CustomTextView.getStyle(context,
                            colorLight: Colors.white,
                            fontSize: 24.sp,
                            fontFamily: "Radomir Tinkov - Gilroy-ExtraBold",
                            fontWeight: FontWeight.w700)),
                    SizedBox(
                      height: 7.0.h,
                    ),
                    Text(
                      "Area wise business directory and FREE classified solution for small businesses.",
                      style: CustomTextView.getStyle(context,
                          colorLight: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 80.h,
              ),
              SizedBox(
                height: Get.height * .58,
                width: Get.width * 1,
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          ShadowedTextField(
                            //onChanged: controller.username,
                            focusNode: nameFocus,
                            onFieldSubmitted: (v) {
                              FocusScope.of(context).requestFocus(phoneFocus);
                            },
                            controller: controller.nameController.value,
                            hintText: 'Seller / Shop Name',
                            iconName: "email_user",
                            keyboardType: TextInputType.text,
                          ),
                          ShadowedTextField(
                            //onChanged: controller.username,
                            focusNode: phoneFocus,
                            onFieldSubmitted: (v) {
                              FocusScope.of(context)
                                  .requestFocus(whatsappFocus);
                            },
                            controller: controller.phoneNoController.value,
                            hintText: '+923001234567',
                            iconName: "phone",
                            keyboardType: TextInputType.phone,
                          ),
                          ShadowedTextField(
                            //onChanged: controller.username,
                            focusNode: whatsappFocus,
                            onFieldSubmitted: (v) {
                              FocusScope.of(context).requestFocus(emailFocus);
                            },
                            controller: controller.whatsappNoController.value,
                            hintText: '+923001234567',
                            iconName: "whatsapp_icon",
                            keyboardType: TextInputType.phone,
                          ),
                          ShadowedTextField(
                            focusNode: emailFocus,
                            onFieldSubmitted: (v) {
                              FocusScope.of(context)
                                  .requestFocus(businessNameFocus);
                            },
                            // onChanged: controller.username,
                            controller: controller.emailController.value,
                            hintText: 'Email Address',
                            iconName: "email",
                            keyboardType: TextInputType.emailAddress,
                          ),
                          // ShadowedTextField(
                          //   focusNode: businessNameFocus,
                          //   onFieldSubmitted: (v) {
                          //     FocusScope.of(context)
                          //         .requestFocus(branchNameFocus);
                          //   },
                          //   //onChanged: controller.username,
                          //   controller: controller.businessNameController.value,
                          //   hintText: 'Business Name (optional)',
                          //   iconName: "business",
                          //   keyboardType: TextInputType.text,
                          // ),
                          // ShadowedTextField(
                          //   focusNode: branchNameFocus,
                          //   onFieldSubmitted: (v) {
                          //     FocusScope.of(context)
                          //         .requestFocus(businessAddressFocus);
                          //   },
                          //   //onChanged: controller.username,
                          //   controller: controller.branchNameController.value,
                          //   hintText: 'Branch Name',
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
                            controller:
                                controller.businessAddressController.value,
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
                            controller: controller.facebookController.value,
                            hintText: 'e.g page/page_id',
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
                            controller: controller.instagramController.value,
                            hintText: 'e.g user?username=pinkad.pk',
                            iconName: "insta",
                            keyboardType: TextInputType.text,
                          ),
                          ShadowedTextField(
                            focusNode: websiteUrlFocus,
                            //onChanged: controller.username,
                            controller: controller.webSiteController.value,
                            hintText: 'Website URL  (optional)',
                            iconName: "website",
                            keyboardType: TextInputType.text,
                          ),
                          // ShadowedTextField(
                          //   focusNode: addressFocus,
                          //   //onChanged: controller.username,
                          //   controller: controller.addressController.value,
                          //   hintText: 'Address',
                          //   iconName: "business_map",
                          //   keyboardType: TextInputType.text,
                          // ),
                          // CategoriesDropDown(),
                          AreaDropDown(),
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
                                              controller
                                                      .logoName.value.isNotEmpty
                                                  ? controller.logoName.value
                                                  : 'Business Logo',
                                              style: CustomTextView.getStyle(
                                                  context,
                                                  colorLight: textColor,
                                                  fontSize: 16.sp),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
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
                                      controller.pickImage();
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
                                            width: 210.w,
                                            child: Text(
                                              controller.coverLogoName.value
                                                      .isNotEmpty
                                                  ? controller
                                                      .coverLogoName.value
                                                  : 'Promotional Cover (optional)',
                                              style: CustomTextView.getStyle(
                                                  context,
                                                  colorLight: textColor,
                                                  fontSize: 16.sp),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
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
                                      controller.pickCoverImage();
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
                          ShadowedTextField(
                            hintText: 'Description',
                            iconName: 'description',
                            controller: controller.descriptionController.value,
                            keyboardType: TextInputType.multiline,
                          ),
                          Obx(
                            () => ShadowedTextField(
                              // focusNode: passwordFocus,
                              // onChanged: controller.password,
                              hintText: 'Password',
                              iconName: "password",
                              keyboardType: TextInputType.text,
                              controller: controller.passwordController.value,
                              obscureText: !controller.isPasswordVisible.value,
                              suffixIcon: IconButton(
                                onPressed: () =>
                                    controller.isPasswordVisible.toggle(),
                                icon: controller.isPasswordVisible.value
                                    ? const Icon(
                                        Icons.visibility_off,
                                        color: textColor,
                                      )
                                    : const Icon(
                                        Icons.visibility,
                                        color: textColor,
                                      ),
                              ),
                            ),
                          ),
                          MyDropdown(),
                          SizedBox(height: 25.h),
                          Obx(
                            () => controller.isLoading.value
                                ? const CircularProgressIndicator(
                                    color: primary,
                                  )
                                : GlobalButton(
                                    title: "Seller Sign Up",
                                    onPressed: () {
                                      // controller.isFormValid() ? controller.registerUser : showSnackBarError("Error", "Fill all fields");
                                      controller.onSubmit();

                                      // Get.toNamed(Routes.Bottom_Nav_Bar);
                                    },
                                    textColor: Colors.white,
                                    buttonColor: secondary,
                                  ),
                          ),
                          SizedBox(height: 20.h),
                          Column(
                            children: [
                              const Text(
                                'Already have an account?',
                                style: TextStyle(
                                  color: tertiary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SizedBox(
                                height: 7.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.LOGIN);
                                  // Navigate to sign up screen
                                },
                                child: Text('Login',
                                    style: CustomTextView.getStyle(context,
                                        colorLight: secondary,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Poppins-Medium")),
                              ),
                              SizedBox(
                                height: 7.h,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      Align(
          alignment: Alignment.bottomCenter,
          child: BottomButtons(
            buttonText: "AS USER",
            onTap: () {
              Get.toNamed(Routes.CHAT_INBOX);
            },
          )),
      if (controller.isLoading.value) const MyProcessLoading()
    ]);
  }
}

class MyProcessLoading extends StatelessWidget {
  const MyProcessLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: const Color.fromRGBO(0, 0, 0, 0.6),
        child: const Center(child: CircularProgressIndicator(color: primary)),
      ),
    );
  }
}
