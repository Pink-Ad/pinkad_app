import 'dart:convert';
import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pink_ad/app/data/api_service.dart';
import 'package:pink_ad/app/models/areas_model.dart';
import 'package:pink_ad/app/models/category_model.dart';
import 'package:pink_ad/app/models/cites_model.dart';
import 'package:pink_ad/app/models/login_response.dart';
import 'package:pink_ad/app/models/province_model.dart';
import 'package:pink_ad/app/models/shop_model.dart';
import 'package:pink_ad/app/modules/home/controllers/home_controller.dart';
import 'package:pink_ad/app/modules/splash/controllers/splash_controller.dart';
import 'package:pink_ad/utilities/colors/colors.dart';
import 'package:http/http.dart' as http;
import 'package:pink_ad/utilities/utils.dart';
import '../../../../utilities/custom_widgets/snackbars.dart';
import '../../../../utilities/custom_widgets/text_utils.dart';
import '../../../routes/app_pages.dart';

class UploadOfferController extends GetxController {
  HomeController homeController = Get.put(HomeController());
  //TODO: Implement UploadOfferController
  var switchValue = false.obs;
  final ApiService _apiService = ApiService(http.Client());
  SplashController splashController = SplashController();
  var activeColor = Colors.white.obs;
  final titleController = TextEditingController().obs;
  final hashtagController = TextEditingController().obs;
  // final interpreter =
  //     tfl.Interpreter.fromAsset('assets/tenserflow/model.tflite');

  final descriptionController = TextEditingController().obs;
  final RxString imageName = RxString('');
  List offerList = [].obs;

  RxList<City> categoryName = <City>[].obs;
  RxList<City> shopName = <City>[].obs;
  Rx<City?> selectedCategory = Rx<City?>(null);
  RxList<City> subCategoryName = <City>[].obs;
  RxList selectedSubCategory = [].obs;
  RxList selectedShops = [].obs;
  RxList<City> citiesName = <City>[].obs;
  RxList<City> areaName = <City>[].obs;
  RxList<City> provinceName = <City>[].obs;
  Rx<City?> selectedProvince = Rx<City?>(null);
  RxList selectedarea = [].obs;

  // Rx<City?> selectedarea = Rx<City?>(null);
  Rx<City?> selectedCity = Rx<City?>(null);
  var emailVerified;
  // Rx<dynamic> emailVerified = Rx<dynamic?>(null);
  XFile? pickedFile;
  final inputImage = Image.asset('assets/images/title.png');
  var isLoading = false.obs;
  final box = GetStorage();
  List temp = [];
  @override
  void onInit() {
    super.onInit();
    getData();
    getCategories();
    // getShop();
    // getProvince();
    gerCities();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void toggleSwitchValue() {
    switchValue.toggle();
  }

  Future<void> getShop() async {
    final savedToken = box.read('user_token');

    try {
      final response =
          await _apiService.getDataWithHeader(Endpoints.shop, savedToken);

      print(inspect(response.body));
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        List category = result.map((json) => Shop.fromJson(json)).toList();
        for (var city in category) {
          shopName.add(City(id: city?.id, name: city?.name));
        }
      } else {
        // showSnackBarError(
        //     "Error", "Something went wrong please try again later");
      }
      print(shopName[0].name);
    } catch (e) {
      // isLoading.value = false;
      print(e);

      // showSnackBarError("Error", "Something went wrong please try again later");
    }
  }

  Future<void> getCategories() async {
    try {
      final response = await _apiService.getData(Endpoints.category);
      print(inspect(response.body));
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        List category = result.map((json) => Category.fromJson(json)).toList();
        for (var city in category) {
          categoryName.add(City(id: city?.id, name: city?.name));
        }
      } else {
        // showSnackBarError(
        //     "Error", "Something went wrong please try again later");
      }
      print(categoryName[0].name);
    } catch (e) {
      // isLoading.value = false;
      print(e);

      // showSnackBarError("Error", "Something went wrong please try again later");
    }
  }

  Future<void> getSubCategories(int id) async {
    try {
      final response = await _apiService.getData('subcategory?cat_id=$id');
      print(inspect(response.body));
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        List subCategory =
            result.map((json) => SubCategory.fromJson(json)).toList();
        for (var city in subCategory) {
          subCategoryName.add(City(id: city?.id, name: city?.name));
        }
      } else {
        // showSnackBarError(
        //     "Error", "Something went wrong please try again later");
      }
      print(subCategoryName[0].name);
    } catch (e) {
      // isLoading.value = false;
      print(e);

      // showSnackBarError("Error", "Something went wrong please try again later");
    }
  }

  Future<XFile?> pickImage() async {
    // Request permission from the user
    final permissionStatus = await Permission.photos.request();
    if (permissionStatus.isGranted) {
      // User has granted permission, proceed with picking an image
      final picker = ImagePicker();
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        imageName.value = pickedFile!.name;
      }
    } else {
      // User has denied permission, show an error message
      print('Permission denied');
    }
    return pickedFile;
  }

  Future<void> uploadOffers() async {
    if (titleController.value.text.isEmpty) {
      showSnackBarError("Error", "Title field cannot be empty");
    } else if (descriptionController.value.text.isEmpty) {
      showSnackBarError("Error", "description field cannot be empty");
    } else if (selectedSubCategory.isEmpty) {
      showSnackBarError("Error", "Sub-Category field cannot be empty");
    } else {
      // uploadData();
      getModel();
    }
  }

  void showAwesomeDialog() {
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
            style: CustomTextView.getStyle(Get.context!,
                colorLight: secondary,
                fontSize: 20.sp,
                fontFamily: Utils.poppinsBold),
          ),
          SizedBox(
            height: 15.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'You want to upload this offer?',
              textAlign: TextAlign.center,
              style: CustomTextView.getStyle(Get.context!,
                  colorLight: textColor, fontSize: 14.sp),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
      btnOk: GestureDetector(
        onTap: () {
          homeController.setLoading();
          uploadOffers();
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
              'Upload',
              style: CustomTextView.getStyle(Get.context!,
                  colorLight: Colors.white,
                  fontSize: 16.sp,
                  fontFamily: Utils.poppinsMedium),
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
              style: CustomTextView.getStyle(Get.context!,
                  colorLight: Colors.white,
                  fontSize: 16.sp,
                  fontFamily: Utils.poppinsMedium),
            ),
          ),
        ),
      ),
    ).show();
  }

  void showUnverifiedDialog() {
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
          // Text(
          //   'Are you sure?',
          //   style: CustomTextView.getStyle(Get.context!,
          //       colorLight: secondary,
          //       fontSize: 20.sp,
          //       fontFamily: Utils.poppinsBold),
          // ),
          // SizedBox(
          //   height: 15.h,
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Please verify your email to upload the offer',
              textAlign: TextAlign.center,
              style: CustomTextView.getStyle(Get.context!,
                  colorLight: textColor, fontSize: 14.sp),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
      btnOk: GestureDetector(
        onTap: () {
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
              'Ok',
              style: CustomTextView.getStyle(Get.context!,
                  colorLight: Colors.white,
                  fontSize: 16.sp,
                  fontFamily: Utils.poppinsMedium),
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
              style: CustomTextView.getStyle(Get.context!,
                  colorLight: Colors.white,
                  fontSize: 16.sp,
                  fontFamily: Utils.poppinsMedium),
            ),
          ),
        ),
      ),
    ).show();
  }

  Future<void> getProvince() async {
    // isLoading.value = true;
    final response = await _apiService.getData(Endpoints.province);
    final result = json.decode(response.body);
    List cities = result.map((json) => Province.fromJson(json)).toList();
    for (var city in cities) {
      provinceName.add(City(id: city?.id, name: city?.name));
    }
    // isLoading.value = false;
    print(provinceName[0].name);
  }

  Future<void> gerCities() async {
    // isLoading.value = true;
    final response = await _apiService.getData('cities-list');
    final result = json.decode(response.body);
    List cities = result.map((json) => Cities.fromJson(json)).toList();
    for (var city in cities) {
      citiesName.add(City(id: city?.id, name: city?.name));
    }
    // isLoading.value = false;
  }

  Future<void> getData() async {
    LoginResponse data = await box.read('user_data');
    // print(data.user!.emailVerifiedAt);
    emailVerified = data.user!.emailVerifiedAt;
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
    // isLoading.value = false;
  }

  // Future<void> getOffers() async {
  //   try {
  //     final response = await _apiService.getData(Endpoints.allOffers);

  //     if (response.statusCode == 200) {
  //       final result = json.decode(response.body);
  //       offerList
  //           .addAll(result.map((json) => OfferList.fromJson(json)).toList());
  //       await box.write('offers', offerList);
  //     }
  //   } catch (e) {
  //     // isLoading.value = false;
  //     print(e);

  //     // showSnackBarError("Error", "Something went wrong please try again later");
  //   }
  // }
  Future getModel() async {
    const url = ApiService.modelBaseUrl + Endpoints.aiModel;
    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath(
        'file', pickedFile!.path)); // Add the file to the request

    final response = await http.Response.fromStream(
        await request.send()); // Send the request
    final res = json.decode(response.body);
    // if (res['prediction'] == "male") {
    uploadData(res['prediction']);
    // } else {
    //   Get.back();
    //   showSnackBarError(
    //     "Message",
    //     "Image is not according to PinkAd policy, please read image policy before start uploading offer.",
    //   );
    // }
  }

  Future<void> uploadData(predction) async {
    final savedToken = box.read('user_token');
    final shopid = await box.read('selectedShop');
    isLoading.value = true;
    const url = 'http://ms-hostingladz.com/DigitalBrand/api/create/offer';
    final titleValue = titleController.value.text.trim();
    final hashTagValue = hashtagController.value.text.trim();
    final descriptionValue = descriptionController.value.text.trim();

    try {
      final request = http.MultipartRequest(
          'POST', Uri.parse(url)); // Create the multipart request
      request.files.add(await http.MultipartFile.fromPath(
          'banner', pickedFile!.path)); // Add the file to the request

      request.fields.addAll({
        'title': titleValue,
        // 'hash_tag': hashTagValue,
        'IsFeature': switchValue.value ? "1" : "0",
        'description': descriptionValue,
        'category_id': selectedCategory.value!.id.toString(),
        // 'subcat_id[0]': selectedSubCategory.value[0].toString(),
        'shop_id[0]': shopid.toString(),
        'area': selectedarea.value[0].toString(),
        'gender': predction.toString()
      }); // Add the other fields to the request
      selectedSubCategory.value.asMap().forEach((index, value) => request.fields
              .addAll({
            'subcat_id[$index]': selectedSubCategory.value[index].toString()
          }));

// Add the bearer token to the request headers
      request.headers['Authorization'] = 'Bearer $savedToken';
      print(selectedarea.value[0]);
      print(request.headers['Authorization'] = 'Bearer $savedToken');
      print(request.fields.toString());
      final response = await http.Response.fromStream(
          await request.send()); // Send the request

      if (response.statusCode == 200) {
        splashController.getOffers();
        // Successful request
        isLoading.value = false;
        print("response data is ${response.body}");
        titleController.value.clear();
        hashtagController.value.clear();
        descriptionController.value.clear();
        pickedFile = null;
        imageName.value = '';
        switchValue.value = true;
        selectedSubCategory.value = [];
        selectedShops.value = [];
        selectedProvince.value = null;
        selectedCity.value = null;
        selectedarea.value = [];
        selectedCategory.value = null;
        Get.offAllNamed(Routes.User_Bottom_Nav_Bar);
        showSnackBarSuccess(
          "Message",
          "Your offer has been uploaded successfully. kindly go to dashboard to check status.",
        );
        homeController.setLoading();
      } else {
        homeController.setLoading();

        isLoading.value = false;
        // Error occurred
        print('Error occurred while upload offer: ${response.statusCode}');
      }
    } catch (e) {
      homeController.setLoading();
      isLoading.value = false;
      // Exception occurred
      print('Exception occurred while registering user: $e');
    }
  }
}
