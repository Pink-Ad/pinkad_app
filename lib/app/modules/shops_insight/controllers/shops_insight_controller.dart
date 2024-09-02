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
import 'package:pink_ad/utilities/custom_widgets/text_utils.dart';
import 'package:pink_ad/utilities/utils.dart';

class ShopsInsightController extends GetxController {
  final box = GetStorage();
  List offerList = [].obs;
  final count = 0.obs;
  final ApiService _apiService = ApiService(http.Client());
  List<dynamic> shopOffer = <dynamic>[].obs;
  List<dynamic> active = <dynamic>[].obs;
  List<dynamic> deActive = <dynamic>[].obs;
  var selectedButton = 0.obs;
  RxBool isLoading = false.obs;

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

  void selectButton(int buttonIndex) {
    selectedButton.value = buttonIndex;
  }

  Future<void> activeDeActiveOffer({
    required int offerId,
    required String status,
  }) async {
    isLoading.value = true;
    try {
      const url = '${ApiService.baseUrl}/offer/status';
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );
      request.fields.addAll({
        'offer_id': offerId.toString(),
        'status': status.toString(),
      });

      final response = await http.Response.fromStream(
        await request.send(),
      );
      final result = json.decode(response.body);

      if (response.statusCode == 200) {
        print('Offer status updated successfully: $result');
      } else {
        print('Failed to update offer status: ${response.statusCode}');
      }

      await getShopOffer();
      await getOffers();
      await getTopOffer();
      await getFeaturedOffer();

      print(result);
    } catch (e) {
      print('Error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteInactiveOffer({
    required int offerId,
  }) async {
    isLoading.value = true;
    try {
      // Update the URL based on backend specifications
      final url = 'https://pinkad.pk/portal/api/delete-offer/$offerId';
      print('Deleting offer with URL: $url'); // Debugging statement
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print('Inactive offer deleted successfully');
        await getShopOffer(); // Refresh the shop offers after deletion
      } else {
        print('Failed to delete inactive offer: ${response.statusCode}');
        print('Response body: ${response.body}'); // Debugging statement
      }
    } catch (e) {
      print('Error occurred while deleting inactive offer: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getShopOffer() async {
    try {
      isLoading.value = true;
      int id = await box.read('selectedShop');
      print('Selected Shop ID: $id');
      final response = await _apiService.getData('${Endpoints.shopOffer}/$id');

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        active.clear();
        deActive.clear();
        result.forEach((obj) {
          if (obj['status']?.toString() == '1') {
            active.add(obj);
          } else if (obj['status']?.toString() != '2') {
            deActive.add(obj);
          }
        });
        print('Active Offers: $active');
        print('Inactive Offers: $deActive');
        isLoading.value = false;
      } else {
        print('Failed to fetch shop offers: ${response.statusCode}');
      }
    } catch (e) {
      isLoading.value = false;
      print('Error in getShopOffer: $e');
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
          Text(
            'Are you sure?',
            style: CustomTextView.getStyle(
              Get.context!,
              colorLight: secondary,
              fontSize: 20.sp,
              fontFamily: Utils.poppinsBold,
            ),
          ),
          SizedBox(height: 15.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'You want to move active offer to inactive offer?',
              textAlign: TextAlign.center,
              style: CustomTextView.getStyle(
                Get.context!,
                colorLight: textColor,
                fontSize: 14.sp,
              ),
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
      btnOk: GestureDetector(
        onTap: () async {
          print('Deleting offer with ID: $offerId');
          Get.back();
          await activeDeActiveOffer(offerId: offerId, status: '0');
          print('Offer deleted');
          await getShopOffer();
        },
        child: Container(
          width: 138.0.w,
          height: 50.0.h,
          decoration: BoxDecoration(
            color: primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              'Move',
              style: CustomTextView.getStyle(
                Get.context!,
                colorLight: Colors.white,
                fontSize: 16.sp,
                fontFamily: Utils.poppinsMedium,
              ),
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
              style: CustomTextView.getStyle(
                Get.context!,
                colorLight: Colors.white,
                fontSize: 16.sp,
                fontFamily: Utils.poppinsMedium,
              ),
            ),
          ),
        ),
      ),
    ).show();
  }

  void showDeleteDialog({required int offerId}) {
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
          Text(
            'Are you sure?',
            style: CustomTextView.getStyle(
              Get.context!,
              colorLight: secondary,
              fontSize: 20.sp,
              fontFamily: Utils.poppinsBold,
            ),
          ),
          SizedBox(height: 15.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'You want to delete this offer?',
              textAlign: TextAlign.center,
              style: CustomTextView.getStyle(
                Get.context!,
                colorLight: textColor,
                fontSize: 14.sp,
              ),
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
      btnOk: GestureDetector(
        onTap: () async {
          print('Deleting inactive offer with ID: $offerId');
          Get.back();
          await deleteInactiveOffer(offerId: offerId); // Call the new delete method
          print('Inactive offer deleted');
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
              style: CustomTextView.getStyle(
                Get.context!,
                colorLight: Colors.white,
                fontSize: 16.sp,
                fontFamily: Utils.poppinsMedium,
              ),
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
              style: CustomTextView.getStyle(
                Get.context!,
                colorLight: Colors.white,
                fontSize: 16.sp,
                fontFamily: Utils.poppinsMedium,
              ),
            ),
          ),
        ),
      ),
    ).show();
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
          Text(
            'Are you sure?',
            style: CustomTextView.getStyle(
              Get.context!,
              colorLight: secondary,
              fontSize: 20.sp,
              fontFamily: Utils.poppinsBold,
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'You want to re-active this offer?',
              textAlign: TextAlign.center,
              style: CustomTextView.getStyle(
                Get.context!,
                colorLight: textColor,
                fontSize: 14.sp,
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
      btnOk: GestureDetector(
        onTap: () async {
          Get.back(); // Close the dialog before performing the action
          await activeDeActiveOffer(offerId: offerId, status: '1');
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
              style: CustomTextView.getStyle(
                Get.context!,
                colorLight: Colors.white,
                fontSize: 16.sp,
                fontFamily: Utils.poppinsMedium,
              ),
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
              style: CustomTextView.getStyle(
                Get.context!,
                colorLight: Colors.white,
                fontSize: 16.sp,
                fontFamily: Utils.poppinsMedium,
              ),
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
      print(e);
    }
  }

  Future<void> getTopOffer() async {
    try {
      final response = await _apiService.getData(Endpoints.topOffers);

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        await box.write('topOffer', result['data']);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getFeaturedOffer() async {
    try {
      final response = await _apiService.getData(Endpoints.featuredOffers);

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        await box.write('fOffer', result['data']);
      }
    } catch (e) {
      print(e);
    }
  }
}
