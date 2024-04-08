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
import 'package:pink_ad/utilities/custom_widgets/loader.dart';
import 'package:pink_ad/utilities/custom_widgets/main_controlller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utilities/colors/colors.dart';
import '../../../../utilities/custom_widgets/custom_appbar_user.dart';
import '../../../../utilities/custom_widgets/slider_page.dart';
import '../../../../utilities/custom_widgets/text_utils.dart';
import '../../../../utilities/utils.dart';
import '../controllers/user_dashboard_controller.dart';

class UserDashboardView extends GetView {
  // final userDashboardController = Get.put(UserDashboardController());
  final MainControllers mainControllers = MainControllers();
  final allShopsController = AllShopsController();
  final allOffersController = AllOffersController();
  final homeController = HomeController();
  final refreshController = RefreshController();

  UserDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: UserAppBar(
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
            ),
            SliverToBoxAdapter(
              child: CenterButtons(
                allOffersController: allOffersController,
              ),
            ),
            SliverFillRemaining(
              child: Stack(
                children: [
                  GetBuilder(
                    init: UserDashboardController(),
                    builder: (controller) {
                      List<dynamic> tOffer = controller.box.read('topOffer') ?? [];
                      List<dynamic> fOffer = controller.box.read('fOffer') ?? [];
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
                              // 10.verticalSpace,
                              SizedBox(
                                height: 180.h,
                                child: const HomePageSlider(),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              fOffer.isNotEmpty
                                  ? GridView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 2.0,
                                        mainAxisSpacing: 8.0,
                                        childAspectRatio: 150.w / 215.h,
                                      ),
                                      itemCount: fOffer.length,
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
                                            homeController.setLoading();
                                            allOffersController
                                                .getOfferDetail(
                                                  fOffer[index]['id'],
                                                )
                                                .then(
                                                  (value) => homeController.setLoading(),
                                                );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              right: 10,
                                            ),
                                            child: Container(
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
                                                    width: 230.w,
                                                    height: 150.w,
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
                                                          ApiService.imageBaseUrl + fOffer[index]['banner'],
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
                                                          fOffer[index]['title'],
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
                                                                fOffer[index]['shop']?['name'] ?? '',
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
                                                              description: fOffer[index]['description'],
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
                                                        SizedBox(
                                                          height: 5.h,
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
                                                                            'whatsapp://send?phone=${fOffer[index]['shop']?['seller']?['whatsapp']}',
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
                                                                      'whatsapp://send?phone=${fOffer[index]['shop']?['seller']?['whatsapp']}',
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
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Obx(
                    () => homeController.isLoading.isTrue ? const MyLoading() : Container(),
                  ),
                ],
              ),
            ),
          ],
        ),
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
