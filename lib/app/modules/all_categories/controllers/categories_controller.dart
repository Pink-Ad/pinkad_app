import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pink_ad/app/data/api_service.dart';
import 'package:pink_ad/app/models/category_model.dart';
import 'package:pink_ad/app/models/offer_list_model.dart';
import 'package:pink_ad/app/modules/all_offers/controllers/all_offers_controller.dart';
import 'package:pink_ad/app/modules/all_offers/views/all_offers_view.dart';

class CategoriesController extends GetxController {
  final ApiService _apiService = ApiService(http.Client());
  var categories = <Category>[].obs;
  var filteredCategories = <Category>[].obs;
  final searchController = TextEditingController();
  GlobalKey filterKey = GlobalKey();

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    searchController.addListener(() {
      filterCategories(searchController.text);
    });
  }

  Future<void> fetchCategories() async {
    try {
      final response = await _apiService.getData(Endpoints.category);
      if (response.statusCode == 200) {
        final List<dynamic> decodedList = json.decode(response.body);
        final List<Category> categoriesList = decodedList.map((json) => Category.fromJson(json)).toList();
        categories.assignAll(categoriesList);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Failed to fetch categories: $e');
    }
  }

  Future<void> fetchOffersByCategory(int categoryId) async {
    try {
      final response = await _apiService.getData('offers?category_id=$categoryId');
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        List<OfferList> offersList = result.map<OfferList>((json) => OfferList.fromJson(json)).toList();
        Get.find<AllOffersController>().offers.assignAll(offersList);
        Get.to(() => AllOffersView());
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Failed to fetch offers: $e');
    }
  }

  // Future<void> fetchCategories() async {
  //   try {
  //     final result = await _apiService.getData(Endpoints.category);
  //     final List<Category> categoriesList = List<Category>.from(result.map((json) => Category.fromJson(json)));
  //     categories.assignAll(categoriesList);
  //   } catch (e) {
  //     print('Failed to fetch categories: $e');
  //   }
  // }

  void filterCategories(String query) {
    if (query.isEmpty) {
      filteredCategories.assignAll(categories);
    } else {
      filteredCategories.assignAll(
        categories.where(
          (category) => category.name.toLowerCase().contains(query.toLowerCase()),
        ),
      );
    }
  }

  List<Category> getSuggestions(String query) {
    if (query.isEmpty) {
      return categories;
    } else {
      return categories.where((category) => category.name.toLowerCase().contains(query.toLowerCase())).toList();
    }
  }
}
