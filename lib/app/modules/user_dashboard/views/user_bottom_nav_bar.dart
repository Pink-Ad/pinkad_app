import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pink_ad/app/modules/all_shops/views/all_shops_view.dart';
import 'package:pink_ad/app/modules/tutorial/views/tutorial_view.dart';
import 'package:pink_ad/app/modules/user_dashboard/views/user_dashboard_view.dart';
import 'package:pink_ad/utilities/colors/colors.dart';
import 'package:pink_ad/utilities/functions/show_toast.dart';

import '../../../../utilities/custom_widgets/text_utils.dart';
import '../../all_offers/views/all_offers_view.dart';
import '../../upload_offer/views/upload_offer_view.dart';

class UserBottomNavBar extends StatefulWidget {
  const UserBottomNavBar({super.key});

  @override
  _UserBottomNavBarState createState() => _UserBottomNavBarState();
}

class _UserBottomNavBarState extends State<UserBottomNavBar> {
  static const popDuration = Duration(seconds: 2);
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
    super.initState();
    pageController = PageController(initialPage: _tabIndex);
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
      return PopScope(
        canPop: canPop.value,
        onPopInvoked: onPopInvoked,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          bottomNavigationBar: SafeArea(
            bottom: true,
            child: CircleNavBar(
              activeIcons: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Icon(
                    Icons.post_add_outlined,
                    color: Colors.white,
                  ),
                ),
                // Padding(
                //     padding: const EdgeInsets.all(15.0),
                //     child: SvgPicture.asset(
                //       "assets/svgIcons/offers.svg",
                //       height: 10,
                //       width: 10,
                //     )),
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Icon(
                    Icons.travel_explore,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SvgPicture.asset('assets/svgIcons/home.svg'),
                ),
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Icon(
                    Icons.store_mall_directory_outlined,
                    color: Colors.white,
                  ),
                ),
                // Padding(
                //     padding: const EdgeInsets.all(20.0),
                //     child: SvgPicture.asset("assets/svgIcons/premier.svg")),
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
                    Icon(
                      Icons.post_add_rounded,
                      color: Colors.white,
                      size: 22.h,
                    ),
                    // SvgPicture.asset("assets/svgIcons/offers.svg"),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      'Create',
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
                      Icons.travel_explore,
                      color: Colors.white,
                      size: 22.h,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
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
                    // SvgPicture.asset("assets/svgIcons/premier.svg"),
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
                      Icons.video_collection_outlined,
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
              iconCurve: Curves.bounceInOut,
              circleWidth: 60,
              circleColor: bottomActiveColor,
              activeIndex: tabIndex,
              elevation: 10,
              onTap: (index) {
                tabIndex = index;
                pageController.jumpToPage(tabIndex);
              },
              shadowColor: Colors.deepPurple,
              // cornerRadius: const BorderRadius.only(
              //     topRight: Radius.circular(30.0), topLeft: Radius.circular(30.0)),
            ),
          ),
          body: PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (v) {
              tabIndex = v;
            },
            children: [
              UploadOfferView(),
              AllOffersView(),
              UserDashboardView(),
              const AllShopsView(),
              TutorialView(),
            ],
          ),
        ),
      );
    });
  }
}
