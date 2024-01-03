import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pink_ad/app/data/api_service.dart';
import 'package:pink_ad/app/models/areas_model.dart';
import 'package:pink_ad/app/models/cites_model.dart';
import 'package:pink_ad/app/models/login_response.dart';
import 'package:pink_ad/app/models/province_model.dart';
import 'package:pink_ad/app/routes/app_pages.dart';
import 'package:pink_ad/utilities/custom_widgets/snackbars.dart';

class AddShopController extends GetxController {
  final box = GetStorage();
  //TODO: Implement AddShopController
  RxBool isLoading = false.obs;
  final count = 0.obs;
  final RxString logoName = RxString('');
  final nameController = TextEditingController().obs;
  final addressController = TextEditingController().obs;
  final businessNameController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  final descriptionController = TextEditingController().obs;
  List shopList = [].obs;
  List shopName = [].obs;

  XFile? pickedFile;
  RxList<City> citiesName = <City>[].obs;
  RxList<City> areaName = <City>[].obs;
  Rx<City?> selectedarea = Rx<City?>(null);
  Rx<City?> selectedCity = Rx<City?>(null);
  RxList<City> provinceName = <City>[].obs;
  Rx<City?> selectedProvince = Rx<City?>(null);
  final ApiService _apiService = ApiService(http.Client());

  @override
  void onInit() {
    super.onInit();
    // getProvince();
    getCities();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getSellerShop(String token) async {
    try {
      final response = await _apiService.getDataWithHeader(Endpoints.sellerShop, token);

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        // List category =
        //     result.map((json) => SellerShop.fromJson(json)).toList();
        shopName.addAll(result);
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

  Future<void> getCities() async {
    // isLoading.value = true;
    final response = await _apiService.getData(Endpoints.cities);
    final result = json.decode(response.body);
    List cities = result.map((json) => Cities.fromJson(json)).toList();
    for (var city in cities) {
      citiesName.add(City(id: city?.id, name: city?.name));
    }
    // isLoading.value = false;
    print(citiesName[0].name);
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

  Future<XFile?> pickImage() async {
    // Request permission from the user
    final permissionStatus = await Permission.photos.request();
    if (permissionStatus.isGranted) {
      // User has granted permission, proceed with picking an image
      final picker = ImagePicker();
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        logoName.value = pickedFile!.name;
      }
    } else {
      // User has denied permission, show an error message
      print('Permission denied');
    }
    return pickedFile;
  }

  void clear() {
    businessNameController.value.clear();
    addressController.value.clear();
    nameController.value.clear();
    descriptionController.value.clear();
    phoneController.value.clear();
    areaName.clear();
    citiesName.clear();
    pickedFile = null;
  }

  void onSubmit() {
    if (businessNameController.value.text.isEmpty) {
      showSnackBarError('Error', 'Business name field cannot be empty');
    } else if (addressController.value.text.isEmpty) {
      showSnackBarError('Error', 'Address field cannot be empty');
    } else if (descriptionController.value.text.isEmpty) {
      showSnackBarError('Error', 'Description field cannot be empty');
    } else if (phoneController.value.text.isEmpty) {
      showSnackBarError('Error', 'Contact Number field cannot be empty');
    } else {
      addShop();
    }
  }

  Future<void> addShop() async {
    final box = GetStorage();
    final savedToken = box.read('user_token');
    LoginResponse data = await box.read('user_data');

    isLoading.value = true;
    const url = '${ApiService.baseUrl}/${Endpoints.createShop}';
    final businessName = businessNameController.value.text.trim();
    final address = addressController.value.text.trim();
    final descroption = descriptionController.value.text.trim();
    final phone = phoneController.value.text.trim();

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      ); // Create the multipart request
      request.files.add(
        await http.MultipartFile.fromPath(
          'logo',
          pickedFile!.path,
        ),
      ); // Add the file to the request
      request.fields.addAll({
        'name': data.user!.seller!.businessName!,
        'branch_name': businessName,
        'address': address,
        'contact_number': phone,
        'description': descroption,
        // 'shop_name': businessName,

        'area': selectedarea.value!.id.toString(),
      }); // Add the other fields to the request
      request.headers['Authorization'] = 'Bearer $savedToken';

      print(request.fields.toString());
      final response = await http.Response.fromStream(
        await request.send(),
      ); // Send the request
      // final postResponse =
      //     RegisterPostResponse.fromJson(json.decode(response.body));
      print(json.decode(response.body));
      if (response.statusCode == 201) {
        await getSellerShop(savedToken);
        // Successful request
        isLoading.value = false;
        // addShop();
        // if (postResponse.status == "success") {
        showSnackBarSuccess(
          'Message',
          'Shop created Successfully',
        );
        Get.toNamed(Routes.User_Bottom_Nav_Bar);
        clear();
        // Get.toNamed(Routes.LOGIN);
      } else {
        isLoading.value = false;
        showSnackBarError(
          'Message',
          'Something went wrong',
        );
        // }
        // } else {
        isLoading.value = false;
        //   // Error occurred
        //   print('Error occurred while adding ship: ${response.statusCode}');
      }
    } catch (e) {
      isLoading.value = false;
      // Exception occurred
      print('Exception occurred while registering user: $e');
    }
  }

  void increment() => count.value++;
}
