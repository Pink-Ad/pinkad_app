import 'dart:io';

import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pink_ad/app/modules/user_dashboard/views/user_dashboard_view.dart';
import 'package:pink_ad/utilities/colors/colors.dart';
import 'package:pink_ad/utilities/functions/show_toast.dart';
import 'package:upgrader/upgrader.dart';

import '../../../../utilities/custom_widgets/text_utils.dart';

class UserBottomNavBar extends StatefulWidget {
  const UserBottomNavBar({Key? key}) : super(key: key);

  @override
  _UserBottomNavBarState createState() => _UserBottomNavBarState();
}

class _UserBottomNavBarState extends State<UserBottomNavBar> {
  static const popDuration = Duration(seconds: 2);
  DateTime? currentBackPressTime;
  final canPop = false.obs;

  int _tabIndex = 0;
  int get tabIndex => _tabIndex;
  set tabIndex(int v) {
    _tabIndex = v;
    setState(() {});
  }

  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _tabIndex);
  }

  Future<void> onPopInvoked(bool popped) async {
    if (popped) return;
    if (Get.global(null).currentState?.canPop() ?? false) {
      if (await Get.global(null).currentState!.maybePop()) return;
    }
    final now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime!) > popDuration) {
      currentBackPressTime = now;
      showToast(message: 'Press BACK again to Exit').then((value) => canPop.value = false);
      canPop.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return UpgradeAlert(
        dialogStyle: Platform.isIOS ? UpgradeDialogStyle.cupertino : UpgradeDialogStyle.material,
        child: PopScope(
          canPop: canPop.value,
          onPopInvoked: onPopInvoked,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: PageView(
              controller: pageController,
              onPageChanged: (index) {
                tabIndex = index;
              },
              children: [
                UserDashboardView(),
                // AllShopsView(),
                // TutorialView(),
              ],
            ),
            bottomNavigationBar: CircleNavBar(
              color: primary,
              activeIndex: 0,
              activeIcons: [
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                ),
              ],
              inactiveIcons: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/svgIcons/home.svg'),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      'Home',
                      style: CustomTextView.getStyle(
                        context,
                        fontSize: 12.sp,
                        colorLight: Colors.white,
                      ),
                    ),
                  ],
                ),
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     SvgPicture.asset("assets/svgIcons/shop.svg"),
                //     SizedBox(
                //       height: 5.h,
                //     ),
                //     Text(
                //       'Shops',
                //       style: CustomTextView.getStyle(
                //         context,
                //         fontSize: 12.sp,
                //         colorLight: Colors.white,
                //       ),
                //     ),
                //   ],
                // ),
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     SvgPicture.asset("assets/svgIcons/tutorial.svg"),
                //     SizedBox(
                //       height: 5.h,
                //     ),
                //     Text(
                //       'Tutorial',
                //       style: CustomTextView.getStyle(
                //         context,
                //         fontSize: 12.sp,
                //         colorLight: Colors.white,
                //       ),
                //     ),
                //   ],
                // ),
              ],
              height: 60.h,
              circleWidth: 60,
              circleColor: bottomActiveColor,
              onTap: (index) {
                if (index == 0) return;
                tabIndex = index;
                pageController.jumpToPage(tabIndex);
              },
            ),
          ),
        ),
      );
    });
  }
}
