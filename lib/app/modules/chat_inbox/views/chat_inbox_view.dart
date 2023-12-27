import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pink_ad/app/models/cites_model.dart';
import 'package:pink_ad/app/modules/chat_inbox/controllers/chat_inbox_controller.dart';
import 'package:pink_ad/app/modules/signup/controllers/signup_controller.dart';
import 'package:pink_ad/app/modules/signup/views/signup_view.dart';

import 'package:pink_ad/app/routes/app_pages.dart';
import 'package:pink_ad/utilities/colors/colors.dart';
import 'package:pink_ad/utilities/custom_widgets/area_dropdown_user_signup.dart';
import 'package:pink_ad/utilities/custom_widgets/custom_bottom_button.dart';
import 'package:pink_ad/utilities/custom_widgets/custom_button.dart';
import 'package:pink_ad/utilities/custom_widgets/custom_text_field.dart';
import 'package:pink_ad/utilities/custom_widgets/my_scafflod.dart';
import 'package:pink_ad/utilities/custom_widgets/text_utils.dart';

class ChatInboxView extends GetView {
  // final activePackagesController = Get.put(ActivePackagesController());
  SignupController signupController = SignupController();
  ChatInboxController chatInboxController = ChatInboxController();
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CustomBackground(
        header: Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 30.0.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("User Sign Up",
                  style: CustomTextView.getStyle(context,
                      colorLight: Colors.white, fontSize: 24.sp, fontFamily: "Radomir Tinkov - Gilroy-ExtraBold", fontWeight: FontWeight.w700)),
              SizedBox(
                height: 7.0.h,
              ),
              Text("Area wise business directory and FREE classified solution for small businesses.",
                  style: CustomTextView.getStyle(context, colorLight: Colors.white)),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 80.h,
              ),
              Container(
                height: Get.height * .58,
                width: Get.width * 1,
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          ShadowedTextField(
                            controller: chatInboxController.nameController.value,
                            hintText: 'Name',
                            iconName: "email_user",
                            keyboardType: TextInputType.text,
                          ),
                          ShadowedTextField(
                            controller: chatInboxController.phoneNoController.value,
                            hintText: 'Mobile Number',
                            iconName: "phone",
                            keyboardType: TextInputType.phone,
                          ),
                          ShadowedTextField(
                            // focusNode: emailFocus,
                            // onFieldSubmitted: (v) {
                            //   FocusScope.of(context)
                            //       .requestFocus(businessNameFocus);
                            // },
                            // onChanged: controller.username,
                            controller: chatInboxController.emailController.value,
                            hintText: 'Email Address',
                            iconName: "email",
                            keyboardType: TextInputType.emailAddress,
                          ),
                          Obx(
                            () => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () => chatInboxController.gerCities(),
                                  child: Container(
                                    height: 50.h,
                                    width: Get.width,
                                    margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                                    padding: EdgeInsets.only(left: 20.0.w, right: 20.w, top: 5.h, bottom: 5.h),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 0,
                                          blurRadius: 5,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: DropdownSearch<City>(
                                      popupProps: PopupPropsMultiSelection.menu(
                                        showSearchBox: true,
                                        showSelectedItems: false,
                                        searchFieldProps: TextFieldProps(
                                            decoration: InputDecoration(
                                          hintText: "Search",
                                          hintStyle: CustomTextView.getStyle(context, colorLight: textColor, fontSize: 15.sp),
                                        )),
                                      ),
                                      items: chatInboxController.citiesName.value,
                                      itemAsString: (City u) => u.name,
                                      enabled: chatInboxController.citiesName.value.length > 0 ? true : false,
                                      dropdownDecoratorProps: DropDownDecoratorProps(
                                        baseStyle: CustomTextView.getStyle(context, colorLight: textColor, fontSize: 15.sp),
                                        dropdownSearchDecoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Select you City",
                                          hintStyle: CustomTextView.getStyle(context, colorLight: textColor, fontSize: 15.sp),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        chatInboxController.selectedCity.value = value;
                                        chatInboxController.selectedarea.value = null;
                                        chatInboxController.areaName.value = [];
                                        chatInboxController.getAreas(value!.id);
                                      },
                                    ),
                                  ),
                                ),
                                AnimatedSwitcher(
                                  duration: Duration(milliseconds: 200),
                                  child: Container(
                                    key: ValueKey(chatInboxController.selectedCity.value),
                                    height: 50.h,
                                    width: Get.width,
                                    margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                                    padding: EdgeInsets.only(left: 20.0.w, right: 20.w, top: 5.h, bottom: 5.h),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 0,
                                          blurRadius: 5,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: DropdownSearch<City>(
                                      // popupProps:   PopupProps.menu(
                                      //     showSelectedItems: true, showSearchBox: true),
                                      popupProps: PopupPropsMultiSelection.menu(
                                        showSearchBox: true,
                                        showSelectedItems: false,
                                        searchFieldProps: TextFieldProps(
                                            decoration: InputDecoration(
                                          hintText: "Search",
                                          hintStyle: CustomTextView.getStyle(context, colorLight: textColor, fontSize: 15.sp),
                                        )),
                                      ),
                                      items: chatInboxController.areaName.value,
                                      itemAsString: (City u) => u.name,
                                      enabled: chatInboxController.areaName.value.length > 0 ? true : false,
                                      dropdownDecoratorProps: DropDownDecoratorProps(
                                        baseStyle: CustomTextView.getStyle(context, colorLight: textColor, fontSize: 15.sp),
                                        dropdownSearchDecoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Select you Area",
                                          hintStyle: CustomTextView.getStyle(context, colorLight: textColor, fontSize: 15.sp),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        chatInboxController.setAreaId(value!);
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Obx(
                            () => ShadowedTextField(
                              // focusNode: passwordFocus,
                              // onChanged: controller.password,
                              hintText: 'Password',
                              iconName: "password",
                              keyboardType: TextInputType.text,
                              controller: chatInboxController.passwordController.value,
                              obscureText: !chatInboxController.isPasswordVisible.value,
                              suffixIcon: IconButton(
                                onPressed: () => chatInboxController.isPasswordVisible.toggle(),
                                icon: chatInboxController.isPasswordVisible.value
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
                          // AreaDropDownUserSignup(),
                          SizedBox(height: 25.h),
                          Obx(
                            () => chatInboxController.isLoading.value
                                ? const CircularProgressIndicator(
                                    color: primary,
                                  )
                                : GlobalButton(
                                    title: "User Sign Up",
                                    onPressed: () {
                                      // controller.isFormValid() ? controller.registerUser : showSnackBarError("Error", "Fill all fields");
                                      chatInboxController.onSubmit();
                                      // chatInboxController.gerCities();
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
                                  Get.toNamed(Routes.USER_LOGIN);
                                  // Navigate to sign up screen
                                },
                                child: Text('Login',
                                    style: CustomTextView.getStyle(context,
                                        colorLight: secondary, fontWeight: FontWeight.w600, fontFamily: "Poppins-Medium")),
                              ),
                              SizedBox(
                                height: 27.h,
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
            buttonText: "AS SELLER",
            onTap: () {
              Get.toNamed(Routes.SIGNUP);
            },
          )),
      // if (controller.isLoading.value) MyProcessLoading()
    ]);

    // return CustomBgDashboard(
    //   child: SafeArea(
    //     child: Column(
    //       children: [
    //         UserAppBar(
    //           profileIconVisibility: true,
    //           backButton: false,
    //           title: "Chat Inbox",
    //           onMenuTap: () {
    //             print("object");
    //           },
    //           onProfileTap: () {
    //             print("object");
    //             Get.to(ProfileView());
    //           },
    //         ),
    //     Expanded(
    //       child: Container(
    //         child: Tawk(
    //           directChatLink: 'https://tawk.to/chat/641418b04247f20fefe66d35/1grn80sio',
    //           visitor: TawkVisitor(
    //             name: 'Ayoub AMINE',
    //             email: 'ayoubamine2a@gmail.com',
    //           ),
    //           onLoad: () {
    //             print('Hello Tawk!');
    //           },
    //           onLinkTap: (String url) {
    //             print(url);
    //           },
    //           placeholder: const Center(
    //             child: Text('Loading...'),
    //           ),
    //         ),
    //       ),
    //     ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
