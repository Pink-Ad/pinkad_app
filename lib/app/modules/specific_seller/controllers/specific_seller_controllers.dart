import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pink_ad/app/data/api_service.dart';
import 'package:pink_ad/app/models/offer_list_model.dart';
import 'package:pink_ad/app/routes/app_pages.dart';

class SpecificSellerController extends GetxController {
  final ApiService _apiService = ApiService(http.Client());
  var offers = <OfferList>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    int? sellerId = Get.arguments['seller_id'];
    if (sellerId != null) {
      fetchOffers(sellerId);
    } else {
      // Handle null case, e.g., navigate back or show a message
    }
  }

  Future<void> fetchOffers(int? sellerId) async {
    isLoading.value = true;
    if (sellerId == null) {
      isLoading.value = false;
      return;
    }

    try {
      final response = await _apiService.getData('${Endpoints.getOfferByShop}?seller_id=$sellerId');
      final result = json.decode(response.body);
      if (result['seller_posts'] is List) {
        var fetchedOffers = (result['seller_posts'] as List)
            .map((data) => OfferList.fromJson(data))
            .toList();

        offers.assignAll(fetchedOffers);
      } else {
        print('Unexpected format: $result');
      }
    } catch (e) {
      print('Error fetching offers: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getOfferDetail(int id) async {
    try {
      // Make the API request
      final response = await _apiService.getData('offer-detail/$id');

      if (response.statusCode == 200) {
        // Parse the JSON data
        final result = json.decode(response.body);

        // Update the offer details
        Get.toNamed(
          Routes.ALL_OFFER_DETAILS,
          arguments: {
            'data': result,
            'seller': false,
          },
        );

        // Post data to insights/update
        Map data = {'offer_id': id.toString(), 'views': '1'};
        await _apiService.postData('insights/update', data);
      } else {
        // Handle non-200 status codes, if needed
        print('API returned a non-200 status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions that occur during the API request
      print('Error fetching offer details: $e');
    }
  }
}
