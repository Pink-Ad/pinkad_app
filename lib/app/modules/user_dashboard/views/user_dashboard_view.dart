import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pink_ad/app/data/api_service.dart';
import 'package:pink_ad/app/modules/all_offers/controllers/all_offers_controller.dart';
import 'package:pink_ad/app/modules/all_shops/controllers/all_shops_controller.dart';
import 'package:pink_ad/app/modules/home/controllers/home_controller.dart';
import 'package:pink_ad/app/modules/home/views/home_view.dart';
import 'package:pink_ad/app/modules/profile/views/profile_view.dart';
import 'package:pink_ad/utilities/custom_widgets/custom_appbar_user.dart';
import 'package:pink_ad/utilities/custom_widgets/main_controlller.dart';
import 'package:pink_ad/utilities/custom_widgets/slider_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utilities/colors/colors.dart';
import '../../../../utilities/custom_widgets/text_utils.dart';
import '../../../../utilities/utils.dart';
import '../controllers/user_dashboard_controller.dart';

class UserDashboardView extends GetView<UserDashboardController> {
  final ScrollController _scrollController1 = ScrollController();
  final MainControllers mainControllers = MainControllers();
  final allShopsController = AllShopsController();
  final allOffersController = AllOffersController();
  final homeController = HomeController();
  final refreshController = RefreshController();

  UserDashboardView({Key? key}) : super(key: key);
  Widget buildPagination() {
    return Obx(
      () {
        if (controller.totalPages.value > 1) {
          int startPage = controller.currentPage - 0;
          int endPage = controller.currentPage + 0;

          // Ensure that the range of numbers stays within bounds
          if (startPage < 1) {
            endPage = endPage + (1 - startPage);
            startPage = 1;
          }
          if (endPage > controller.totalPages.value) {
            startPage = startPage - (endPage - controller.totalPages.value);
            endPage = controller.totalPages.value;
          }
          if (startPage < 1) startPage = 1; // Double check after adjustment

          // Generate the list of page buttons to display
          // List<Widget> pageButtons = List<Widget>.generate(
          //   (endPage - startPage) + 1,
          //   (index) => TextButton(
          //     onPressed: () {
          //       if (!controller.isLoading.value) {
          //         controller.loadPage(startPage + index);
          //       }
          //     },
          //     child: Text(
          //       '${startPage + index}',
          //       style: TextStyle(
          //         fontSize: 16.sp,
          //         color: controller.currentPage == startPage + index
          //             ? primary // Selected page
          //             : Colors.black,
          //         fontWeight: controller.currentPage == startPage + index
          //             ? FontWeight.bold // Selected page
          //             : FontWeight.normal,
          //       ),
          //     ),
          //   ),
          // );

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Left arrow
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: primary,
                    size: 20.sp,
                  ),
                  onPressed: controller.currentPage > 1
                      ? () {
                          if (!controller.isLoading.value) {
                            controller.loadPage(controller.currentPage - 1);
                          }
                        }
                      : null,
                ),
                // Page numbers
                //...pageButtons,
                // Right arrow
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: primary,
                    size: 20.sp,
                  ),
                  onPressed: controller.currentPage < controller.totalPages.value
                      ? () {
                          if (!controller.isLoading.value) {
                            controller.loadPage(controller.currentPage + 1);
                          }
                        }
                      : null,
                ),
              ],
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          UserAppBar(
            backButton: false,
            title: 'PinkAd',
            onMenuTap: () {
              print('object');
            },
            onProfileTap: () {
              print('object');
              Get.to(ProfileView());
            },
            // showFilter: true,
            profileIconVisibility: true,
          ),
          CenterButtons(
            allOffersController: allOffersController,
          ),
          Expanded(
            child: CustomScrollView(
              controller: _scrollController1,
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 180.h,
                    child: HomePageSlider(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 5.h,
                  ),
                ),
                GetBuilder<UserDashboardController>(
                  builder: (controller) {
                    print('GetBuilder rebuilt');
                    //List<dynamic> tOffer = controller.box.read('topOffer') ?? [];
                    if (controller.tOffer.isNotEmpty) {
                      return SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          //crossAxisSpacing: 2.0,
                          //mainAxisSpacing: 8.0,
                          childAspectRatio: 150.w / 230.h,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                left: 8.0,
                                right: 8.0,
                                bottom: 10,
                              ),
                              child: InkWell(
                                onTap: () {
                                  homeController.setLoading();
                                  allOffersController
                                      .getOfferDetail(
                                        controller.tOffer[index]['id'],
                                      )
                                      .then(
                                        (value) => homeController.setLoading(),
                                      );
                                },
                                child: Container(
                                  width: 217.w,
                                  height: 325.h,
                                  decoration: BoxDecoration(
                                    color: lightGray,
                                    borderRadius: BorderRadius.circular(
                                      8.0,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 250.w,
                                        height: 170.w,
                                        decoration: BoxDecoration(
                                          color: lightGray,
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(
                                              10.0,
                                            ),
                                            topLeft: Radius.circular(
                                              10.0,
                                            ),
                                          ),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              ApiService.imageBaseUrl + controller.tOffer[index]['banner'],
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          top: 5.0,
                                          left: 10.h,
                                          right: 10,
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              controller.tOffer[index]['title'],
                                              maxLines: 1,
                                              style: CustomTextView.getStyle(
                                                context,
                                                colorLight: Colors.black,
                                                fontSize: 13.sp,
                                                fontFamily: Utils.poppinsBold,
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    controller.tOffer[index]['shop']?['name'] ?? '',
                                                    overflow: TextOverflow.ellipsis,
                                                    style: CustomTextView.getStyle(
                                                      context,
                                                      colorLight: secondary,
                                                      fontSize: 12.sp,
                                                      fontFamily: Utils.poppinsMedium,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text.rich(
                                              TextSpan(
                                                text: _getTrimmedDescription(
                                                  context: context,
                                                  description: controller.tOffer[index]['description'],
                                                ),
                                                style: CustomTextView.getStyle(
                                                  context,
                                                  colorLight: textColor,
                                                  fontSize: 10.sp,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: ' See more...',
                                                    style: CustomTextView.getStyle(
                                                      context,
                                                      colorLight: textColor,
                                                      fontSize: 10.sp,
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(5.0),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(10.0),
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () async {
                                                            await launchUrl(
                                                              Uri.parse(
                                                                'whatsapp://send?phone=${controller.tOffer[index]['shop']?['seller']?['whatsapp']}',
                                                              ),
                                                            );
                                                          },
                                                          child: Text(
                                                            'Chat with seller',
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: CustomTextView.getStyle(
                                                              context,
                                                              colorLight: textColor,
                                                              fontSize: 11.sp,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 4.w,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      await launchUrl(
                                                        Uri.parse(
                                                          'whatsapp://send?phone=${controller.tOffer[index]['shop']?['seller']?['whatsapp']}',
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      height: 22.h,
                                                      width: 25.w,
                                                      decoration: BoxDecoration(
                                                        color: greenColor,
                                                        borderRadius: BorderRadius.circular(3.0),
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(3.0),
                                                        child: SvgPicture.asset(
                                                          'assets/svgIcons/whatsapp.svg',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          childCount: controller.tOffer.length,
                        ),
                      );
                    } else {
                      return SliverFillRemaining(
                        child: Center(child: Text('No offers available.')),
                      );
                    }
                  },
                ),
                // SliverToBoxAdapter(
                //   child: Center(
                //     child: buildPagination(),
                //     widthFactor: 5.w,
                //     heightFactor: 0.5.h,
                //   ),
                // ),
              ],
            ),
          ),
          Center(
            child: buildPagination(),
            widthFactor: 5.w,
            heightFactor: 0.7.h,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_scrollController1.hasClients) {
            _scrollController1.animateTo(
              0,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
        child: Icon(
          Icons.arrow_upward_rounded,
        ),
        backgroundColor: primary,
      ),
    );
  }
}

String _getTrimmedDescription({
  required BuildContext context,
  required String description,
  int maxDescriptionLength = 10,
}) {
  String trimmedDescription = description.length > maxDescriptionLength ? description.substring(0, maxDescriptionLength) + '...' : description;

  return trimmedDescription;
}
