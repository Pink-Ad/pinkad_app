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

import '../../../../utilities/custom_widgets/text_utils.dart';
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
      showToast(message: 'Press BACK again to Exit').future.then((value) => canPop.value = false);
      canPop.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final token = box.read('user_token');
      final userType = box.read('user_type');
      return PopScope(
        canPop: canPop.value,
        onPopInvoked: onPopInvoked,
        child: Stack(
          children: [
            Scaffold(
              resizeToAvoidBottomInset: false,
              extendBody: true,
              bottomNavigationBar: SafeArea(
                bottom: true,
                child: Stack(
                  children: [
                    CircleNavBar(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      shadowColor: primary,
                      elevation: 0,
                      circleShadowColor: Get.theme.colorScheme.background,
                      activeIcons: [
                        const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Icon(
                            Icons.video_collection_outlined,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Icon(
                            Icons.travel_explore,
                            color: Colors.white,
                            size: 22.h,
                          ),
                          // child: SvgPicture.asset(
                          //   "assets/svgIcons/activated.svg",
                          //   height: 10,
                          //   width: 10,
                          // )
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SvgPicture.asset('assets/svgIcons/home.svg'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Icon(
                            Icons.store_mall_directory_outlined,
                            color: Colors.white,
                            size: 22.h,
                          ),
                          // child: SvgPicture.asset(
                          //   "assets/svgIcons/offers.svg",
                          //   height: 10,
                          //   width: 10,
                          // )
                        ),
                        const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Icon(
                            Icons.video_collection_outlined,
                            color: Colors.white,
                          ),
                          // child: SvgPicture.asset("assets/svgIcons/activated.svg")
                        ),
                      ],
                      inactiveIcons: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.video_collection_outlined,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            FittedBox(
                              child: Text(
                                'Upcoming',
                                style: CustomTextView.getStyle(
                                  context,
                                  colorLight: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.travel_explore,
                              color: Colors.white,
                              size: 22.h,
                            ),
                            // SvgPicture.asset("assets/svgIcons/offers.svg"),
                            SizedBox(height: 5.h),
                            Text(
                              'Offers',
                              style: CustomTextView.getStyle(
                                context,
                                fontSize: 12.sp,
                                colorLight: Colors.white,
                              ),
                            ),
                          ],
                        ),
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.store_mall_directory_outlined,
                              color: Colors.white,
                              size: 22.h,
                            ),
                            // SvgPicture.asset("assets/svgIcons/activated.svg"),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              'Sellers',
                              style: CustomTextView.getStyle(
                                context,
                                fontSize: 12.sp,
                                colorLight: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.library_books,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              'Tutorial',
                              style: CustomTextView.getStyle(
                                context,
                                fontSize: 12.sp,
                                colorLight: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                      color: primary,
                      height: 60.h,
                      circleWidth: 60,
                      circleColor: bottomActiveColor,
                      activeIndex: tabIndex,
                      // elevation: 10,
                      onTap: (index) {
                        if (index == 0) return;
                        tabIndex = index;
                        pageController.jumpToPage(tabIndex);
                      },
                      // shadowColor: Colors.deepPurple,
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
      );
    });
  }
}
