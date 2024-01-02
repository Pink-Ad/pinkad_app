import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pink_ad/app/data/api_service.dart';
import 'package:pink_ad/app/modules/splash/controllers/splash_controller.dart';
import 'package:pink_ad/app/routes/app_pages.dart';

class AllShopsController extends GetxController {
  //TODO: Implement AllShopsController
  List shopList = [].obs;
  final ApiService _apiService = ApiService(http.Client());
  final box = GetStorage();
  List<dynamic> shops = [];

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    shops = box.read('allSeller') ?? [];
  }

  Future<void> refreshShops() async {
    await Get.find<SplashController>().getAllSeller();
    shops = box.read('allSeller') ?? [];
    update();
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

  void increment() => count.value++;
}
