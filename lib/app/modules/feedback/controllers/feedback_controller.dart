import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pink_ad/app/data/api_service.dart';
import 'package:pink_ad/app/models/login_response.dart';
import 'package:pink_ad/utilities/custom_widgets/snackbars.dart';

class FeedbackController extends GetxController {
  //TODO: Implement FeedbackController
  RxBool isLoading = false.obs;
  final nameController = TextEditingController().obs;
  final ApiService _apiService = ApiService(http.Client());
  final box = GetStorage();
  final phoneNoController = TextEditingController().obs;
  final descriptionController = TextEditingController().obs;
  bool isValidPhoneNumber(String input) {
    final RegExp regex = RegExp(
      r'^\+?1?\d{9,15}$',
    ); // This regex matches US phone numbers in various formats
    return regex.hasMatch(input);
  }

  bool get isUserLoggedIn => box.read('user_type') != 'guest';

  String stripCountryCode(String phoneNumber) {
    // Regular expression to match the '+92' country code and any non-numeric characters
    RegExp regExp = RegExp(r'\+92|\D');

    // Replace the matched part with an empty string, effectively removing it
    return phoneNumber.replaceAll(regExp, '');
  }

  Future<void> autoFill() async {
    LoginResponse data = await box.read('user_data');

    String formattedPhone = stripCountryCode(data.user!.seller!.phone!);

    phoneNoController.value.text = formattedPhone;
    nameController.value.text = data.user!.seller!.businessName!;
  }

  void onSubmit() {
    if (!isUserLoggedIn && nameController.value.text.isEmpty) {
      showSnackBarError('Error', 'Name field cannot be empty');
    } else if (!isUserLoggedIn &&
        !isValidPhoneNumber(phoneNoController.value.text)) {
      showSnackBarError('Error', 'Invalid phone number format');
    } else if (descriptionController.value.text.isEmpty) {
      showSnackBarError('Error', 'Description field cannot be empty');
    } else {
      submit();
    }
  }

  Future<void> submit() async {
    isLoading.value = true;
    final phoneNo = phoneNoController.value.text.trim();
    final name = nameController.value.text.trim();
    final description = descriptionController.value.text.trim();
    Map data = {'name': name, 'contact': phoneNo, 'feedback': description};

    final response = await _apiService.postData(Endpoints.feedback, data);
    if (kDebugMode) {
      print('controller status${response.body}');
    }
    final result = json.decode(response.body);
    showSnackBarSuccess('Success', result['message']);
    isLoading.value = false;
  }

  final count = 0.obs;
  @override
  void onInit() {
    if (isUserLoggedIn) {
      autoFill();
    }
    super.onInit();
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
