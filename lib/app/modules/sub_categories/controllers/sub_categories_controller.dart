import 'dart:convert'; // Import the json decoder

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pink_ad/app/data/api_service.dart';
import 'package:pink_ad/app/models/subcategory_model.dart';

class SubCategoryController extends GetxController {
  final ApiService _apiService = ApiService(http.Client());
  var subCategories = <SubCategory>[].obs;
  int? selectedCategoryId;

  Future<void> fetchSubCategories(int categoryId) async {
    selectedCategoryId = categoryId; // Store the selected categoryId
    try {
      final response = await _apiService.getData('categories/$categoryId/subcategories');
      if (response.statusCode == 200) {
        final List<dynamic> decodedList = json.decode(response.body);
        final List<SubCategory> subCategoriesList = decodedList.map((json) => SubCategory.fromJson(json)).toList();
        subCategories.assignAll(subCategoriesList);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Failed to fetch subcategories: $e');
    }
  }

  // Future<void> fetchSubCategories(int categoryId) async {
  //   selectedCategoryId = categoryId; // Store the selected categoryId
  //   try {
  //     final result = await _apiService.getData('categories/$categoryId/subcategories');
  //     final List<SubCategory> subCategoriesList = List<SubCategory>.from(result.map((json) => SubCategory.fromJson(json)));
  //     subCategories.assignAll(subCategoriesList);
  //   } catch (e) {
  //     print('Failed to fetch subcategories: $e');
  //   }
  // }

  Future<void> refreshSubCategories() async {
    if (selectedCategoryId != null) {
      await fetchSubCategories(selectedCategoryId!);
    }
  }
}
