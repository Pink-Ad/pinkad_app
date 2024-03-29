import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pink_ad/app/data/api_service.dart';
import 'package:pink_ad/app/modules/all_offers/controllers/all_offers_controller.dart';
import 'package:pink_ad/app/modules/all_offers/views/all_offers_view.dart';
import 'package:pink_ad/app/modules/all_shops/controllers/all_shops_controller.dart';
import 'package:pink_ad/app/modules/all_shops/views/all_shops_view.dart';
import 'package:pink_ad/app/modules/home/controllers/home_controller.dart';
import 'package:pink_ad/app/modules/profile/views/profile_view.dart';
import 'package:pink_ad/utilities/custom_widgets/loader.dart';
import 'package:pink_ad/utilities/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

// import 'package:share_plus/share_plus.dart';

import '../../../../utilities/colors/colors.dart';
import '../../../../utilities/custom_widgets/custom_appbar.dart';
import '../../../../utilities/custom_widgets/slider_page.dart';
import '../../../../utilities/custom_widgets/text_utils.dart';

class HomeView extends GetView<HomeController> {
  final allShopsController = AllShopsController();
  final allOffersController = AllOffersController();
  final refreshController = RefreshController();

  HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            child: Column(
              children: [
                MyAppBar(
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
                ),
                Expanded(
                  child: Stack(
                    children: [
                      GetBuilder(
                        init: HomeController(),
                        builder: (controller) {
                          List<dynamic> tOffer = controller.box.read('topOffer') ?? [];
                          return SmartRefresher(
                            controller: refreshController,
                            onRefresh: () async {
                              try {
                                await controller.refreshDashboard();
                                refreshController.refreshCompleted();
                              } catch (e) {
                                refreshController.refreshFailed();
                              }
                            },
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  10.verticalSpace,
                                  SizedBox(
                                    height: 180.h,
                                    child: const HomePageSlider(),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 65.h,
                                        decoration: BoxDecoration(
                                          color: Colors.white, // Adjust color as needed
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15.0),
                                            topRight: Radius.circular(15.0),
                                            bottomLeft: Radius.circular(15.0),
                                            bottomRight: Radius.circular(15.0),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                              offset: Offset(
                                                0,
                                                3,
                                              ),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        Get.to(AllShopsView());
                                                      },
                                                      icon: Icon(
                                                        Icons.store_mall_directory_outlined,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Seller',
                                                      style: CustomTextView.getStyle(
                                                        context,
                                                        fontSize: 12.sp,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                // Offers button
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        Get.to(AllOffersView());
                                                      },
                                                      icon: Icon(
                                                        Icons.travel_explore,
                                                        size: 22.h,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Offers',
                                                      style: CustomTextView.getStyle(
                                                        context,
                                                        fontSize: 12.sp,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        Get.to(AllShopsView());
                                                      },
                                                      icon: Icon(Icons.category),
                                                    ),
                                                    Text(
                                                      'Categories',
                                                      style: CustomTextView.getStyle(
                                                        context,
                                                        fontSize: 12.sp,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  tOffer.isNotEmpty
                                      ? GridView.builder(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 5.0,
                                            mainAxisSpacing: 12.0,
                                            childAspectRatio: 150.w / 230.h,
                                          ),
                                          itemCount: tOffer.length,
                                          padding: EdgeInsets.only(
                                            left: 10.0,
                                            //right: 20.0,
                                            bottom: 10,
                                          ),
                                          itemBuilder: (
                                            BuildContext context,
                                            int index,
                                          ) {
                                            return InkWell(
                                              onTap: () {
                                                controller.setLoading();
                                                allOffersController
                                                    .getOfferDetail(
                                                      tOffer[index]['id'],
                                                    )
                                                    .then(
                                                      (value) => controller.setLoading(),
                                                    );
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 10,
                                                ),
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
                                                              ApiService.imageBaseUrl + tOffer[index]['banner'],
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
                                                              tOffer[index]['title'],
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
                                                                    tOffer[index]['shop']?['name'] ?? '',
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
                                                                text: tOffer[index]['description']
                                                                        .split(
                                                                          ' ',
                                                                        )
                                                                        .take(2)
                                                                        .join(
                                                                          ' ',
                                                                        ) +
                                                                    ' ',
                                                                style: CustomTextView.getStyle(
                                                                  context,
                                                                  colorLight: textColor,
                                                                  fontSize: 12.sp,
                                                                ),
                                                                children: [
                                                                  TextSpan(
                                                                    text: 'See more...',
                                                                    style: CustomTextView.getStyle(
                                                                      context,
                                                                      colorLight: textColor,
                                                                      fontSize: 12.sp,
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
                                                                borderRadius: BorderRadius.circular(
                                                                  10.0,
                                                                ),
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
                                                                                'whatsapp://send?phone=${tOffer[index]['shop']?['seller']?['whatsapp']}',
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
                                                                          'whatsapp://send?phone=${tOffer[index]['shop']?['seller']?['whatsapp']}',
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
                                                                        padding: const EdgeInsets.all(
                                                                          3.0,
                                                                        ),
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
                                        )
                                      : const Center(
                                          child: Text('No Top offers available.'),
                                        ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      Obx(
                        () => controller.isLoading.isTrue ? const MyLoading() : Container(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
