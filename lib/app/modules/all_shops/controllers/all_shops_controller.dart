import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:pink_ad/app/data/api_service.dart';
import 'package:pink_ad/app/models/shop_detail_model.dart';
import 'package:http/http.dart' as http;
import 'package:pink_ad/app/routes/app_pages.dart';

class AllShopsController extends GetxController {
  //TODO: Implement AllShopsController
  List shopList = [].obs;
  final ApiService _apiService = ApiService(http.Client());

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getShopDetail(int id) async {
    print(id);
    // isLoading.value = true;
    final response = await _apiService.getData('shop-detail/$id');
    final result = json.decode(response.body);
    print(result);
    // MapEntry<dynamic, dynamic> shopDetail = ShopDetail.fromJson(result);
    // var temp = ShopDetail.fromJson(result);
    Get.toNamed(Routes.SHOP_DETAILS, arguments: {
      'data': result,
      'seller': false,
    });
    // isLoading.value = false;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
