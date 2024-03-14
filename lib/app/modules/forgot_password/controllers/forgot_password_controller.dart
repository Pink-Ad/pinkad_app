import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pink_ad/utilities/custom_widgets/snackbars.dart';

class ForgotPasswordController extends GetxController {
  //TODO: Implement ForgotPasswordController
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
    emailController.value.dispose();
    super.onClose();
  }

  void loginCheck() {
    if (emailController.value.text.isEmpty) {
      showSnackBarError('Error', 'Email field cannot be empty');
    } else {
      login();
    }
  }

  Future<void> login() async {
    final email = emailController.value.text;
    try {
      Map data = {'email': email};
      print(data);
      const url = 'https://pinkad.pk/portal/api/password/email';
      //const url = 'https://pinkad.pk/portal/password/reset/';
      final response = await http.post(
        Uri.parse(url),
        body: data,
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 301 || response.statusCode == 302) {
        // Follow the redirection
        final newUrl = response.headers['location'];
        if (newUrl != null) {
          final redirectedResponse = await http.post(Uri.parse(newUrl), body: data);
          print('Redirected response status: ${redirectedResponse.statusCode}');
          print('Redirected response body: ${redirectedResponse.body}');
          handleResponse(redirectedResponse);
        }
      } else {
        handleResponse(response);
      }
    } catch (e) {
      showSnackBarError(
        'Message',
        'Something went wrong, please try again later.',
      );
      print('Exception occurred while resetting password: $e');
    }
  }

  void handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['success'] != null) {
        showSnackBarSuccess(
          'Message',
          jsonResponse['success'],
        );
      } else {
        showSnackBarError(
          'Message',
          'Something went wrong, please try again later.',
        );
      }
    } else {
      showSnackBarError(
        'Message',
        'Something went wrong, please try again later.',
      );
      print('Error occurred while resetting password: ${response.statusCode}');
    }
  }
}
