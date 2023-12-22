import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pink_ad/app/data/api_service.dart';
import 'package:pink_ad/app/modules/terms/views/terms_view.dart';
import 'package:pink_ad/app/modules/user_dashboard/controllers/user_dashboard_controller.dart';
import 'package:pink_ad/utilities/colors/colors.dart';
import 'package:pink_ad/utilities/custom_widgets/text_utils.dart';
import 'package:pink_ad/utilities/utils.dart';

import '../../app/modules/feedback/views/feedback_view.dart';
import '../../app/modules/user_profile/views/user_profile_view.dart';
import '../../app/routes/app_pages.dart';

class UserAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onMenuTap;
  final VoidCallback onProfileTap;
  final int size;
  final bool backButton;
  final bool profileIconVisibility;
  final bool showBanner;
  const UserAppBar(
      {Key? key,
      required this.title,
      this.size = 20,
      required this.onMenuTap,
      required this.onProfileTap,
      required this.backButton,
      required this.profileIconVisibility,
      this.showBanner = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomPopupMenuController controller = CustomPopupMenuController();
    UserDashboardController userDashboardController = UserDashboardController();
    var isExpanded = false.obs;
    final box = GetStorage();
    List<dynamic> sellerShop = box.read('sellerShop') ?? [];
    print(inspect(sellerShop));
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: backButton,
        backgroundColor: Colors.transparent,
        actions: [
          // showBanner
          //     ? CustomPopupMenu(
          //         arrowColor: Colors.white,
          //         horizontalMargin: 15.w,
          //         menuBuilder: () => ClipRRect(
          //           borderRadius: BorderRadius.circular(5),
          //           child: Container(
          //             color: Colors.white,
          //             child: IntrinsicWidth(
          //               child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.stretch,
          //                   children: [
          //                     GestureDetector(
          //                       onTap: () {
          //                         // Get.toNamed(Routes.SHOPS_INSIGHT);
          //                         // controller.hideMenu();
          //                       },
          //                       child: Container(
          //                         padding: const EdgeInsets.only(
          //                             left: 16, top: 15, right: 10, bottom: 15),
          //                         child: Row(children: [
          //                           // SvgPicture.asset("assets/svgIcons/dashboard.svg"),
          //                           // SizedBox(
          //                           //   width: 13.w,
          //                           // ),
          //                           Text('Congratulations 🎉',
          //                               style: CustomTextView.getStyle(
          //                                 context,
          //                                 colorLight: Colors.black,
          //                                 fontSize: 15.sp,
          //                               )),
          //                         ]),
          //                       ),
          //                     ),
          //                     const Divider(
          //                       color: lightGrayCircle,
          //                       thickness: 1,
          //                       height: 0,
          //                     ),
          //                     GestureDetector(
          //                       onTap: () {
          //                         Get.toNamed(Routes.PREMIER_FEATURES);
          //                         controller.hideMenu();
          //                       },
          //                       child: Container(
          //                         padding: const EdgeInsets.only(
          //                             left: 16, top: 15, right: 10, bottom: 15),
          //                         child: Row(children: [
          //                           SvgPicture.asset(
          //                             "assets/svgIcons/banner.svg",
          //                             color: secondary,
          //                           ),
          //                           SizedBox(
          //                             width: 13.w,
          //                           ),
          //                           Text('Add Banner',
          //                               style: CustomTextView.getStyle(
          //                                 context,
          //                                 colorLight: Colors.black,
          //                                 fontSize: 15.sp,
          //                               )),
          //                         ]),
          //                       ),
          //                     ),
          //                     const SizedBox(
          //                       height: 5,
          //                     ),
          //                   ]),
          //             ),
          //           ),
          //         ),
          //         pressType: PressType.singleClick,
          //         verticalMargin: -10,
          //         // controller: controller,
          //         child: Container(
          //           padding: EdgeInsets.only(right: 10.w, left: 10.w),
          //           child: const Icon(
          //             Icons.stars,
          //             color: Colors.amber,
          //             size: 25,
          //           ),
          //         ),
          //       )
          //     : SizedBox(),

          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(
          //     Icons.star_border,
          //     color: Colors.amber,
          //     size: 25,
          //   ),
          // ),
          if (profileIconVisibility)
            IconButton(
              icon: ConstrainedBox(
                constraints:
                    BoxConstraints.tight(const Size(double.infinity, 256)),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    Positioned(
                      top: 7.0,
                      child:
                          SvgPicture.asset("assets/svgIcons/profile_icon.svg"),
                    ),
                    const Positioned(
                      top: 21,
                      right: 20,
                      child:
                          CircleAvatar(radius: 5, backgroundColor: activeColor),
                    ),
                  ],
                ),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => UserProfileView()));
                // Get.to(UserProfileView());
              },
            ),
          CustomPopupMenu(
            arrowColor: Colors.white,
            horizontalMargin: 15.w,
            menuBuilder: () => ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                color: Colors.white,
                child: IntrinsicWidth(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // GestureDetector(
                        //   onTap: () {
                        //     isExpanded.toggle();
                        //   },
                        //   child: Container(
                        //     padding: EdgeInsets.only(
                        //         left: 16.w,
                        //         top: 13.h,
                        //         right: 10.w,
                        //         bottom: 13.h),
                        //     child: Row(
                        //         // mainAxisAlignment:
                        //         // MainAxisAlignment.spaceEvenly,
                        //         // crossAxisAlignment: CrossAxisAlignment.center,
                        //         children: [
                        //           SvgPicture.asset(
                        //             "assets/svgIcons/change_profile.svg",
                        //             width: 13.w,
                        //             height: 13.h,
                        //           ),
                        //           SizedBox(
                        //             width: 17.w,
                        //           ),
                        //           Center(
                        //             child: Text('Switch Branch',
                        //                 style: CustomTextView.getStyle(
                        //                   context,
                        //                   colorLight: Colors.black,
                        //                   fontSize: 15.sp,
                        //                 )),
                        //           ),
                        //           // Obx(
                        //           //   () => Icon(
                        //           //     isExpanded.value
                        //           //         ? Icons.arrow_drop_up_sharp
                        //           //         : Icons.arrow_drop_down_sharp,
                        //           //     color: Colors.black,
                        //           //   ),
                        //           // )
                        //         ]),
                        //   ),
                        // ),
                        // const Divider(
                        //   color: lightGrayCircle,
                        //   thickness: 1,
                        //   height: 0,
                        // ),
                        // Obx(
                        //   () => isExpanded.value && sellerShop.length > 0
                        //       ? Container(
                        //           color: Colors.white,
                        //           height: 80.h,
                        //           width: 100.w,
                        //           // padding: EdgeInsets.symmetric(
                        //           //     horizontal: 15, vertical: 10.h),
                        //           // child: Row(children: [
                        //           //   Container(
                        //           //     width: 20.0.w,
                        //           //     height: 20.0.h,
                        //           //     decoration: BoxDecoration(
                        //           //       shape: BoxShape.circle,
                        //           //       border: Border.all(
                        //           //         color: secondary,
                        //           //       ),
                        //           //     ),
                        //           //     child: const CircleAvatar(
                        //           //       radius: 18.0,
                        //           //       backgroundImage: AssetImage(
                        //           //           'assets/images/profile.png'),
                        //           //     ),
                        //           //   ),
                        //           //   SizedBox(
                        //           //     width: 10.w,
                        //           //   ),
                        //           //   Text('John Doe',
                        //           //       style: CustomTextView.getStyle(
                        //           //         context,
                        //           //         colorLight: Colors.black,
                        //           //         fontSize: 15.sp,
                        //           //       )),
                        //           // ]),
                        //           child: ListView.builder(
                        //             shrinkWrap: true,
                        //             itemCount: sellerShop.length,
                        //             itemBuilder:
                        //                 (BuildContext context, int index) {
                        //               return GestureDetector(
                        //                 onTap: () async {
                        //                   await box.write('selectedShop',
                        //                       sellerShop[index]['id']);
                        //                   controller.hideMenu();
                        //                   Get.snackbar("Switch Branch",
                        //                       sellerShop[index]['branch_name'],
                        //                       colorText: Colors.white,
                        //                       backgroundColor: primary,
                        //                       snackPosition: SnackPosition.TOP);
                        //                 },
                        //                 child: Container(
                        //                   alignment: Alignment.topLeft,
                        //                   padding: EdgeInsets.symmetric(
                        //                       horizontal: 10.w, vertical: 5.h),
                        //                   child: Column(
                        //                     children: [
                        //                       Text(
                        //                           sellerShop[index]
                        //                                   ['branch_name'] ??
                        //                               '',
                        //                           style:
                        //                               CustomTextView.getStyle(
                        //                             context,
                        //                             colorLight: Colors.black,
                        //                             fontSize: 15.sp,
                        //                           )),
                        //                       // SizedBox(height: 5.h),
                        //                       // const Divider(
                        //                       //   color: lightGrayCircle,
                        //                       //   thickness: 1,
                        //                       //   height: 0,
                        //                       // ),
                        //                     ],
                        //                   ),
                        //                 ),
                        //               );
                        //             },
                        //           ),
                        //         )
                        //       : const SizedBox(),
                        // ),

                        // Obx(
                        //   () => isExpanded.value
                        //       ? GestureDetector(
                        //           onTap: () {
                        //             Get.snackbar("Account", "John Smith",
                        //                 colorText: Colors.white,
                        //                 backgroundColor: primary,
                        //                 snackPosition: SnackPosition.TOP);
                        //             controller.hideMenu();
                        //           },
                        //           child: Container(
                        //             color: dropdownBg,
                        //             padding: EdgeInsets.symmetric(
                        //                 horizontal: 15, vertical: 10.h),
                        //             child: Row(children: [
                        //               Container(
                        //                 width: 20.0.w,
                        //                 height: 20.0.h,
                        //                 decoration: BoxDecoration(
                        //                   shape: BoxShape.circle,
                        //                   border: Border.all(
                        //                     color: containerGray,
                        //                   ),
                        //                 ),
                        //                 child: const CircleAvatar(
                        //                   radius: 18.0,
                        //                   backgroundImage: AssetImage(
                        //                       'assets/images/profile.png'),
                        //                 ),
                        //               ),
                        //               SizedBox(
                        //                 width: 10.w,
                        //               ),
                        //               Text('John Smith',
                        //                   style: CustomTextView.getStyle(
                        //                     context,
                        //                     colorLight: Colors.black,
                        //                     fontSize: 15.sp,
                        //                   )),
                        //             ]),
                        //           ),
                        //         )
                        //       : const SizedBox(),
                        // ),

                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.SHOPS_INSIGHT);
                            controller.hideMenu();
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 16, top: 15, right: 10, bottom: 15),
                            child: Row(children: [
                              SvgPicture.asset(
                                "assets/svgIcons/dashboard.svg",
                                width: 13.w,
                                height: 13.h,
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Text('Dashboard',
                                  style: CustomTextView.getStyle(
                                    context,
                                    colorLight: Colors.black,
                                    fontSize: 15.sp,
                                  )),
                            ]),
                          ),
                        ),
                        const Divider(
                          color: lightGrayCircle,
                          thickness: 1,
                          height: 0,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const TermsView());
                            // Get.toNamed(Routes.TERMS);
                            controller.hideMenu();
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 16, top: 15, right: 10, bottom: 15),
                            child: Row(children: [
                              const Icon(Icons.feed_outlined, color: secondary),
                              SizedBox(
                                width: 16.w,
                              ),
                              Text('Terms & Conditions',
                                  style: CustomTextView.getStyle(
                                    context,
                                    colorLight: Colors.black,
                                    fontSize: 15.sp,
                                  )),
                            ]),
                          ),
                        ),
                        const Divider(
                          color: lightGrayCircle,
                          thickness: 1,
                          height: 0,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => FeedbackView());
                            // Get.toNamed(Routes.TERMS);
                            controller.hideMenu();
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 16, top: 15, right: 10, bottom: 15),
                            child: Row(children: [
                              const Icon(Icons.reviews_outlined,
                                  color: secondary),
                              SizedBox(
                                width: 17.w,
                              ),
                              Text('Feedback',
                                  style: CustomTextView.getStyle(
                                    context,
                                    colorLight: Colors.black,
                                    fontSize: 15.sp,
                                  )),
                            ]),
                          ),
                        ),
                        // const Divider(
                        //   color: lightGrayCircle,
                        //   thickness: 1,
                        //   height: 0,
                        // ),
                        // GestureDetector(
                        //   onTap: () {
                        //     // Get.to(() => const TermsView());
                        //     // Get.toNamed(Routes.TERMS);
                        //     controller.hideMenu();
                        //   },
                        //   child: Container(
                        //     padding: const EdgeInsets.only(
                        //         left: 16, top: 15, right: 10, bottom: 15),
                        //     child: Row(children: [
                        //       const Icon(Icons.delete_outline,
                        //           color: secondary),
                        //       SizedBox(
                        //         width: 16.w,
                        //       ),
                        //       Text('Delete Data',
                        //           style: CustomTextView.getStyle(
                        //             context,
                        //             colorLight: Colors.black,
                        //             fontSize: 15.sp,
                        //           )),
                        //     ]),
                        //   ),
                        // ),
                        const Divider(
                          color: lightGrayCircle,
                          thickness: 1,
                          height: 0,
                        ),
                        GestureDetector(
                          onTap: () async {
                            showAwesomeDialog();
                            // Get.toNamed(Routes.FEEDBACK);
                            controller.hideMenu();
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 16, top: 10, right: 10, bottom: 10),
                            child: Row(children: [
                              const Icon(Icons.delete_outline_outlined,
                                  color: secondary),
                              SizedBox(
                                width: 15.w,
                              ),
                              Text('Delete Account',
                                  style: CustomTextView.getStyle(
                                    context,
                                    colorLight: Colors.black,
                                    fontSize: 15.sp,
                                  )),
                            ]),
                          ),
                        ),
                        const Divider(
                          color: lightGrayCircle,
                          thickness: 1,
                          height: 0,
                        ),
                        GestureDetector(
                          onTap: () {
                            box.remove('user_token');
                            box.remove('email');
                            box.remove('password');
                            Get.offAllNamed('/bottom-nav-bar');

                            controller.hideMenu();
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 16, top: 15, right: 10, bottom: 15),
                            child: Row(children: [
                              SvgPicture.asset("assets/svgIcons/logout.svg"),
                              SizedBox(
                                width: 20.w,
                              ),
                              Text('Logout',
                                  style: CustomTextView.getStyle(
                                    context,
                                    colorLight: Colors.black,
                                    fontSize: 15.sp,
                                  )),
                            ]),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ]),
                ),
              ),
            ),
            pressType: PressType.singleClick,
            verticalMargin: -10,
            controller: controller,
            child: Container(
              padding: EdgeInsets.only(right: 20.w, left: 20.w),
              child: SvgPicture.asset("assets/svgIcons/dots.svg"),
            ),
          ),
        ],
        centerTitle: true,
        title: Image.asset(
          'assets/images/title.png',
          width: 150.w,
          height: 90.h,
          fit: BoxFit.contain,
        ),
        // title: Text(
        //   title,
        //   style: CustomTextView.getStyle(context,
        //       colorLight: Colors.white,
        //       fontSize: size.sp,
        //       fontFamily: "Radomir Tinkov - Gilroy-ExtraBold",
        //       fontWeight: FontWeight.w600),
        // ),
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
            style: CustomTextView.getStyle(Get.context!,
                colorLight: secondary,
                fontSize: 20.sp,
                fontFamily: Utils.poppinsBold),
          ),
          SizedBox(
            height: 15.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'You want to delete your account?',
              textAlign: TextAlign.center,
              style: CustomTextView.getStyle(Get.context!,
                  colorLight: textColor, fontSize: 14.sp),
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
              style: CustomTextView.getStyle(Get.context!,
                  colorLight: Colors.white,
                  fontSize: 16.sp,
                  fontFamily: Utils.poppinsMedium),
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
              style: CustomTextView.getStyle(Get.context!,
                  colorLight: Colors.white,
                  fontSize: 16.sp,
                  fontFamily: Utils.poppinsMedium),
            ),
          ),
        ),
      ),
    ).show();
  }

  Future<void> uploadOffers() async {
    final box = GetStorage();

    final data = await box.read('user_token');
    final ApiService apiService = ApiService(http.Client());
    try {
      final response =
          await apiService.getDataWithHeader(Endpoints.deleteUser, data);

      if (response.statusCode == 200) {
        box.remove('user_token');
        box.remove('email');
        box.remove('password');
        Get.offNamed('/bottom-nav-bar');
      }
    } catch (e) {
      // isLoading.value = false;
      print(e);
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
