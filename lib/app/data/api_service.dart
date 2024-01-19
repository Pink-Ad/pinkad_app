import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../utilities/custom_widgets/snackbars.dart';

class ApiService {
  static const String baseUrl = 'https://pinkad.pk/portal/api';
  static const String imageBaseUrl = 'https://pinkad.pk/portal/public/storage/';
  final http.Client _client;
  static const String modelBaseUrl = 'https://model.pinkad.pk/aimodel/';

  ApiService(this._client);

  void setAuthCredentials(String username, String password) {}

  Future<http.Response> postData(String endpoint, body) async {
    try {
      var response = await http
          .post(
            Uri.parse('$baseUrl/$endpoint'),

            // headers: {
            //   'Authorization': 'Basic ${base64Encode(utf8.encode('$_username:$_password'))}'
            // },
            body: body,
          )
          .timeout(const Duration(seconds: 60));
      if (kDebugMode) {
        print(response.statusCode);
      }
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // If the response is successful, return it
        return response;
      } else if (response.statusCode == 400) {
        // If the request was invalid, show a snackbar with a message
        Get.snackbar('Error', 'Invalid request');
        throw Exception('Invalid request');
      } else if (response.statusCode == 401) {
        // If the user is unauthorized, show a snackbar with a message
        showSnackBarError(
          'Error',
          'Unauthorized',
        );
        // Get.snackbar('Error', 'Unauthorized');
        throw Exception('Unauthorized');
      } else if (response.statusCode == 404) {
        // If the resource is not found, show a snackbar with a message
        showSnackBarError('Error', 'Resource not found');
        throw Exception('Resource not found');
      } else if (response.statusCode == 500) {
        // If there is an internal server error, show a snackbar with a message
        showSnackBarError('Error', 'Internal server error');
        throw Exception('Internal server error');
      } else {
        // If the response is any other status code, show a snackbar with a message
        Get.snackbar('Error', 'An error occurred');
        throw Exception('An error occurred');
      }
    } catch (e) {
      // If an exception is thrown, show a snackbar with a message
      // showSnackBarError("Server Error", "Something went wrong on server side");
      throw Exception(e);
    }
  }

  Future<dynamic> getData(String endpoint) async {
    final response = await _client.get(
      Uri.parse('$baseUrl/$endpoint'),
      // headers: {
      //   'Content-Type': 'application/json',
      //   'Authorization': 'Basic ${base64Encode(utf8.encode('$_username:$_password'))}'
      // },
    );
    print("${Uri.parse('$baseUrl/$endpoint')}");
    if (response.statusCode == 200) {
      //  final jsonData = jsonDecode(response.body);
      return response;
    } else if (response.statusCode == 500) {
      showSnackBarRetry(
        'Server Error',
        'Something went worng on server side',
        () {},
      );
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<dynamic> getDataWithHeader(String endpoint, String token) async {
    final response = await _client.get(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print("${Uri.parse('$baseUrl/$endpoint')}");
    if (response.statusCode == 200) {
      //  final jsonData = jsonDecode(response.body);
      return response;
    } else if (response.statusCode == 500) {
      // showSnackBarRetry(
      //     "Server Error", "Something went worng on server side", () {});
    } else {
      // throw Exception('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> body) async {
    final response = await _client.put(
      Uri.parse('$baseUrl/$endpoint'),
      // headers: {
      //   'Content-Type': 'application/json',
      //   'Authorization': 'Basic ${base64Encode(utf8.encode('$_username:$_password'))}'
      // },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData;
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<dynamic> delete(String endpoint) async {
    final response = await _client.delete(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Basic ${base64Encode(utf8.encode('$_username:$_password'))}'
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData;
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  }
}

class Endpoints {
  static const String login = 'seller/login';
  static const String offerUpload = 'create/offer?';
  static const String category = 'category';
  static const String salesman = 'salesman/list';
  static const String cities = 'cities-list';
  static const String shop = 'all/shop/list';
  static const String areas = 'area';
  static const String createShop = 'create/shop';
  static const String createOffer = 'create/offer';
  static const String province = 'province';
  static const String allOffers = 'offer-filter';
  static const String topOffers = 'top-offer';
  static const String featuredOffers = 'featured-offer';
  static const String topSeller = 'top-selller-list';
  static const String featureSeller = 'featured-selller-list';
  static const String banner = 'list/banner';
  static const String shopOffer = 'shop/offer';
  static const String sellerShop = 'list/shop';
  static const String offerStatus = 'offer/status';
  static const String customerLogin = 'cutomer/login';
  static const String tutorial = 'tutorial/video';
  static const String feedback = 'feedback/store';
  static const String deleteUser = 'delete/user';
  static const String aiModel = 'predict';
  static const String forgetPassword = 'password/email';
  static const String getAllSeller = 'all-selller-list';
  static const String getOfferByShop = 'get_posts_by_seller';
}
