import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pink_ad/app/data/api_service.dart';
import 'package:pink_ad/utilities/custom_widgets/snackbars.dart';

class ForgotPasswordController extends GetxController {
  final ApiService _apiService = ApiService(http.Client());

  //TODO: Implement ForgotPasswordController
  var phoneNumber = ''.obs;
  late final RxBool loading = false.obs;
  final emailController = TextEditingController().obs;

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
    // TODO: implement onClose
    emailController.value.dispose();

    super.onClose();
  }

  void loginCheck() {
    if (emailController.value.text.isEmpty) {
      showSnackBarError("Error", "Email field cannot be empty");
    } else {
      login();
    }
  }

  void updateUsername(String value) => phoneNumber.value = value;

  void login() async {
    loading.value = true;
    final email = emailController.value.text;
    try {
      Map data = {"email": email};
      print(data);
      final response = await _apiService.postData(
        Endpoints.forgetPassword,
        data,
      );
      // if (kDebugMode) {
      //   print("controller status${response.body}");
      // }
      final result = json.decode(response.body);
      if (response.statusCode == 200) {
        showSnackBarSuccess("Success", result['status']);
      } else {
        showSnackBarError(
          "Message",
          "Something went wrong please try again",
        );
      }

      // var loginResponseData = LoginResponse.fromJson(result);
      // print(loginResponseData.status);
      // if (response.statusCode == 200) {
      //   if (loginResponseData.status == "success") {
      //     final token = loginResponseData.authorisation!.token!;
      //     box.write('user_data', loginResponseData);
      //     box.write('user_token', token);
      //     box.write('email', email);
      //     box.write('password', password);
      //     await getSellerShop(token);
      //     final savedToken = box.read('user_token');
      //     print(savedToken);
      //     emailController.value.clear();
      //     passwordController.value.clear();
      // Get.offAll(UserBottomNavBar());

      // Get.toNamed(Routes.User_Bottom_Nav_Bar);
      //   } else {
      //     showSnackBarError(
      //       "Message",
      //       loginResponseData.status!,
      //     );
      //   }
      // } else if (response.statusCode == 401) {
      //   showSnackBarError(
      //     "Message",
      //     loginResponseData.status!,
      //   );
      // } else {
      //   Get.snackbar("Login Error", "Unsuccessful");
      // }
      // handle success response
    } catch (e) {
      loading.value = false;
      showSnackBarError(
        "Message",
        "Something went wrong please try again",
      );
      // handle error
      if (kDebugMode) {
        print('this is error ${e.toString()}');
      }
    } finally {
      loading.value = false;
    }
  }
}
