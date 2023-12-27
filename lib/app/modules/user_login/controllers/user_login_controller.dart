import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pink_ad/app/data/api_service.dart';
import 'package:pink_ad/app/models/login_response.dart';
import 'package:pink_ad/app/modules/home/controllers/home_controller.dart';
import 'package:pink_ad/app/modules/home/views/bottom_nav_bar.dart';
import 'package:pink_ad/utilities/custom_widgets/snackbars.dart';

class UserLoginController extends GetxController {
  HomeController homeController = HomeController();
  //TODO: Implement UserLoginController
  late final isPasswordVisible = false.obs;
  late final RxBool loading = false.obs;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final ApiService _apiService = ApiService(http.Client());
  final box = GetStorage();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.value.dispose();
    passwordController.value.dispose();
    super.onClose();
  }

  void loginCheck() {
    if (emailController.value.text.isEmpty) {
      showSnackBarError('Error', 'Email field cannot be empty');
    } else if (passwordController.value.text.isEmpty) {
      showSnackBarError('Error', 'Password field cannot be empty');
    } else {
      login();
    }
  }

  Future<void> login() async {
    loading.value = true;
    final email = emailController.value.text;
    final password = passwordController.value.text;
    try {
      Map data = {'email': email, 'password': password, 'role': '3'};

      print(data);
      final response = await _apiService.postData(
        Endpoints.customerLogin,
        data,
      );
      if (kDebugMode) {
        print('controller status${response.body}');
      }
      final result = json.decode(response.body);

      var loginResponseData = LoginResponse.fromJson(result);
      if (response.statusCode == 200) {
        if (loginResponseData.status == 'success') {
          final token = loginResponseData.authorisation!.token!;
          box.write('customer_data', result);
          box.write('user_type', 'guest');
          box.write('user_token', token);
          // box.write('email', email);
          // box.write('password', password);
          // final savedToken = box.read('user_token');
          emailController.value.clear();
          passwordController.value.clear();
          Get.offAll(BottomNavBar());
          // Get.toNamed(Routes.Bottom_Nav_Bar);
        } else {
          showSnackBarError(
            'Message',
            loginResponseData.status!,
          );
        }
      } else if (response.statusCode == 401) {
        showSnackBarError(
          'Message',
          loginResponseData.status!,
        );
      } else {
        Get.snackbar('Login Error', 'Unsuccessful');
      }
      // handle success response
    } catch (e) {
      loading.value = false;
      // handle error
      if (kDebugMode) {
        print('this is error ${e.toString()}');
      }
    } finally {
      loading.value = false;
    }
  }
}
