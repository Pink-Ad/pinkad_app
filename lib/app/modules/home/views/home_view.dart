import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pink_ad/app/data/api_service.dart';
import 'package:pink_ad/app/modules/all_offers/controllers/all_offers_controller.dart';
import 'package:pink_ad/app/modules/all_offers/views/all_offers_view.dart';
import 'package:pink_ad/app/modules/all_shops/controllers/all_shops_controller.dart';
import 'package:pink_ad/app/modules/all_shops/views/all_shops_view.dart';
import 'package:pink_ad/app/modules/home/controllers/home_controller.dart';
import 'package:pink_ad/app/modules/profile/views/profile_view.dart';
import 'package:pink_ad/app/routes/app_pages.dart';
import 'package:pink_ad/utilities/colors/colors.dart';
import 'package:pink_ad/utilities/custom_widgets/slider_page.dart';
import 'package:pink_ad/utilities/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utilities/custom_widgets/custom_appbar.dart';
import '../../../../utilities/custom_widgets/text_utils.dart';

class HomeView extends GetView<HomeController> {
  final allShopsController = AllShopsController();
  final allOffersController = AllOffersController();

  final refreshController = RefreshController();

  HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
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
          CenterButtons(
            allOffersController: allOffersController,
          ),
          Expanded(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 180.h,
                    child: const HomePageSlider(),
                  ),
                ),
                GetBuilder<HomeController>(
                  builder: (controller) {
                    List<dynamic> fOffer = controller.box.read('fOffer') ?? [];
                    if (fOffer.isNotEmpty) {
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
                                  controller.setLoading();
                                  allOffersController
                                      .getOfferDetail(
                                        fOffer[index]['id'],
                                      )
                                      .then(
                                        (value) => controller.setLoading(),
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
                                      //  FutureBuilder<MemoryImage?>(
                                      //               future:
                                      //                   getCompressedImage(ApiService.imageBaseUrl + fOffer[index]['banner'], fOffer[index]['title']),
                                      //               builder: (context, snapshot) {
                                      //                 if (snapshot.connectionState == ConnectionState.waiting) {
                                      //                   return Container(
                                      //                     width: 230.w,
                                      //                     height: 150.w,
                                      //                     decoration: BoxDecoration(
                                      //                       color: Colors.grey.shade300, // placeholder color
                                      //                       borderRadius: BorderRadius.only(
                                      //                         topRight: Radius.circular(10.0),
                                      //                         topLeft: Radius.circular(10.0),
                                      //                       ),
                                      //                     ),
                                      //                   );
                                      //                 }
                                      //                 if (snapshot.hasData) {
                                      //                   return Container(
                                      //                     width: 230.w,
                                      //                     height: 150.w,
                                      //                     decoration: BoxDecoration(
                                      //                       borderRadius: BorderRadius.only(
                                      //                         topRight: Radius.circular(10.0),
                                      //                         topLeft: Radius.circular(10.0),
                                      //                       ),
                                      //                       image: DecorationImage(
                                      //                         image: snapshot.data!,
                                      //                         fit: BoxFit.cover,
                                      //                       ),
                                      //                     ),
                                      //                   );
                                      //                 }
                                      //                 return Container(); // handle no data or error state
                                      //               },
                                      //             ),
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
                          childCount: fOffer.length,
                        ),
                      );
                    } else {
                      return SliverFillRemaining(
                        child: Center(child: Text('No offers available.')),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
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

  Future<MemoryImage?> getCompressedImage(String imageUrl) async {
    try {
      final Uri uri = Uri.parse(imageUrl);
      final http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        print('Original size: ${response.contentLength} bytes');
        // Attempt to compress the image
        try {
          final Uint8List? compressedImage = await FlutterImageCompress.compressWithList(
            response.bodyBytes,
            minHeight: 150, // set the desired height
            minWidth: 230, // set the desired width
            quality: 70, // set the compression quality
          );
          if (compressedImage != null) {
            print('Compressed size: ${compressedImage.length} bytes');
            return MemoryImage(compressedImage);
          }
        } catch (compressError) {
          print('Error compressing image: $compressError');
          // If compression fails, fall back to the original image
        }
        // Return the original image if compression didn't work or wasn't possible
        return MemoryImage(response.bodyBytes);
      }
    } catch (e) {
      print('Error fetching image: $e');
    }
    return null;
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
              _buildButton(context, Icons.travel_explore, 'Offers', () async {
                await allOffersController.refreshOffers();
                Get.to(() => AllOffersView());
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
