import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pink_ad/app/modules/all_shops/views/all_shops_view.dart';
import 'package:pink_ad/app/modules/tutorial/views/tutorial_view.dart';
import 'package:pink_ad/app/modules/user_dashboard/views/user_dashboard_view.dart';
import 'package:pink_ad/utilities/colors/colors.dart';
import 'package:pink_ad/utilities/custom_widgets/filter_dialog.dart';
import 'package:pink_ad/utilities/functions/show_toast.dart';

import '../../../../utilities/custom_widgets/text_utils.dart';
import '../../all_offers/views/all_offers_view.dart';

class UserBottomNavBar extends StatefulWidget {
  const UserBottomNavBar({super.key});

  @override
  _UserBottomNavBarState createState() => _UserBottomNavBarState();
}

class _UserBottomNavBarState extends State<UserBottomNavBar> {
  static const popDuration = Duration(seconds: 2);
  DateTime? currentBackPressTime;
  final canPop = false.obs;
  final box = GetStorage();

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
    box.listenKey('user_categories', (val) {
      if (mounted) {
        setState(() {});
      }
    });
    box.listenKey('user_areas', (val) {
      if (mounted) {
        setState(() {});
      }
    });
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
      showToast(message: 'Press BACK again to Exit').then((value) => canPop.value = false);
      canPop.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final userCategory = box.read('user_categories');
      final userArea = box.read('user_areas');
      return PopScope(
        canPop: canPop.value,
        onPopInvoked: onPopInvoked,
        child: Stack(
          children: [
            Scaffold(
              resizeToAvoidBottomInset: false,
              // extendBody: true,
              bottomNavigationBar: Container(
                color: primary,
                child: SafeArea(
                  top: false,
                  child: Container(
                    color: Colors.white,
                    child: Stack(
                      children: [
                        CircleNavBar(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          activeIcons: [
                            const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Icon(
                                Icons.video_collection_outlined,
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
                                  Icons.watch_later_outlined,
                                  color: Colors.white,
                                  size: 22.h,
                                ),
                                // SvgPicture.asset("assets/svgIcons/offers.svg"),
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
                          color: secondary,
                          height: 60.h,
                          iconCurve: Curves.bounceInOut,
                          circleWidth: 60,
                          circleColor: bottomActiveColor,
                          activeIndex: tabIndex,
                          // elevation: 0,
                          onTap: (index) {
                            if (index == 0) return;
                            tabIndex = index;
                            pageController.jumpToPage(tabIndex);
                          },
                          // shadowColor: Colors.deepPurple,
                          shadowColor: Colors.white,

                          // cornerRadius: const BorderRadius.only(
                          //     topRight: Radius.circular(30.0), topLeft: Radius.circular(30.0)),
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
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (v) {
                  tabIndex = v;
                },
                children: [
                  // UploadOfferView(),
                  Center(child: Text('COMING SOON')),
                  AllOffersView(),
                  UserDashboardView(),
                  const AllShopsView(),
                  TutorialView(),
                ],
              ),
            ),
            if (userCategory == null || userArea == null)
              Center(
                child: FilterDialog(),
              ),
          ],
        ),
      );
    });
  }
}
