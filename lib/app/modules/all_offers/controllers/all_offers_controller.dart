import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pink_ad/app/data/api_service.dart';
import 'package:pink_ad/app/modules/home/controllers/home_controller.dart';
import 'package:pink_ad/app/modules/splash/controllers/splash_controller.dart';
import 'package:pink_ad/app/routes/app_pages.dart';

class AllOffersController extends GetxController {
  //TODO: Implement AllOffersController
  final ApiService _apiService = ApiService(http.Client());
  HomeController homeController = HomeController();
  final box = GetStorage();
  List<dynamic> offers = [];

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    offers = box.read('offers') ?? [];
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

  Future<void> refreshOffers() async {
    await Get.find<SplashController>().getOffers();
    offers = box.read('offers') ?? [];
    update();
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
