import 'dart:io';

import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pink_ad/app/modules/all_shops/views/all_shops_view.dart';
import 'package:pink_ad/app/modules/home/views/home_view.dart';
import 'package:pink_ad/app/modules/tutorial/views/tutorial_view.dart';
import 'package:pink_ad/utilities/colors/colors.dart';
import 'package:pink_ad/utilities/custom_widgets/auth_dialog.dart';
import 'package:pink_ad/utilities/functions/show_toast.dart';
import 'package:upgrader/upgrader.dart';

import '../../all_offers/views/all_offers_view.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  static const popDuration = Duration(seconds: 2);
  final box = GetStorage();
  DateTime? currentBackPressTime;
  final canPop = false.obs;
  int _tabIndex = 2;
  int get tabIndex => _tabIndex;
  set tabIndex(int v) {
    _tabIndex = v;
    setState(() {});
  }

  late PageController pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: _tabIndex);

    super.initState();
  }

  Future<void> onPopInvoked(bool popped) async {
    if (popped) return;
    // If current state can be popped without closing the app then do nothing
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
      final userType = box.read('user_type');
      return UpgradeAlert(
        dialogStyle: Platform.isIOS ? UpgradeDialogStyle.cupertino : UpgradeDialogStyle.material,
        child: PopScope(
          canPop: canPop.value,
          onPopInvoked: onPopInvoked,
          child: Stack(
            children: [
              Scaffold(
                resizeToAvoidBottomInset: false,
                bottomNavigationBar: Container(
                  height: 40.h,
                  color: primary,
                  child: SafeArea(
                    top: false,
                    child: Container(
                      color: Colors.white,
                      child: Stack(
                        children: [
                          CircleNavBar(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            shadowColor: primary,
                            elevation: 0,
                            circleShadowColor: Get.theme.colorScheme.background,
                            activeIcons: [
                              SizedBox.shrink(), // Dummy
                              SizedBox.shrink(), // Dummy
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SvgPicture.asset('assets/svgIcons/home.svg'),
                              ),
                              SizedBox.shrink(), // Dummy
                              SizedBox.shrink(), // Dummy
                            ],
                            inactiveIcons: [
                              SizedBox.shrink(), // Dummy
                              SizedBox.shrink(), // Dummy
                              SvgPicture.asset('assets/svgIcons/home.svg'),
                              SizedBox.shrink(), // Dummy
                              SizedBox.shrink(), // Dummy
                            ],
                            color: primary,
                            height: 40.h,
                            circleWidth: 40,
                            circleColor: bottomActiveColor,
                            activeIndex: tabIndex,
                            onTap: (index) {
                              // Only react to the tap if it's the home icon
                              if (index == 2) {
                                tabIndex = index;
                                pageController.jumpToPage(tabIndex);
                              }
                            },
                          ),
                          SizedBox(
                            height: 60.h,
                            child: Row(
                              children: [
                                Container(
                                  color: primary,
                                  width: 8,
                                ),
                                Spacer(),
                                Container(
                                  color: primary,
                                  width: 8,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                body: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  onPageChanged: (v) {
                    tabIndex = v;
                  },
                  children: [
                    Center(
                      child: Text('COMING SOON'),
                    ),
                    AllOffersView(),
                    HomeView(),
                    const AllShopsView(),
                    TutorialView(),
                  ],
                ),
              ),
              if (userType == null)
                Center(
                  child: AuthDialog(),
                ),
            ],
          ),
        ),
      );
    });
  }
}
