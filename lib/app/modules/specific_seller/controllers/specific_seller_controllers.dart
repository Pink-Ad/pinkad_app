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
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    int? sellerId = Get.arguments['seller_id'];
    if (sellerId != null) {
      fetchOffers(sellerId);
    } else {
      // Handle null case, e.g., show error or default value
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

  Future<void> fetchOffers(int? sellerId) async {
    isLoading.value = true;
    if (sellerId == null) {
      // Handle null case
      isLoading.value = false;
      return;
    }

    try {
      final response =
          await _apiService.getData('${Endpoints.getOfferByShop}/$sellerId');

      final result = json.decode(response.body);
      if (result is List) {
        var fetchedOffers =
            result.map((data) => OfferList.fromJson(data)).toList();

        // Example of accessing the shop in each offer
        for (var offer in fetchedOffers) {
          print('Shop ID: ${offer.shop?.id}'); // Assuming the shop has an ID
          // If shop contains sellerId, access it here
        }

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
}
