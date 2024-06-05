import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pink_ad/app/data/api_service.dart';
import 'package:pink_ad/app/modules/all_offers/controllers/all_offers_controller.dart';
import 'package:pink_ad/app/modules/all_shops/controllers/all_shops_controller.dart';
import 'package:pink_ad/app/modules/all_shops/views/all_shops_view.dart';
import 'package:pink_ad/app/modules/home/controllers/home_controller.dart';
import 'package:pink_ad/app/modules/profile/views/profile_view.dart';
import 'package:pink_ad/app/modules/splash/controllers/splash_controller.dart';
import 'package:pink_ad/app/routes/app_pages.dart';
import 'package:pink_ad/utilities/colors/colors.dart';
import 'package:pink_ad/utilities/custom_widgets/slider_page.dart';
import 'package:pink_ad/utilities/functions/loading_wrapper.dart';
import 'package:pink_ad/utilities/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utilities/custom_widgets/custom_appbar.dart';
import '../../../../utilities/custom_widgets/text_utils.dart';

class HomeView extends GetView<HomeController> {
  final allShopsController = AllShopsController();
  final allOffersController = AllOffersController();
  final refreshController = RefreshController();

  final box = GetStorage();

  HomeView({Key? key}) : super(key: key);
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
                    color: controller.currentPage > 1 ? primary : primary,
                    size: 20.sp,
                  ),
                  onPressed: () {
                    if (!controller.isLoading.value && controller.currentPage > 1) {
                      controller.loadPage(controller.currentPage - 1, scrollToTop: true);
                    }
                  },
                ),

                IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: primary,
                    size: 20.sp,
                  ),
                  onPressed: controller.currentPage < controller.totalPages.value
                      ? () {
                          if (!controller.isLoading.value) {
                            controller.loadPage(controller.currentPage + 1, scrollToTop: true);
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
    final userType = box.read('user_type');
    Get.put(HomeController());
    if (userType == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showMyDialog(context);
      });
    }

    return GetBuilder(
      init: HomeController(),
      builder: (controller) {
        // List<dynamic> tOffer = controller.box.read('topOffer') ?? [];
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: MyAppBar(
            backButton: false,
            title: 'PinkAd',
            onMenuTap: () => print('Menu tapped'),
            onProfileTap: () => Get.to(ProfileView()),
            showCenterButtons: true,
          ),
          body: Stack(
            children: [
              ListView(
                controller: controller.scrollController,
                children: [
                  //CenterButtons(allOffersController: allOffersController),
                  //60.verticalSpace,
                  SizedBox(
                    height: 180.h,
                    child: HomePageSlider(),
                  ),
                  //buildPagination(),
                  5.verticalSpace,
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 12.0,
                      childAspectRatio: 150.w / 230.h,
                    ),
                    itemCount: controller.tOffer.length,
                    padding: EdgeInsets.only(
                      left: 10.0,
                      //right: 20.0,
                      bottom: 10,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          controller.setLoading();
                          allOffersController
                              .getOfferDetail(
                                controller.tOffer[index]['id'],
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
                                          text: controller.tOffer[index]['description'].split(' ').take(2).join(' ') + ' ',
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
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () async {
                                                      final imageUrl = ApiService.imageBaseUrl + controller.tOffer[index]['banner'];
                                                      final text =
                                                          "${controller.tOffer[index]['title']} by ${controller.tOffer[index]['shop']?['name']} - ${controller.tOffer[index]['description']}";

                                                      // Assuming the phone number is stored in data['shop']['seller']['whatsapp']
                                                      final phone = controller.tOffer[index]['shop']?['seller']?['whatsapp'];

                                                      // Construct the message
                                                      final message = Uri.encodeFull('$text\nSee image here: $imageUrl');

                                                      // Construct the WhatsApp URL
                                                      if (phone != null) {
                                                        await launchUrl(
                                                          Uri.parse('whatsapp://send?phone=$phone&text=$message'),
                                                        );
                                                      }
                                                      // await launchUrl(
                                                      //   Uri.parse(
                                                      //     'whatsapp://send?phone=${controller.tOffer[index]['shop']?['seller']?['whatsapp']}',
                                                      //   ),
                                                      // );
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
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: 5.w,
                  height: 46.h,
                  color: Colors.white,
                  child: Center(child: buildPagination()),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (controller.scrollController.hasClients) {
                controller.scrollController.animateTo(
                  0,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
            child: Icon(Icons.arrow_upward_rounded),
            backgroundColor: primary,
          ),
        );
      },
    );
  }
}

class CenterButtons extends StatelessWidget {
  final AllOffersController allOffersController;

  const CenterButtons({
    Key? key,
    required this.allOffersController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 8.0, right: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
          //border: Border.all(color: primary, width: 1.5),
        ),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildButton(context, Icons.store_mall_directory_outlined, 'Sellers', () {
                Get.to(AllShopsView());
              }),
              _buildButton(context, Icons.search, 'Search', () {
                Get.toNamed(Routes.ALL_OFFERS);
                //Get.to(() => AllOffersView());
              }),
              _buildButton(context, Icons.category, 'Categories', () {
                Get.toNamed(Routes.CATEGORIES);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, IconData iconData, String label, VoidCallback onPressed) {
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Color.fromARGB(154, 0, 0, 0),
          padding: EdgeInsets.all(2),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: onPressed,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              iconData,
              size: 22.h,
              color: primary,
            ),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: primary,
                ),
                overflow: TextOverflow.ellipsis,
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

void _showMyDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true, // Allows the dialog to be dismissed by tapping outside the dialog
    builder: (BuildContext context) {
      return Material(
        color: Colors.black45,
        child: Center(
          child: Container(
            width: 0.85.sw,
            height: 0.21.sh,
            decoration: BoxDecoration(
              color: Get.theme.cardColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: kElevationToShadow[1],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // SvgPicture.asset("assets/svgIcons/dialog_icon.svg"),
                  // SizedBox(
                  //   height: 20.h,
                  // ),
                  Text(
                    'Use App',
                    style: CustomTextView.getStyle(
                      Get.context!,
                      colorLight: secondary,
                      fontSize: 20.sp,
                      fontFamily: Utils.poppinsBold,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  //   child: Text(
                  //     'Dialog Message',
                  //     textAlign: TextAlign.center,
                  //     style: CustomTextView.getStyle(Get.context!, colorLight: textColor, fontSize: 14.sp),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20.h,
                  // ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              loadingWrapper(
                                () => Get.find<SplashController>().guestLogin(),
                              );
                            },
                            child: Container(
                              height: 50.0.h,
                              decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  'As Guest',
                                  style: CustomTextView.getStyle(
                                    Get.context!,
                                    colorLight: Colors.white,
                                    fontSize: 16.sp,
                                    fontFamily: Utils.poppinsSemiBold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        10.horizontalSpace,
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              Get.toNamed(Routes.LOGIN);
                            },
                            child: Container(
                              height: 50.0.h,
                              decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  'As Seller',
                                  style: CustomTextView.getStyle(
                                    Get.context!,
                                    colorLight: Colors.white,
                                    fontSize: 16.sp,
                                    fontFamily: Utils.poppinsSemiBold,
                                  ),
                                ),
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
          ),
        ),
      );
    },
  );
}
