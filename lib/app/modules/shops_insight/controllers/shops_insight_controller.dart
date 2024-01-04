import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pink_ad/app/data/api_service.dart';
import 'package:pink_ad/app/models/offer_list_model.dart';
import 'package:pink_ad/utilities/colors/colors.dart';
import 'package:pink_ad/utilities/custom_widgets/states_tiles.dart';
import 'package:pink_ad/utilities/custom_widgets/text_utils.dart';
import 'package:pink_ad/utilities/utils.dart';

class ShopsInsightController extends GetxController {
  // SplashController splashController = Get.put(SplashController());
  //TODO: Implement ShopsInsightController
  final box = GetStorage();
  List offerList = [].obs;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getShopOffer();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  final ApiService _apiService = ApiService(http.Client());

  List<dynamic> shopOffer = <dynamic>[].obs;
  List<dynamic> active = <dynamic>[].obs;
  List<dynamic> deActive = <dynamic>[].obs;
  var selectedButton = 0.obs;
  RxBool isLoading = false.obs;

  void selectButton(int buttonIndex) {
    selectedButton.value = buttonIndex;
  }

  Future<void> activeDeActiveOffer({required int offerId, required String status}) async {
    // void login() async {
    isLoading.value = true;
    try {
      Map data = {'offer_id': offerId, 'status': status};

      print(data);
      const url = '${ApiService.baseUrl}/api/offer/status';
      // final response = await _apiService.postData(
      //   Endpoints.offerStatus,
      //   data,
      // );
      final request = http.MultipartRequest('POST', Uri.parse(url)); // Create the multipart request
      request.fields.addAll({
        'offer_id': offerId.toString(),
        'status': status.toString(),
      }); // Add the other fields to the request

      final response = await http.Response.fromStream(await request.send()); // Send the request
      print('controller status${response.body}');
      final result = json.decode(response.body);
      await getShopOffer();
      await getOffers();
      await getTopOffer();
      await getFeaturedOffer();

      print(result);
      // var loginResponseData = LoginResponse.fromJson(result);
      // print(loginResponseData.message);
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
      //     Get.toNamed(Routes.User_Bottom_Nav_Bar);
      //   } else {
      // showSnackBarError(
      //   "Message",
      //   loginResponseData.message!,
      // );
      //   }
      // } else if (response.statusCode == 401) {
      //   showSnackBarError(
      //     "Message",
      //     loginResponseData.message!,
      //   );
      // } else {
      //   Get.snackbar("Login Error", "Unsuccessful");
      // }
      // handle success response
      // } catch (e) {
      //   loading.value = false;
      //   // handle error
      //   if (kDebugMode) {
      //     print('this is error ${e.toString()}');
      //   }
      // } finally {

      isLoading.value = false;
      // }
    } catch (e) {
      isLoading.value = false;
    }
  }

  Future<void> getShopOffer() async {
    try {
      isLoading.value = true;
      int id = await box.read('selectedShop');
      print(id);
      final response = await _apiService.getData('${Endpoints.shopOffer}/$id');

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        active = [];
        deActive = [];
        // shopList = result.map((json) => ShopList.fromJson(json)).toList();
        result.forEach((obj) {
          if (obj['status']?.toString() == '1') {
            active.add(obj); // Sort into list1
          } else {
            deActive.add(obj); // Sort into list2'
          }
        });
        print(deActive);
        isLoading.value = false;
        // shopOffer.addAll(result);
      }
    } catch (e) {
      isLoading.value = false;
      print(e);

      // showSnackBarError("Error", "Something went wrong please try again later");
    }
  }

  void showAwesomeDialog({required int offerId}) {
    AwesomeDialog(
      dialogType: DialogType.noHeader,
      context: Get.overlayContext!,
      animType: AnimType.scale,
      btnOkColor: secondary,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      btnCancelColor: bodyTextColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SvgPicture.asset("assets/svgIcons/dialog_icon.svg"),
          // SizedBox(
          //   height: 20.h,
          // ),
          Text(
            'Are you sure?',
            style: CustomTextView.getStyle(Get.context!, colorLight: secondary, fontSize: 20.sp, fontFamily: Utils.poppinsBold),
          ),
          SizedBox(
            height: 15.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'You want to delete this offer?',
              textAlign: TextAlign.center,
              style: CustomTextView.getStyle(Get.context!, colorLight: textColor, fontSize: 14.sp),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
      btnOk: GestureDetector(
        onTap: () async {
          await activeDeActiveOffer(offerId: offerId, status: '0');
          Get.back();
        },
        child: Container(
          width: 138.0.w,
          height: 50.0.h,
          decoration: BoxDecoration(
            color: errorColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              'Delete',
              style: CustomTextView.getStyle(Get.context!, colorLight: Colors.white, fontSize: 16.sp, fontFamily: Utils.poppinsMedium),
            ),
          ),
        ),
      ),
      btnCancel: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Container(
          width: 138.0.w,
          height: 50.0.h,
          decoration: BoxDecoration(
            color: bodyTextColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              'Cancel',
              style: CustomTextView.getStyle(Get.context!, colorLight: Colors.white, fontSize: 16.sp, fontFamily: Utils.poppinsMedium),
            ),
          ),
        ),
      ),
    ).show();
  }

  Future<void> getOffers() async {
    try {
      final response = await _apiService.getData(Endpoints.allOffers);

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        offerList.addAll(result.map((json) => OfferList.fromJson(json)).toList());
        await box.write('offers', offerList);
      }
    } catch (e) {
      // isLoading.value = false;
      print(e);

      // showSnackBarError("Error", "Something went wrong please try again later");
    }
  }

  Future<void> getTopOffer() async {
    try {
      final response = await _apiService.getData(Endpoints.topOffers);

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        // print(result['data'].length);
        // shopList = result.map((json) => ShopList.fromJson(json)).toList();
        // fSellerList.addAll(result
        //     .map((json) => FeaturedSeller.fromJson(json['data']))
        //     .toList());

        await box.write('topOffer', result['data']);
      }
    } catch (e) {
      // isLoading.value = false;
      print(e);

      // showSnackBarError("Error", "Something went wrong please try again later");
    }
  }

  Future<void> getFeaturedOffer() async {
    try {
      final response = await _apiService.getData(Endpoints.featuredOffers);

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        // print(result['data'].length);
        // shopList = result.map((json) => ShopList.fromJson(json)).toList();
        // fSellerList.addAll(result
        //     .map((json) => FeaturedSeller.fromJson(json['data']))
        //     .toList());
        await box.write('fOffer', result['data']);
      }
    } catch (e) {
      // isLoading.value = false;
      print(e);

      // showSnackBarError("Error", "Something went wrong please try again later");
    }
  }

  void showRevisionDialog({required int offerId}) {
    AwesomeDialog(
      dialogType: DialogType.noHeader,
      context: Get.overlayContext!,
      animType: AnimType.scale,
      btnOkColor: secondary,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      btnCancelColor: bodyTextColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SvgPicture.asset("assets/svgIcons/dialog_icon.svg"),
          // SizedBox(
          //   height: 20.h,
          // ),
          Text(
            'Are you sure?',
            style: CustomTextView.getStyle(Get.context!, colorLight: secondary, fontSize: 20.sp, fontFamily: Utils.poppinsBold),
          ),
          SizedBox(
            height: 15.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'You want to re-active this offer?',
              textAlign: TextAlign.center,
              style: CustomTextView.getStyle(Get.context!, colorLight: textColor, fontSize: 14.sp),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
      btnOk: GestureDetector(
        onTap: () async {
          await activeDeActiveOffer(offerId: offerId, status: '1');
          Get.back();
        },
        child: Container(
          width: 138.0.w,
          height: 50.0.h,
          decoration: BoxDecoration(
            color: secondary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              'Re-active',
              style: CustomTextView.getStyle(Get.context!, colorLight: Colors.white, fontSize: 16.sp, fontFamily: Utils.poppinsMedium),
            ),
          ),
        ),
      ),
      btnCancel: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Container(
          width: 138.0.w,
          height: 50.0.h,
          decoration: BoxDecoration(
            color: bodyTextColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              'Cancel',
              style: CustomTextView.getStyle(Get.context!, colorLight: Colors.white, fontSize: 16.sp, fontFamily: Utils.poppinsMedium),
            ),
          ),
        ),
      ),
    ).show();
  }

  void showCustomDialog({required int reach, required int view, required int impression, required int conversion}) {
    AwesomeDialog(
      dialogType: DialogType.noHeader,
      context: Get.overlayContext!,
      animType: AnimType.scale,
      btnOkColor: secondary,
      btnCancelColor: bodyTextColor,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Insight',
                  style: CustomTextView.getStyle(Get.context!, colorLight: secondary, fontSize: 22.sp, fontFamily: Utils.poppinsSemiBold),
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(Icons.close),
                ),
              ],
            ),
            SizedBox(height: 15.h),
            StatsTiles(conversion: conversion, view: view, impression: impression, reach: reach),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    ).show();
  }

  void increment() => count.value++;
}
