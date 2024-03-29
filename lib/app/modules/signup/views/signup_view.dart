import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pink_ad/app/modules/signup/controllers/signup_controller.dart';
import 'package:pink_ad/utilities/custom_widgets/phone_input_field.dart';
import 'package:pink_ad/utilities/functions/loading_wrapper.dart';

import '../../../../utilities/colors/colors.dart';
import '../../../../utilities/custom_widgets/area_dropdown.dart';
import '../../../../utilities/custom_widgets/custom_bottom_button.dart';
import '../../../../utilities/custom_widgets/custom_button.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SignupView({super.key});
  //FocusNode passFocus = FocusNode();

  TextEditingController phoneController = TextEditingController();

  String? validatePakistaniPhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    value = value.replaceAll('-', ''); // Remove dashes before validation
    if (value.length != 11) {
      return 'The phone number must be 10 digits long';
    }
    if (!RegExp(r'^[0-9]{11}$').hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  String? validateWhatsppNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'WhatsApp number is required';
    }
    value = value.replaceAll('-', '');
    if (value.length != 11) {
      return 'The WhatsApp number must be 10 digits long';
    }
    if (!RegExp(r'^[0-9]{11}$').hasMatch(value)) {
      return 'Enter a valid WhatsApp number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Get.put(SignupController());

    return Stack(
      children: [
        CustomBackground(
          header: Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 30.0.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Seller Sign Up',
                  style: CustomTextView.getStyle(
                    context,
                    colorLight: Colors.white,
                    fontSize: 24.sp,
                    fontFamily: 'Radomir Tinkov - Gilroy-ExtraBold',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 7.0.h,
                ),
                Text(
                  'Area wise business directory and FREE classified solution for small businesses.',
                  style: CustomTextView.getStyle(
                    context,
                    colorLight: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          child: Form(
            key: _formKey,
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: [
                Column(
                  children: [
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
                                  iconName: 'email_user',
                                  keyboardType: TextInputType.text,
                                ),
                                // ShadowedTextField(
                                //   //onChanged: controller.username,
                                //   focusNode: phoneFocus,
                                //   onFieldSubmitted: (v) {
                                //     FocusScope.of(context)
                                //         .requestFocus(whatsappFocus);
                                //   },
                                //   controller: controller.phoneNoController.value,
                                //   hintText: '+923001234567',
                                //   iconName: 'phone',
                                //   keyboardType: TextInputType.phone,
                                // ),
                                // TextFormField(
                                //   controller: phoneController,
                                //   keyboardType: TextInputType.phone,
                                //   decoration: InputDecoration(
                                //     labelText: 'Phone Number',
                                //     hintText: '+92XXXXXXXXXX',
                                //   ),
                                //   inputFormatters: [
                                //     // Add a custom formatter here
                                //     ConstantPrefixFormatter(prefix: '+92'),
                                //   ],
                                //   validator: validatePakistaniPhoneNumber,
                                // ),

                                CustomPhoneInputField(
                                  controller: controller.phoneNoController.value,
                                  focusNode: phoneFocus,
                                  hintText: 'XXX-XXXXXXX',
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (v) {
                                    FocusScope.of(context).requestFocus(whatsappFocus);
                                  },
                                  validator: validatePakistaniPhoneNumber,
                                  iconName: 'phone',
                                ),
                                CustomPhoneInputField(
                                  controller: controller.whatsappNoController.value,
                                  focusNode: whatsappFocus,
                                  onFieldSubmitted: (v) {
                                    FocusScope.of(context).requestFocus(emailFocus);
                                  },
                                  hintText: 'XXX-XXXXXXX',
                                  textInputAction: TextInputAction.next,
                                  validator: validateWhatsppNumber,
                                  iconName: 'whatsapp_icon',
                                ),
                                // ShadowedTextField(
                                //   //onChanged: controller.username,
                                //   focusNode: whatsappFocus,
                                //   onFieldSubmitted: (v) {
                                //     FocusScope.of(context)
                                //         .requestFocus(emailFocus);
                                //   },
                                //   controller:
                                //       controller.whatsappNoController.value,
                                //   hintText: '+923001234567',
                                //   iconName: 'whatsapp_icon',
                                //   keyboardType: TextInputType.phone,
                                // ),
                                ShadowedTextField(
                                  focusNode: emailFocus,
                                  onFieldSubmitted: (v) {
                                    FocusScope.of(context).requestFocus(businessNameFocus);
                                  },
                                  // onChanged: controller.username,
                                  controller: controller.emailController.value,
                                  hintText: 'Email Address',
                                  iconName: 'email',
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
                                    FocusScope.of(context).requestFocus(facebookFocus);
                                  },
                                  //onChanged: controller.username,
                                  controller: controller.businessAddressController.value,
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
                                  controller: controller.facebookController.value,
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
                                  controller: controller.instagramController.value,
                                  hintText: 'Instagram URL (Optional)',
                                  // hintText: 'e.g user?username=pinkad.pk',
                                  iconName: 'insta',
                                  keyboardType: TextInputType.text,
                                ),
                                ShadowedTextField(
                                  focusNode: websiteUrlFocus,
                                  //onChanged: controller.username,
                                  controller: controller.webSiteController.value,
                                  hintText: 'Website URL  (optional)',
                                  iconName: 'website',
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
                                Obx(() {
                                  return AreaDropDown(
                                    areas: controller.areaName.toList(),
                                    cities: controller.citiesName.toList(),
                                    onAreaChanged: (value) {
                                      controller.selectedarea.value = value;
                                    },
                                    onCityChanged: (value) {
                                      controller.selectedCity.value = value;
                                      controller.selectedarea.value = null;
                                      controller.areaName.value = [];
                                      loadingWrapper(() => controller.getAreas(value!.id));
                                    },
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
                                                    controller.logoName.value.isNotEmpty ? controller.logoName.value : 'Profile Picture',
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

                                // const Align(
                                //   alignment: Alignment.centerLeft,
                                //   child: ImageRecommendedSizeText(),
                                // ),
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
                                                  width: 210.w,
                                                  child: Text(
                                                    controller.coverLogoName.value.isNotEmpty
                                                        ? controller.coverLogoName.value
                                                        : 'Cover/Promotional Image',
                                                    style: CustomTextView.getStyle(
                                                      context,
                                                      colorLight: textColor,
                                                      fontSize: 13.5.sp,
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
                                            controller.pickCoverImage();
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
                                // ShadowedTextField(
                                //   hintText: 'Description',
                                //   iconName: 'description',
                                //   controller: controller.descriptionController.value,
                                //   keyboardType: TextInputType.multiline,
                                // ),
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
                                          controller: controller.descriptionController.value,
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
                                Obx(
                                  () => ShadowedTextField(
                                    // focusNode: passwordFocus,
                                    // onChanged: controller.password,
                                    hintText: 'Password',
                                    iconName: 'password',
                                    keyboardType: TextInputType.text,
                                    controller: controller.passwordController.value,
                                    obscureText: !controller.isPasswordVisible.value,
                                    suffixIcon: IconButton(
                                      onPressed: () => controller.isPasswordVisible.toggle(),
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
                                //MyDropdown(),
                                SizedBox(height: 25.h),
                                Obx(
                                  () => controller.isLoading.value
                                      ? const CircularProgressIndicator(
                                          color: primary,
                                        )
                                      : GlobalButton(
                                          title: 'Seller Sign Up',
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
                                      child: Text(
                                        'Login',
                                        style: CustomTextView.getStyle(
                                          context,
                                          colorLight: secondary,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Poppins-Medium',
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 25),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: BottomButtons(
            buttonText: 'AS USER',
            onTap: () {
              Get.toNamed(Routes.CHAT_INBOX);
            },
          ),
        ),
        if (controller.isLoading.value) const MyProcessLoading(),
      ],
    );
  }
}

// Custom formatter that ensures '+92' is always present
class ConstantPrefixFormatter extends TextInputFormatter {
  final String prefix;

  ConstantPrefixFormatter({required this.prefix});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (!newValue.text.startsWith(prefix)) {
      return TextEditingValue(
        text: prefix,
        selection: TextSelection.collapsed(offset: prefix.length),
      );
    }
    return newValue;
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
