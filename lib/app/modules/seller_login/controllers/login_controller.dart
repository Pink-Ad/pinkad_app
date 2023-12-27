import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pink_ad/app/modules/user_dashboard/views/user_bottom_nav_bar.dart';

import '../../../../utilities/custom_widgets/snackbars.dart';
import '../../../data/api_service.dart';
import '../../../models/login_response.dart';

class LoginController extends GetxController {
  late final isPasswordVisible = false.obs;
  final passwordController = TextEditingController().obs;
  late final RxBool loading = false.obs;
  final emailController = TextEditingController().obs;
  final ApiService _apiService = ApiService(http.Client());
  final box = GetStorage();
  List shopName = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    // emailController.value.dispose();
    // passwordController.value.dispose();

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

  Future<void> getSellerShop(String token) async {
    try {
      final response = await _apiService.getDataWithHeader(Endpoints.sellerShop, token);

      print(inspect(response.body));
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        shopName.addAll(result);
        // List category =
        //     result.map((json) => SellerShop.fromJson(json)).toList();
        // for (var city in category) {
        //   shopName.add(City(id: city?.id, name: city?.name));
        // }
      }
      await box.write('selectedShop', shopName[0]['id']);
      await box.write('sellerShop', shopName);
    } catch (e) {
      // isLoading.value = false;
      print(e);
    }
  }

  Future<void> login() async {
    loading.value = true;
    final email = emailController.value.text;
    final password = passwordController.value.text;
    try {
      Map data = {'email': email, 'password': password, 'role': '2'};

      print(data);
      final response = await _apiService.postData(
        Endpoints.login,
        data,
      );
      if (kDebugMode) {
        print('controller status${response.body}');
      }
      final result = json.decode(response.body);

      var loginResponseData = LoginResponse.fromJson(result);
      print(loginResponseData.status);
      if (response.statusCode == 200) {
        if (loginResponseData.status == 'success') {
          final token = loginResponseData.authorisation!.token!;
          box.write('user_data', loginResponseData);
          box.write('user_token', token);
          box.write('user_type', 'seller'); // seller or guest
          box.write('email', email);
          box.write('password', password);
          await getSellerShop(token);
          final savedToken = box.read('user_token');
          print(savedToken);
          emailController.value.clear();
          passwordController.value.clear();
          Get.offAll(UserBottomNavBar());

          // Get.toNamed(Routes.User_Bottom_Nav_Bar);
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
