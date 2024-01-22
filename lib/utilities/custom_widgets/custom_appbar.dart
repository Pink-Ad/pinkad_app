import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pink_ad/app/data/api_service.dart';
import 'package:pink_ad/utilities/colors/colors.dart';
import 'package:pink_ad/utilities/custom_widgets/text_utils.dart';
import 'package:pink_ad/utilities/utils.dart';

import '../../app/routes/app_pages.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onMenuTap;
  final VoidCallback onProfileTap;
  final bool backButton;
  final bool showFilter;

  MyAppBar({
    Key? key,
    required this.title,
    required this.onMenuTap,
    required this.onProfileTap,
    required this.backButton,
    this.showFilter = false,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  final box = GetStorage();
  final CustomPopupMenuController controller = CustomPopupMenuController();

  @override
  Widget build(BuildContext context) {
    var data = box.read('customer_data');
    var userType = box.read('user_type');
    // print(data['status']);
    return AppBar(
      elevation: 0.0,
      automaticallyImplyLeading: widget.backButton,
      iconTheme: IconTheme.of(context).copyWith(color: Colors.white),
      backgroundColor: primary,
      scrolledUnderElevation: 0,
      actions: [
        if (widget.showFilter)
          IconButton(
            icon: Icon(Icons.filter_alt_outlined),
            onPressed: () {
              box.write('user_categories', null);
              box.write('user_areas', null);
            },
          ),
        // data != null
        //     ? data['status'] == 'success'
        //         ? IconButton(
        //             icon: ConstrainedBox(
        //               constraints: BoxConstraints.tight(
        //                 const Size(double.infinity, 256),
        //               ),
        //               child: Stack(
        //                 alignment: AlignmentDirectional.center,
        //                 children: <Widget>[
        //                   Positioned(
        //                     top: 7.0,
        //                     child: SvgPicture.asset(
        //                       'assets/svgIcons/profile_icon.svg',
        //                     ),
        //                   ),
        //                   const Positioned(
        //                     top: 21,
        //                     right: 20,
        //                     child: CircleAvatar(
        //                       radius: 5,
        //                       backgroundColor: activeColor,
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             onPressed: () {
        //               // Add your code here
        //               Get.to(() => ProfileView());
        //             },
        //           )
        //         : const SizedBox()
        //     : SizedBox(),
        CustomPopupMenu(
          arrowColor: Colors.white,
          horizontalMargin: 15.w,
          menuBuilder: () => ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              color: Colors.white,
              child: IntrinsicWidth(
                child: data != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.hideMenu();
                              Get.toNamed(Routes.FEEDBACK);
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                left: 16,
                                top: 10,
                                right: 10,
                                bottom: 10,
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.reviews_outlined,
                                    color: secondary,
                                  ),
                                  SizedBox(
                                    width: 17.w,
                                  ),
                                  Text(
                                    'Feedback',
                                    style: CustomTextView.getStyle(
                                      context,
                                      colorLight: Colors.black,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const PopupMenuDivider(),
                          GestureDetector(
                            onTap: () async {
                              controller.hideMenu();
                              showAwesomeDialog();
                              // Get.toNamed(Routes.FEEDBACK);
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                left: 16,
                                top: 10,
                                right: 10,
                                bottom: 10,
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.delete_outline_outlined,
                                    color: secondary,
                                  ),
                                  SizedBox(width: 15.w),
                                  Text(
                                    'Delete Account',
                                    style: CustomTextView.getStyle(
                                      context,
                                      colorLight: Colors.black,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const PopupMenuDivider(),
                          GestureDetector(
                            onTap: () {
                              controller.hideMenu();
                              box.write('customer_data', null);
                              box.remove('user_type');
                              Get.offAllNamed(Routes.Bottom_Nav_Bar);
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                left: 16,
                                top: 10,
                                right: 10,
                                bottom: 10,
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/svgIcons/logout.svg',
                                    width: 13.w,
                                    height: 13.h,
                                  ),
                                  SizedBox(width: 16.w),
                                  Text(
                                    'Logout',
                                    style: CustomTextView.getStyle(
                                      context,
                                      colorLight: Colors.black,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.hideMenu();
                              Get.toNamed(Routes.LOGIN);
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                left: 16,
                                top: 10,
                                right: 10,
                                bottom: 10,
                              ),
                              child: Row(
                                children: [
                                  // SvgPicture.asset(
                                  //   'assets/svgIcons/logout.svg',
                                  //   width: 13.w,
                                  //   height: 13.h,
                                  // ),
                                  const Icon(Icons.logout, color: secondary),
                                  SizedBox(width: 15.w),
                                  Text(
                                    'Login',
                                    style: CustomTextView.getStyle(
                                      context,
                                      colorLight: Colors.black,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const PopupMenuDivider(),
                          GestureDetector(
                            onTap: () {
                              controller.hideMenu();
                              Get.toNamed(Routes.SIGNUP);
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                left: 16,
                                top: 5,
                                right: 10,
                                bottom: 10,
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.person_add_alt_1_outlined,
                                    color: secondary,
                                  ),
                                  // SvgPicture.asset(
                                  //   "assets/svgIcons/logout.svg",
                                  //   width: 13.w,
                                  //   height: 13.h,
                                  // ),
                                  SizedBox(width: 15.w),
                                  Text(
                                    'Signup',
                                    style: CustomTextView.getStyle(
                                      context,
                                      colorLight: Colors.black,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const PopupMenuDivider(),
                          GestureDetector(
                            onTap: () {
                              controller.hideMenu();
                              Get.toNamed(Routes.FEEDBACK);
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                left: 16,
                                top: 10,
                                right: 10,
                                bottom: 10,
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.reviews_outlined,
                                    color: secondary,
                                  ),
                                  // SvgPicture.asset(
                                  //   "assets/svgIcons/dashboard.svg",
                                  //   width: 13.w,
                                  //   height: 13.h,
                                  // ),
                                  SizedBox(width: 15.w),
                                  Text(
                                    'Feedback',
                                    style: CustomTextView.getStyle(
                                      context,
                                      colorLight: Colors.black,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
          pressType: PressType.singleClick,
          verticalMargin: -10,
          controller: controller,
          child: Container(
            padding: EdgeInsets.only(right: 20.w, left: 20.w),
            child: SvgPicture.asset('assets/svgIcons/dots.svg'),
          ),
        ),
      ],
      centerTitle: true,
      title: Image.asset(
        'assets/images/title.png',
        width: 150.w,
        // height: 90.h,
        fit: BoxFit.contain,
      ),
    );
  }

  void showAwesomeDialog() {
    AwesomeDialog(
      dialogType: DialogType.noHeader,
      context: Get.overlayContext!,
      animType: AnimType.scale,
      btnOkColor: secondary,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      btnCancelColor: bodyTextColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Are you sure?',
            style: CustomTextView.getStyle(
              Get.context!,
              colorLight: secondary,
              fontSize: 20.sp,
              fontFamily: Utils.poppinsBold,
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'You want to delete your account?',
              textAlign: TextAlign.center,
              style: CustomTextView.getStyle(
                Get.context!,
                colorLight: textColor,
                fontSize: 14.sp,
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
      btnOk: GestureDetector(
        onTap: () {
          uploadOffers();
        },
        child: Container(
          width: 138.0.w,
          height: 50.0.h,
          decoration: BoxDecoration(
            color: secondary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              'Delete',
              style: CustomTextView.getStyle(
                Get.context!,
                colorLight: Colors.white,
                fontSize: 16.sp,
                fontFamily: Utils.poppinsMedium,
              ),
            ),
          ),
        ),
      ),
      btnCancel: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Container(
          width: 138.0.w,
          height: 50.0.h,
          decoration: BoxDecoration(
            color: bodyTextColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              'Cancel',
              style: CustomTextView.getStyle(
                Get.context!,
                colorLight: Colors.white,
                fontSize: 16.sp,
                fontFamily: Utils.poppinsMedium,
              ),
            ),
          ),
        ),
      ),
    ).show();
  }

  Future<void> uploadOffers() async {
    final data = await box.read('customer_data');
    final ApiService _apiService = ApiService(http.Client());
    try {
      final response = await _apiService.getDataWithHeader(
        Endpoints.deleteUser,
        data['authorisation']['token'],
      );

      if (response.statusCode == 200) {
        box.write('customer_data', null);
        Get.offAllNamed(Routes.Bottom_Nav_Bar);
      }
    } catch (e) {
      // isLoading.value = false;
      print(e);
    }
  }
}
