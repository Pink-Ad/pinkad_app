import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pink_ad/app/data/api_service.dart';
import 'package:pink_ad/app/models/cites_model.dart';

import '../../../../utilities/colors/colors.dart';
import '../../../../utilities/custom_widgets/text_utils.dart';
import '../../../../utilities/utils.dart';

class UserDashboardController extends GetxController {
  final box = GetStorage();
  RxList<City> shopName = <City>[].obs;
  Rxn<File> currentImageFile = Rxn<File>();
  final count = 0.obs;

  int currentPage = 1;
  int itemsPerPage = 30; // Number of items per page
  bool hasMore = true; // Flag to indicate if there are more items to load
  RxBool isLoading = false.obs;

  final tOffer = <dynamic>[].obs;
  final RxInt totalPages = 0.obs;
  ScrollController scrollController = ScrollController();

  Future<void> loadPage(
    int page, {
    bool scrollToTop = false,
  }) async {
    if (isLoading.value || page < 1) return; // Additional check to avoid loading when already loading

    isLoading.value = true;
    update();

    try {
      // Construct the URL for the requested page
      String url = 'https://pinkad.pk/portal/api/top-offer?page=$page';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        tOffer.value = result['data'];
        print('Updated tOffer: $tOffer'); // Replace with new data
        currentPage = page; // Update current page
 if (scrollToTop) {
          _scrollToTop(); // Call to scroll function
        }
        // Update total pages based on the response, if that info is available
        // For example:
        // totalPages.value = (result['total'] / itemsPerPage).ceil();
      } else {
        print('Failed to fetch data: Status Code ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching items: $e');
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> calculateTotalPages() async {
    try {
      // Make the API call to fetch the first page
      String url = 'https://pinkad.pk/portal/api/top-offer';
      final response = await http.get(Uri.parse(url));

      // Check for a successful response
      if (response.statusCode == 200) {
        final result = json.decode(response.body);

        // Read the total number of items and items per page from the response
        final totalItems = result['total'];
        final itemsPerPage = result['per_page'];

        // Calculate the total number of pages
        final totalPages = (totalItems / itemsPerPage).ceil(); // Use ceil to round up to the nearest whole number

        // Update the totalPages observable
        this.totalPages.value = totalPages;
      } else {
        print('Failed to fetch total pages: Status Code ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching total pages: $e');
    }
  }

    void _scrollToTop() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    calculateTotalPages(); // Fetch total pages from API
    loadPage(1); // Load initial page
  }

  Future<void> refreshDashboard() async {
    // Reset state and load initial data
    tOffer.clear();
    currentPage = 1;
    hasMore = true;
    loadMore();
  }

  Future<List<dynamic>> fetchNextItems() async {
    try {
      // Use the next_page_url if available
      String nextPageUrl = currentPage == 1
          ? 'https://pinkad.pk/portal/api/' + Endpoints.topOffers
          : box.read('next_page_url') ?? 'https://pinkad.pk/portal/api/' + Endpoints.topOffers + '?page=$currentPage&limit=$itemsPerPage';

      // Make the API call
      final response = await http.get(Uri.parse(nextPageUrl));

      // Check for a successful response
      if (response.statusCode == 200) {
        final result = json.decode(response.body);

        // Save the next page URL from the API response
        box.write('next_page_url', result['next_page_url']);

        // Determine if there are more items to load
        hasMore = result['next_page_url'] != null;

        return result['data'];
      }
    } catch (e) {
      // Handle errors, e.g., by showing a Snackbar message
      print('Error fetching items: $e');
      hasMore = false; // No more items to load in case of an error
    }
    // Return an empty list if there are no more items or in case of an error
    return [];
  }

  Future<void> loadMore() async {
    if (!hasMore || isLoading.isTrue) return; // Prevent multiple simultaneous loads

    isLoading.value = true;
    update(); // Notify listeners to update UI, showing loading indicator

    String nextPageUrl = currentPage == 1
        ? 'https://pinkad.pk/portal/api/top-offer'
        : box.read('next_page_url') ?? 'https://pinkad.pk/portal/api/top-offer?page=$currentPage';

    try {
      final response = await http.get(Uri.parse(nextPageUrl));
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        final List<dynamic> newData = result['data'];
        if (newData.isNotEmpty) {
          tOffer.value = newData;
          update();
          currentPage++; // Only increment the page if new data is added
          hasMore = result['next_page_url'] != null; // Determine if there are more items to load
          print('tOffer length after adding new data: ${tOffer.length}');
        } else {
          hasMore = false; // No more data available
        }
      } else {
        print('Failed to fetch data: Status Code ${response.statusCode}');
        hasMore = false; // Assume no more items to load on error
      }
    } catch (e) {
      print('Error fetching items: $e');
      hasMore = false; // Stop trying to load more if there's an exception
    } finally {
      print('isLoading: ${isLoading.value}');
      print('currentPage: $currentPage');
      print('hasMore: $hasMore');
      print('tOffer Length: ${tOffer.length}');

      isLoading.value = false;
      update(); // Notify listeners to update UI, hiding loading indicator
    }
  }

  void showCustomDialog() {
    AwesomeDialog(
      dialogType: DialogType.noHeader,
      context: Get.overlayContext!,
      animType: AnimType.scale,
      btnOkColor: secondary,
      btnCancelColor: bodyTextColor,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Share',
              style: CustomTextView.getStyle(Get.context!, colorLight: secondary, fontSize: 24.sp, fontFamily: Utils.poppinsSemiBold),
            ),
            Text(
              'Share this link via',
              style: CustomTextView.getStyle(
                Get.context!,
                colorLight: textColor,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.snackbar(snackPosition: SnackPosition.BOTTOM, 'Instagram', 'Click');
                  },
                  child: Container(
                    height: 40.h,
                    width: 45.w,
                    decoration: BoxDecoration(
                      color: socialMediabg,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.facebook,
                        size: 30.sp,
                        // "assets/svgIcons/facebook.svg",
                        color: const Color(0xFF4B69B1),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                GestureDetector(
                  onTap: () {
                    Get.snackbar(snackPosition: SnackPosition.BOTTOM, 'Instagram', 'Click');
                  },
                  child: Container(
                    height: 40.h,
                    width: 45.w,
                    decoration: BoxDecoration(
                      color: socialMediabg,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/svgIcons/insta.svg',
                        height: 20.h,
                        color: const Color(0xFFE32C48),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                GestureDetector(
                  onTap: () {
                    Get.snackbar(snackPosition: SnackPosition.BOTTOM, 'Instagram', 'Click');
                  },
                  child: Container(
                    height: 40.h,
                    width: 45.w,
                    decoration: BoxDecoration(
                      color: socialMediabg,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/svgIcons/whatsapp.svg',
                        height: 20.h,
                        color: const Color(0xFF29A835),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Or copy link',
              style: CustomTextView.getStyle(
                Get.context!,
                colorLight: textColor,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 50.0.h,
              decoration: BoxDecoration(
                color: lightGray,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      width: 320.w,
                      margin: EdgeInsets.only(left: 10.0.w, right: 10.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset('assets/svgIcons/share_icon.svg'),
                          SizedBox(
                            width: 3.h,
                          ),
                          Container(
                            width: 150.w,
                            child: Text(
                              'example.com/share',
                              style: CustomTextView.getStyle(
                                Get.context!,
                                colorLight: textColor,
                                fontSize: 12.sp,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        Clipboard.setData(const ClipboardData(text: ''));
                      },
                      child: Container(
                        height: Get.height,
                        width: 60.w,
                        decoration: BoxDecoration(
                          color: secondary,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'Copy',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h),
          ],
        ),
      ),
    ).show();
  }
}
