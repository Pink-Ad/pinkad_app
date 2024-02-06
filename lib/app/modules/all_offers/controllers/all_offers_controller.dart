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
import 'package:pink_ad/app/modules/all_offers/views/offer_filter_button.dart';
import 'package:pink_ad/app/modules/home/controllers/home_controller.dart';
import 'package:pink_ad/app/modules/splash/controllers/splash_controller.dart';
import 'package:pink_ad/app/routes/app_pages.dart';
import 'package:pink_ad/utilities/functions/show_toast.dart';

class AllOffersController extends GetxController {
  //TODO: Implement AllOffersController
  final ApiService _apiService = ApiService(http.Client());
  HomeController homeController = HomeController();
  final box = GetStorage();
  List<dynamic> allOffers = [];
  List<dynamic> offers = [];
  List<SubCategory> selectedSubcats = [];
  List<Area> selectedAreas = [];
  GlobalKey filterKey = GlobalKey();
  final searchController = TextEditingController();
  late final Future<List<SubCategory>> subcatFuture;
  late final Future<List<Area>> areaFuture;

  @override
  void onInit() {
    super.onInit();
    allOffers = box.read('offers') ?? [];
    offers = allOffers;
    areaFuture = Get.find<SplashController>().getAllAreas();
    subcatFuture = Get.find<SplashController>().getAllSubcategories();
  }

  Future<void> getOfferDetail(int id) async {
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
    // isLoading.value = false;
  }

  Future<void> filterOffers(List<Area> areas, List<SubCategory> subcats) async {
    if (areas.isEmpty || subcats.isEmpty) {
      showToast(message: 'Please select the filters');
      return;
    }
    searchController.clear();
    selectedAreas = areas;
    selectedSubcats = subcats;
    try {
      final areaFilter = selectedAreas.map((area) => 'area_id[]=${area.id}');
      final subcatFilter = selectedSubcats.map((subcat) => 'category_id[]=${subcat.id}');
      final response = await _apiService.getData('${Endpoints.offerFilter}?${[...areaFilter, ...subcatFilter].join("&")}');

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        offers = result['filtered_banner_posts'].map((json) => OfferList.fromJson(json)).toList();
        update();
      }
    } catch (e) {
      print(e);
    }
    Get.back();
  }

  Future<void> clearFilters() async {
    offers = allOffers;
    selectedAreas = [];
    selectedSubcats = [];
    update();
  }

  Future<void> refreshOffers() async {
    if (selectedAreas.isNotEmpty && selectedSubcats.isNotEmpty) {
      await filterOffers(selectedAreas, selectedSubcats);
    } else {
      await Get.find<SplashController>().getOffers();
      allOffers = box.read('offers') ?? [];
      offers = allOffers;
      update();
    }
  }

  void showOfferFilterDialog(BuildContext context) {
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
              child: OfferFilterOverlay(),
            ),
          ],
        ),
      ),
    );
  }
}
