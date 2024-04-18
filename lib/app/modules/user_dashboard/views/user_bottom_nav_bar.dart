import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pink_ad/app/modules/user_dashboard/views/user_dashboard_view.dart';
import 'package:pink_ad/utilities/functions/show_toast.dart';
import 'package:upgrader/upgrader.dart';

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
              ],
            ),
            // bottomNavigationBar: Container(
            //   height: 40.h,
            //   child: CircleNavBar(
            //     color: primary,
            //     activeIndex: 0,
            //     activeIcons: [
            //       Padding(
            //         padding: EdgeInsets.all(10.0),
            //         child: SvgPicture.asset('assets/svgIcons/home.svg'),
            //       ),
            //     ],
            //     inactiveIcons: [
            //       SvgPicture.asset('assets/svgIcons/home.svg'),
            //     ],
            //     height: 40.h,
            //     circleWidth: 40,
            //     circleColor: bottomActiveColor,
            //     onTap: (index) {
            //       if (index == 0) return;
            //       tabIndex = index;
            //       pageController.jumpToPage(tabIndex);
            //     },
            //   ),
            // ),
          ),
        ),
      );
    });
  }
}
