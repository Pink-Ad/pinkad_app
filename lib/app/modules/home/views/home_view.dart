import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pink_ad/app/data/api_service.dart';
import 'package:pink_ad/app/modules/all_offers/controllers/all_offers_controller.dart';
import 'package:pink_ad/app/modules/all_shops/controllers/all_shops_controller.dart';
import 'package:pink_ad/app/modules/home/controllers/home_controller.dart';
import 'package:pink_ad/app/modules/profile/views/profile_view.dart';
import 'package:pink_ad/utilities/custom_widgets/loader.dart';
import 'package:pink_ad/utilities/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

// import 'package:share_plus/share_plus.dart';

import '../../../../utilities/colors/colors.dart';
import '../../../../utilities/custom_widgets/custom_appbar.dart';
import '../../../../utilities/custom_widgets/slider_page.dart';
import '../../../../utilities/custom_widgets/text_utils.dart';
import '../../../routes/app_pages.dart';

class HomeView extends GetView<HomeController> {
  final box = GetStorage();
  final allShopsController = AllShopsController();
  final allOffersController = AllOffersController();
  final refreshController = RefreshController();

  HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('assets/images/bg_homecopy.png'),
        //     fit: BoxFit.cover,
        //   ),
        // ),
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
            ),
            Expanded(
              child: Stack(
                children: [
                  GetBuilder(
                    init: HomeController(),
                    builder: (controller) {
                      List<dynamic> fSeller = box.read('fseller') ?? [];
                      List<dynamic> tSeller = box.read('topSeller') ?? [];
                      List<dynamic> fOffer = box.read('fOffer') ?? [];
                      List<dynamic> tOffer = box.read('topOffer') ?? [];
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
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.0.w,
                                  vertical: 10.w,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Featured Seller',
                                      style: CustomTextView.getStyle(
                                        context,
                                        colorLight: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: Utils.poppinsSemiBold,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                          Routes.FEATURED_SELLER,
                                          arguments: {
                                            'seller': Endpoints.featureSeller,
                                            'sellerData': fSeller,
                                          },
                                        );
                                      },
                                      child: Text(
                                        'See All',
                                        style: CustomTextView.getStyle(
                                          context,
                                          colorLight: Colors.black,
                                          fontFamily: Utils.gilroyLight,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 110.h,
                                child: fSeller.isNotEmpty
                                    ? ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: fSeller.length,
                                        itemBuilder: (
                                          BuildContext context,
                                          int index,
                                        ) {
                                          return GestureDetector(
                                            onTap: () {
                                              controller.setLoading();
                                              allShopsController
                                                  .getShopDetail(
                                                    fSeller[index]['shop'][0]
                                                        ['id'],
                                                  )
                                                  .then(
                                                    (value) =>
                                                        controller.setLoading(),
                                                  );
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 20.0,
                                                bottom: 10,
                                              ),
                                              child: Container(
                                                width: 120.w,
                                                height: 120.h,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    8.0,
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(
                                                        0.9,
                                                      ),
                                                      spreadRadius: 1,
                                                      blurRadius: 1,
                                                      offset: const Offset(
                                                        0,
                                                        2,
                                                      ),
                                                    ),
                                                  ],
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      ApiService.imageBaseUrl +
                                                          fSeller[index]
                                                              ['logo'],
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    : const Center(
                                        child: Text(
                                          'No featured sellers available.',
                                        ),
                                      ),
                              ),
                              SizedBox(
                                height: 10.w,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.0.w,
                                  vertical: 10.w,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Featured Offer',
                                      style: CustomTextView.getStyle(
                                        context,
                                        colorLight: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: Utils.gilroyLight,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                          Routes.FEATURED_OFFER,
                                          arguments: {
                                            'seller': Endpoints.featuredOffers,
                                            'sellerData': fOffer,
                                          },
                                        );
                                      },
                                      child: Text(
                                        'See All',
                                        style: CustomTextView.getStyle(
                                          context,
                                          colorLight: Colors.black,
                                          fontFamily: Utils.gilroyLight,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 330.h,
                                child: fOffer.isNotEmpty
                                    ? ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: fOffer.length,
                                        itemBuilder: (
                                          BuildContext context,
                                          int index,
                                        ) {
                                          return InkWell(
                                            onTap: () {
                                              controller.setLoading();
                                              allOffersController
                                                  .getOfferDetail(
                                                    fOffer[index]['id'],
                                                  )
                                                  .then(
                                                    (value) =>
                                                        controller.setLoading(),
                                                  );
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 20.0,
                                                bottom: 10,
                                              ),
                                              child: Container(
                                                width: 217.w,
                                                height: 325.h,
                                                decoration: BoxDecoration(
                                                  color: lightGray,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    8.0,
                                                  ),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 220.w,
                                                      height: 210.h,
                                                      decoration: BoxDecoration(
                                                        color: lightGray,
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          topRight:
                                                              Radius.circular(
                                                            10.0,
                                                          ),
                                                          topLeft:
                                                              Radius.circular(
                                                            10.0,
                                                          ),
                                                        ),
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                            ApiService
                                                                    .imageBaseUrl +
                                                                fOffer[index]
                                                                    ['banner'],
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
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            fOffer[index]
                                                                ['title'],
                                                            style:
                                                                CustomTextView
                                                                    .getStyle(
                                                              context,
                                                              colorLight:
                                                                  Colors.black,
                                                              fontSize: 16.sp,
                                                              fontFamily: Utils
                                                                  .poppinsBold,
                                                            ),
                                                          ),
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  fOffer[index][
                                                                              'shop']
                                                                          [
                                                                          'name'] ??
                                                                      '',
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: CustomTextView
                                                                      .getStyle(
                                                                    context,
                                                                    colorLight:
                                                                        secondary,
                                                                    fontSize:
                                                                        14.sp,
                                                                    fontFamily:
                                                                        Utils
                                                                            .poppinsMedium,
                                                                  ),
                                                                ),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      final sellerUrl =
                                                                          fOffer[index]['shop']['seller']
                                                                              [
                                                                              'seller_link'];
                                                                      Share
                                                                          .share(
                                                                        "${fOffer[index]['title']}"
                                                                        "\n\n${fOffer[index]['description']} by ${fOffer[index]['shop']['name'] ?? ''}"
                                                                        '\n\n$sellerUrl'
                                                                        '\n\n$appUrl',
                                                                      );

                                                                      // Share
                                                                      //     .share(
                                                                      //   "${fOffer[index]['title']}, ${fOffer[index]['description']},${fOffer[index]['shop']['name'] ?? ''},contact ${fOffer[index]['shop']['seller']['faecbook_page']}. $appUrl",
                                                                      // );
                                                                      // controller
                                                                      //     .showCustomDialog(
                                                                      //         fOffer[index]);
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          25.h,
                                                                      width:
                                                                          30.w,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color:
                                                                            secondary,
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                          5.0,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .share,
                                                                        color: Colors
                                                                            .white,
                                                                        size:
                                                                            20,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10.w,
                                                                  ),
                                                                  GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      // final appInstalled =
                                                                      //     await canLaunchUrl(
                                                                      //         Uri.parse(
                                                                      //             'whatsapp://'));
                                                                      // if (appInstalled) {
                                                                      await launchUrl(
                                                                        Uri.parse(
                                                                          // 'whatsapp://send?text=${fOffer[index]['title']}, ${fOffer[index]['description']},${fOffer[index]['shop']['name']},contact ${fOffer[index]['shop']['seller']['phone']}. $appUrl'));
                                                                          'whatsapp://send?phone=${fOffer[index]['shop']['seller']['whatsapp']}',
                                                                        ),
                                                                      );
                                                                      // } else {
                                                                      //   await launchUrl(Uri.parse(
                                                                      //       'https://api.whatsapp.com/send?phone=03001234567'));
                                                                      // }
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          25.h,
                                                                      width:
                                                                          30.w,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color:
                                                                            greenColor,
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                          5.0,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(
                                                                          5.0,
                                                                        ),
                                                                        child: SvgPicture
                                                                            .asset(
                                                                          'assets/svgIcons/whatsapp.svg',
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          Text(
                                                            fOffer[index]
                                                                ['description'],
                                                            // 'Lorem ipsum dolor sit amet,\nconsect adipiscin askdjsaldja akdjasl',
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                CustomTextView
                                                                    .getStyle(
                                                              context,
                                                              colorLight:
                                                                  textColor,
                                                              fontSize: 13.sp,
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
                                        child: Text(
                                          'No featured offers available.',
                                        ),
                                      ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              // SizedBox(height: 130.h, child: HomePageSlider()),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.0.w,
                                  vertical: 10.w,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Top Seller',
                                      style: CustomTextView.getStyle(
                                        context,
                                        colorLight: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: Utils.poppinsSemiBold,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                          Routes.FEATURED_SELLER,
                                          arguments: {
                                            'seller': Endpoints.topSeller,
                                            'sellerData': tSeller,
                                          },
                                        );
                                        // Get.toNamed(Routes.ALL_SHOPS);
                                      },
                                      child: Text(
                                        'See All',
                                        style: CustomTextView.getStyle(
                                          context,
                                          colorLight: Colors.black,
                                          fontFamily: Utils.gilroyLight,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 110.h,
                                child: tSeller.isNotEmpty
                                    ? ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: tSeller.length,
                                        itemBuilder: (
                                          BuildContext context,
                                          int index,
                                        ) {
                                          return InkWell(
                                            onTap: () {
                                              controller.setLoading();
                                              allShopsController
                                                  .getShopDetail(
                                                    tSeller[index]['shop'][0]
                                                        ['id'],
                                                  )
                                                  .then(
                                                    (value) =>
                                                        controller.setLoading(),
                                                  );
                                              // Get.toNamed(Routes.SHOP_DETAILS);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 20.0,
                                                bottom: 10,
                                              ),
                                              child: Container(
                                                width: 118.w,
                                                height: 100.h,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    8.0,
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(
                                                        0.9,
                                                      ),
                                                      spreadRadius: 1,
                                                      blurRadius: 1,
                                                      offset: const Offset(
                                                        0,
                                                        2,
                                                      ),
                                                    ),
                                                  ],
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      tSeller[index]['logo'] !=
                                                              null
                                                          ? ApiService
                                                                  .imageBaseUrl +
                                                              tSeller[index]
                                                                  ['logo']
                                                          : 'https://www.pulsecarshalton.co.uk/wp-content/uploads/2016/08/jk-placeholder-image.jpg',
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    : const Center(
                                        child: Text(
                                          'No top sellers available.',
                                        ),
                                      ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.0.w,
                                  vertical: 10.w,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Top Offer',
                                      style: CustomTextView.getStyle(
                                        context,
                                        colorLight: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: Utils.gilroyLight,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                          Routes.FEATURED_OFFER,
                                          arguments: {
                                            'seller': Endpoints.topOffers,
                                            'sellerData': tOffer,
                                          },
                                        );
                                      },
                                      child: Text(
                                        'See All',
                                        style: CustomTextView.getStyle(
                                          context,
                                          colorLight: Colors.black,
                                          fontFamily: Utils.gilroyLight,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 330.h,
                                child: tOffer.isNotEmpty
                                    ? ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: tOffer.length,
                                        padding: EdgeInsets.only(
                                          left: 20.0,
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
                                                    (value) =>
                                                        controller.setLoading(),
                                                  );
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                right: 20.0,
                                              ),
                                              child: Container(
                                                width: 217.w,
                                                height: 325.h,
                                                decoration: BoxDecoration(
                                                  color: lightGray,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    8.0,
                                                  ),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 220.w,
                                                      height: 210.h,
                                                      decoration: BoxDecoration(
                                                        color: lightGray,
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          topRight:
                                                              Radius.circular(
                                                            10.0,
                                                          ),
                                                          topLeft:
                                                              Radius.circular(
                                                            10.0,
                                                          ),
                                                        ),
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                            ApiService
                                                                    .imageBaseUrl +
                                                                tOffer[index]
                                                                    ['banner'],
                                                          ),
                                                          fit: BoxFit.fill,
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
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            tOffer[index]
                                                                ['title'],
                                                            style:
                                                                CustomTextView
                                                                    .getStyle(
                                                              context,
                                                              colorLight:
                                                                  Colors.black,
                                                              fontSize: 16.sp,
                                                              fontFamily: Utils
                                                                  .poppinsBold,
                                                            ),
                                                          ),
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  tOffer[index][
                                                                              'shop']
                                                                          [
                                                                          'name'] ??
                                                                      '',
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: CustomTextView
                                                                      .getStyle(
                                                                    context,
                                                                    colorLight:
                                                                        secondary,
                                                                    fontSize:
                                                                        14.sp,
                                                                    fontFamily:
                                                                        Utils
                                                                            .poppinsMedium,
                                                                  ),
                                                                ),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      final sellerUrl =
                                                                          tOffer[index]['shop']['seller']
                                                                              [
                                                                              'seller_link'];
                                                                      Share
                                                                          .share(
                                                                        "${tOffer[index]['title']}"
                                                                        "\n\n${tOffer[index]['description']} by ${tOffer[index]['shop']['name'] ?? ''}"
                                                                        '\n\n$sellerUrl'
                                                                        '\n\n$appUrl',
                                                                      );
                                                                      // Share
                                                                      //     .share(
                                                                      //   "${tOffer[index]['title']}, ${tOffer[index]['description']},${tOffer[index]['shop']['name'] ?? ''},contact ${tOffer[index]['shop']['seller']['faecbook_page']}. $appUrl",
                                                                      // );
                                                                      // controller
                                                                      //     .showCustomDialog(
                                                                      //         tOffer[index]);
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          25.h,
                                                                      width:
                                                                          30.w,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color:
                                                                            secondary,
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                          5.0,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          const Icon(
                                                                        Icons
                                                                            .share,
                                                                        color: Colors
                                                                            .white,
                                                                        size:
                                                                            20,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10.w,
                                                                  ),
                                                                  GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      // final appInstalled =
                                                                      //     await canLaunchUrl(
                                                                      //         Uri.parse(
                                                                      //             'whatsapp://'));
                                                                      // if (appInstalled) {
                                                                      await launchUrl(
                                                                        Uri.parse(
                                                                          'whatsapp://send?phone=${tOffer[index]['shop']['seller']['whatsapp']}',
                                                                        ),
                                                                      );
                                                                      // 'whatsapp://send?text=${tOffer[index]['title']}, ${tOffer[index]['description']},${tOffer[index]['shop']['name']},contact ${tOffer[index]['shop']['seller']['phone']}. $appUrl'));
                                                                      // } else {
                                                                      //   await launchUrl(Uri.parse(
                                                                      //       'https://api.whatsapp.com/send?phone=03001234567'));
                                                                      // }
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          25.h,
                                                                      width:
                                                                          30.w,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color:
                                                                            greenColor,
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                          5.0,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(
                                                                          5.0,
                                                                        ),
                                                                        child: SvgPicture
                                                                            .asset(
                                                                          'assets/svgIcons/whatsapp.svg',
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          Text(
                                                            tOffer[index]
                                                                ['description'],
                                                            // 'Lorem ipsum dolor sit amet,\nconsect adipiscin askdjsaldja akdjasl',
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                CustomTextView
                                                                    .getStyle(
                                                              context,
                                                              colorLight:
                                                                  textColor,
                                                              fontSize: 13.sp,
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
                                        child: Text(
                                          'No top offers available.',
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Obx(
                    () => controller.isLoading.isTrue
                        ? const MyLoading()
                        : Container(),
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
