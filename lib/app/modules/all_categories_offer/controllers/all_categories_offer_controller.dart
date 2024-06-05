import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pink_ad/app/data/api_service.dart';
import 'package:pink_ad/app/models/areas_model.dart';
import 'package:pink_ad/app/models/offer_list_model.dart';
import 'package:pink_ad/app/models/subcategory_model.dart';
import 'package:pink_ad/app/modules/all_categories_offer/views/all_categories_offer_view.dart';
import 'package:pink_ad/app/modules/home/controllers/home_controller.dart';
import 'package:pink_ad/app/modules/splash/controllers/splash_controller.dart';
import 'package:pink_ad/app/routes/app_pages.dart';
import 'package:pink_ad/utilities/functions/show_toast.dart';

class AllCategoryOffersController extends GetxController {
  final ApiService _apiService = ApiService(http.Client());
  var isLoading = false.obs;
  final box = GetStorage();
  List<Area> selectedAreas = [];
  GlobalKey filterKey = GlobalKey();
  final searchController = TextEditingController();
  late final Future<List<Area>> areaFuture;
  HomeController homeController = HomeController();

  List<dynamic> allOffers = [];
  List<dynamic> offers = [];
  List<SubCategory> selectedSubcats = [];

  late final Future<List<SubCategory>> subcatFuture;

  @override
  void onInit() {
    super.onInit();
    allOffers = box.read('categoryoffers') ?? [];
    offers = allOffers;
    areaFuture = Get.find<SplashController>().getAllAreas();
    subcatFuture = Get.find<SplashController>().getAllSubcategories();
  }

  Future<void> getCategoryOfferDetail(int id) async {
// isLoading.value = true;
    // homeController.setLoading();
    final response = await _apiService.getData('offer-detail/$id');
    Map data = {'offer_id': id.toString(), 'views': 1.toString()};
    await _apiService.postData('insights/update', data);
    final result = json.decode(response.body);
    // MapEntry<dynamic, dynamic> shopDetail = ShopDetail.fromJson(result);
    // var temp = ShopDetail.fromJson(result);
    Get.toNamed(
      Routes.ALL_OFFER_DETAILS,
      arguments: {
        'data': result,
        'seller': false,
      },
    );
    // isLoading.value = false
  }

  Future<void> searchCategoryOffers(String pattern) async {
    if (pattern.isEmpty) {
      offers = allOffers; // Reset to all offers if the search term is cleared
    } else {
      // Construct the request URL with the query parameter

      final url = Uri.parse('${ApiService.baseUrl}/offer-search?search_name=$pattern');
      try {
        final response = await http.get(url);

        if (response.statusCode == 200) {
          final List<dynamic> result = json.decode(response.body);
          // Assuming each item in result can be directly converted to an OfferList object
          offers = result.map((data) => OfferList.fromJson(data)).toList();
        } else {
          // Handle the case when the server does not respond successfully
          offers = [];
          showToast(message: 'Failed to fetch offers. Please try again.'); // Ensure you have a showToast or similar method to show errors
        }
      } catch (e) {
        offers = [];
        print('Error searching offers: $e');
        showToast(message: 'An error occurred while searching offers. Please check your network and try again.');
      }
    }
    update(); // Call update() to refresh the UI with the filtered offers
  }

  // Future<void> filterCategoryOffers(List<Area> areas) async {
  //   if (areas.isEmpty) {
  //     showToast(message: 'Please select an area filter');
  //     return;
  //   }
  //   searchController.clear();
  //   selectedAreas = areas;
  //   try {
  //     final areaFilter = selectedAreas.map((area) => 'area_id[]=${area.id}');
  //     final response = await _apiService.getData('category-offers-filter?${areaFilter.join("&")}');

  //     if (response.statusCode == 200) {
  //       final result = json.decode(response.body);
  //       categoryOffers = result['filtered_category_offers'].map((json) => CategoryOfferListModel.fromJson(json)).toList();
  //       update();
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  //   Get.back();
  // }

  Future<void> refreshCategoryOffers() async {
    isLoading(true);

    try {
      await Future.delayed(Duration(seconds: 2));
      await Get.find<SplashController>().getOffers();

      allOffers = box.read('offers') ?? [];
      offers = allOffers;

      update();
    } catch (e) {
      print('Failed to refresh offers: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchCategoryOffersByCategoryId(int categoryId) async {
    try {
      final response = await _apiService.getData('${Endpoints.allOffers}?category_id=$categoryId');
      if (response.statusCode == 200) {
        final List<dynamic> resultList = json.decode(response.body);
        offers.clear();
        for (var json in resultList) {
          offers.add(OfferList.fromJson(json));
        }
        update();
        Get.to(() => AllCategoriesOffersView()); // Navigate to AllOffersView after fetching
      } else {
        throw Exception('Failed to fetch offers for category ID $categoryId');
      }
    } catch (e) {
      print('Error fetching offers by category ID: $e');
    }
  }

  void showCategoryOfferFilterDialog(BuildContext context) {
    final renderBox = filterKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    Get.dialog(
      useSafeArea: false,
      barrierColor: Colors.transparent,
      SizedBox(
        width: 1.sw,
        height: 1.sh,
        child: Stack(
          children: [
            Positioned(
              left: offset.dx,
              width: size.width,
              top: offset.dy + size.height + 10,
              child: Material(
                // This should be an actual widget that represents your filter overlay
                color: Colors.white,
                child: Text('Filter options here'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
