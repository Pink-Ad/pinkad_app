import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pink_ad/app/data/api_service.dart';
import 'package:pink_ad/app/models/areas_model.dart';
import 'package:pink_ad/app/modules/all_shops/views/shop_filter_button.dart';
import 'package:pink_ad/app/modules/splash/controllers/splash_controller.dart';
import 'package:pink_ad/app/routes/app_pages.dart';
import 'package:pink_ad/utilities/functions/show_toast.dart';

class AllShopsController extends GetxController {
  List shopList = [].obs;
  final ApiService _apiService = ApiService(http.Client());
  final box = GetStorage();
  List<dynamic> allShops = [];
  List<dynamic> shops = [];
  List<Area> selectedAreas = [];
  final filterKey = GlobalKey();
  final searchController = TextEditingController();
  late final Future<List<Area>> areaFuture;

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    allShops = box.read('allSeller') ?? [];
    shops = allShops;
    areaFuture = Get.find<SplashController>().getAllAreas();
  }

  Future<void> getShopDetail(int id) async {
    print(id);
    // isLoading.value = true;
    final response = await _apiService.getData('shop-detail/$id');
    final result = json.decode(response.body);
    print(result);
    // MapEntry<dynamic, dynamic> shopDetail = ShopDetail.fromJson(result);
    // var temp = ShopDetail.fromJson(result);
    Get.toNamed(
      Routes.SHOP_DETAILS,
      arguments: {
        'data': result,
        'seller': false,
      },
    );
    // isLoading.value = false;
  }

  void updateShops(List<dynamic> newShops) {
    allShops.addAll(newShops);
    shops = allShops;
    update(); // This will trigger the UI to rebuild
  }

  int currentPage = 1;
  Future<void> fetchShops() async {
    final response = await _apiService.getData('shops?page=$currentPage');
    final result = json.decode(response.body);
    print('Fetched ${result.length} shops'); // Debug print
    if (result.isNotEmpty) {
      updateShops(result);
      currentPage++;
    }
  }

  Future<void> searchShops(String query) async {
    if (query.isEmpty) {
      shops = allShops;
      update();
      return;
    }
    try {
      final response = await _apiService.getData('seller-search?search_name=$query');
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        shops = result['sellers'];
        update();
      }
    } catch (e) {
      print(e);
    }
  }

  List<dynamic> getSuggestions(String query) {
    print('getSuggestions called with query: $query');
    if (query.isEmpty) return [];
    return shops.where((shop) => shop['name'].toLowerCase().contains(query.toLowerCase())).toList();
  }

  Future<void> filterShops(List<Area> areas) async {
    if (areas.isEmpty) {
      showToast(message: 'Please select the filters');
      return;
    }
    searchController.clear();
    selectedAreas = areas;
    try {
      final areaFilter = areas.map((area) => 'area_id[]=${area.id}');
      final response = await _apiService.getData('${Endpoints.sellerFilter}?${areaFilter.join("&")}');

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        shops = result['sellers'];
        update();
      }
    } catch (e) {
      print(e);
    }
    Get.back();
  }

  Future<void> clearFilters() async {
    shops = allShops;
    selectedAreas = [];
    update();
  }

  Future<void> refreshShops() async {
    if (selectedAreas.isNotEmpty) {
      await filterShops(selectedAreas);
    } else {
      await Get.find<SplashController>().getAllSeller();
      allShops = box.read('allSeller') ?? [];
      shops = allShops;
      update();
    }
  }

  void showShopFilterDialog(BuildContext context) {
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
              child: ShopFilterOverlay(),
            ),
          ],
        ),
      ),
    );
  }
}
