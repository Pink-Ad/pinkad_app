import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pink_ad/app/data/api_service.dart';
import 'package:pink_ad/app/models/areas_model.dart';
import 'package:pink_ad/app/models/cites_model.dart';
import 'package:pink_ad/app/models/register_response.dart';
import 'package:pink_ad/app/routes/app_pages.dart';
import 'package:pink_ad/utilities/custom_widgets/snackbars.dart';

class ChatInboxController extends GetxController {
  //TODO: Implement ChatInboxController
  final nameController = TextEditingController().obs;
  final phoneNoController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  late final isPasswordVisible = false.obs;
  final passwordController = TextEditingController().obs;
  RxList<City> citiesName = <City>[].obs;
  RxList<City> areaName = <City>[].obs;
  Rx<City?> selectedarea = Rx<City?>(null);
  RxBool isLoading = false.obs;
  Rx<City?> selectedCity = Rx<City?>(null);
  final ApiService _apiService = ApiService(http.Client());

  @override
  void onInit() {
    super.onInit();
    print('caaaaa');
    // gerCities();
  }

  Future<void> gerCities() async {
    print('called');
    // isLoading.value = true;
    final response = await _apiService.getData(Endpoints.cities);
    final result = json.decode(response.body);
    List cities = result.map((json) => Cities.fromJson(json)).toList();
    for (var city in cities) {
      citiesName.add(City(id: city?.id, name: city?.name));
    }
    print(result);
    // isLoading.value = false;
    // print(citiesName[0].name);
  }

  setAreaId(City data) {
    print(data.name);
    selectedarea.value = data;
  }

  Future<void> getAreas(int id) async {
    // isLoading.value = true;
    final response = await _apiService.getData('area?city_id=$id');
    final result = json.decode(response.body);
    List cities = result.map((json) => Area.fromJson(json)).toList();
    areaName.clear();
    for (var city in cities) {
      areaName.add(City(id: city?.id, name: city?.name));
    }
    print(result);
    // isLoading.value = false;
  }

  @override
  void onReady() {
    super.onReady();
    gerCities();
  }

  @override
  void onClose() {
    super.onClose();
  }

  bool isValidPhoneNumber(String input) {
    final RegExp regex = RegExp(
      r'^\+?1?\d{9,15}$',
    ); // This regex matches US phone numbers in various formats
    return regex.hasMatch(input);
  }

  void onSubmit() {
    print(selectedarea);
    if (nameController.value.text.isEmpty) {
      showSnackBarError('Error', 'Name field cannot be empty');
    } else if (!isValidPhoneNumber(phoneNoController.value.text)) {
      showSnackBarError('Error', 'Invalid phone number format');
    } else if (emailController.value.text.isEmpty) {
      showSnackBarError('Error', 'Email field cannot be empty');
    } else if (passwordController.value.text.isEmpty) {
      showSnackBarError('Error', 'Password cannot be empty');
    } else {
      registerUser();
    }
  }

  Future<void> registerUser() async {
    isLoading.value = true;
    const url = '${ApiService.baseUrl}/register';
    final name = nameController.value.text.trim();
    final phoneNo = phoneNoController.value.text.trim();
    final email = emailController.value.text.trim();
    final password = passwordController.value.text.trim();

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      ); // Create the multipart request
      request.fields.addAll({
        'name': name,
        'email': email,
        'password': password,
        'role': '3',
        'phone': phoneNo,
        'area_id': selectedarea.value!.id.toString(),
        // 'address': address,
      }); // Add the other fields to the request
      final response = await http.Response.fromStream(
        await request.send(),
      ); // Send the request
      final postResponse = RegisterPostResponse.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        // Successful request
        isLoading.value = false;
        if (postResponse.status == 'success') {
          showSnackBarSuccess(
            'Message',
            postResponse.message!,
          );
          Get.toNamed(Routes.USER_LOGIN);
        } else {
          showSnackBarError(
            'Message',
            postResponse.message!,
          );
        }
      } else {
        isLoading.value = false;
        showSnackBarError(
          'Message',
          'Something went wrong please try again later',
        );
        // Error occurred
        print('Error occurred while registering user: ${response.statusCode}');
      }
    } catch (e) {
      isLoading.value = false;
      showSnackBarError(
        'Message',
        'Something went wrong please try again later',
      );
      // Exception occurred
      print('Exception occurred while registering user: $e');
    }
  }
}
