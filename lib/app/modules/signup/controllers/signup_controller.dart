import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pink_ad/app/models/areas_model.dart';
import 'package:pink_ad/app/models/cites_model.dart';
import 'package:pink_ad/app/models/province_model.dart';
import 'package:pink_ad/app/models/salesman_model.dart';

import '../../../../utilities/custom_widgets/snackbars.dart';
import '../../../data/api_service.dart';
import '../../../models/register_response.dart';
import '../../../routes/app_pages.dart';

class SignupController extends GetxController {
  //TODO: Implement SignupController
  RxBool isLoading = false.obs;

  final nameController = TextEditingController().obs;
  final whatsappNoController = TextEditingController().obs;
  final phoneNoController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final addressController = TextEditingController().obs;
  final businessNameController = TextEditingController().obs;
  final businessAddressController = TextEditingController().obs;
  final facebookController = TextEditingController().obs;
  final instagramController = TextEditingController().obs;
  late final isPasswordVisible = false.obs;
  final passwordController = TextEditingController().obs;
  // final branchNameController = TextEditingController().obs;
  final webSiteController = TextEditingController().obs;
  final descriptionController = TextEditingController().obs;
  final ApiService _apiService = ApiService(http.Client());
  final RxString logoName = RxString('');
  final RxString coverLogoName = RxString('');
  final RxString city = RxString('');
  RxList<City> citiesName = <City>[].obs;
  RxList<City> areaName = <City>[].obs;
  RxList<City> salesmanName = <City>[].obs;
  RxList<City> provinceName = <City>[].obs;
  Rx<City?> selectedProvince = Rx<City?>(null);
  Rx<City?> selectedarea = Rx<City?>(null);
  Rx<City?> selectedCity = Rx<City?>(null);
  Rx<City?> selectedSalesman = Rx<City?>(null);
  final RxString selectedOption = 'How you got PinkAd'.obs;

  XFile? pickedFile;
  XFile? coverFile;
  final List<String> temp = [];
  bool isNameValid(String name) {
    const pattern = r'^[a-zA-Z ]+$';
    final regex = RegExp(pattern);
    return regex.hasMatch(name);
  }

  bool isValidPhoneNumber(String input) {
    final RegExp regex = RegExp(
        r'^\+?1?\d{9,15}$'); // This regex matches US phone numbers in various formats
    return regex.hasMatch(input);
  }

  void onSubmit() {
    if (nameController.value.text.isEmpty) {
      showSnackBarError("Error", "Name field cannot be empty");
    } else if (!isValidPhoneNumber(whatsappNoController.value.text)) {
      showSnackBarError(
          "Error", "Invalid whatsapp number format / field cannot be empty");
    } else if (!isValidPhoneNumber(phoneNoController.value.text)) {
      showSnackBarError("Error", "Invalid phone number format");
    } else if (emailController.value.text.isEmpty) {
      showSnackBarError("Error", "Email field cannot be empty");
    } else if (passwordController.value.text.isEmpty) {
      showSnackBarError("Error", "Password cannot be empty");
    } else if (businessAddressController.value.text.isEmpty) {
      showSnackBarError("Error", "Business address field cannot be empty");
    }
    // else if (facebookController.value.text.isEmpty) {
    //   showSnackBarError("Error", "Facebook field cannot be empty");
    // } else if (instagramController.value.text.isEmpty) {
    //   showSnackBarError("Error", "Instagram field cannot be empty");
    // } else if (webSiteController.value.text.isEmpty) {
    //   showSnackBarError("Error", "Website field cannot be empty");
    // }
    else if (descriptionController.value.text.isEmpty) {
      showSnackBarError("Error", "Description field cannot be empty");
    } else {
      registerUser();
    }
  }

  @override
  void onInit() {
    super.onInit();
    // getCategory();
    salesman();
    // getProvince();
    gerCities();
  }

  Future<XFile?> pickImage() async {
    // Request permission from the user
    final permissionStatus = await Permission.photos.request();
    print(permissionStatus);
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

  Future<XFile?> pickCoverImage() async {
    // Request permission from the user
    final permissionStatus = await Permission.photos.request();
    if (permissionStatus.isGranted) {
      // User has granted permission, proceed with picking an image
      final picker = ImagePicker();
      coverFile = await picker.pickImage(source: ImageSource.gallery);
      if (coverFile != null) {
        coverLogoName.value = coverFile!.name;
      }
    } else {
      // User has denied permission, show an error message
      print('Permission denied');
    }
    return coverFile;
  }

  Future<void> getCategory() async {
    // isLoading.value = true;

    final response = await _apiService.getData(Endpoints.category);
    if (kDebugMode) {
      print("controller status${response.body}");
    }
    final result = json.decode(response.body);
    // isLoading.value = false;
    List<dynamic> jsonArray = jsonDecode(response.body);

    print(jsonArray[0]['name']);
  }

  setLoading(bool loading) {
    isLoading.value = loading;
  }

  Future<void> salesman() async {
    final response = await _apiService.getData(Endpoints.salesman);
    if (response.statusCode == 200) {
      // print(isLoading.value);
      final result = json.decode(response.body);
      List salesman = result.map((json) => Salesman.fromJson(json)).toList();
      for (var city in salesman) {
        salesmanName.add(City(id: city?.id, name: city?.user?.name));
      }
      // isLoading.value = false;
    } else {
      // isLoading.value = false;
      print(isLoading.value);

      showSnackBarError(
          "Error", "Something went wrong please try again later12");
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

  Future<void> gerCities() async {
    // isLoading.value = true;
    final response = await _apiService.getData(Endpoints.cities);
    final result = json.decode(response.body);
    List cities = result.map((json) => Cities.fromJson(json)).toList();
    for (var city in cities) {
      citiesName.add(City(id: city?.id, name: city?.name));
    }
    // isLoading.value = false;
    // print(citiesName[0].name);
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

  Future<void> registerUser() async {
    isLoading.value = true;
    const url = 'https://pinkad.pk/portal/api/register';
    final name = nameController.value.text.trim();
    final whatsappNo = whatsappNoController.value.text.trim();
    final phoneNo = phoneNoController.value.text.trim();
    final email = emailController.value.text.trim();
    final businessAddress = businessAddressController.value.text.trim();
    final facebook = facebookController.value.text.trim();
    final instagram = instagramController.value.text.trim();
    final password = passwordController.value.text.trim();
    final website = webSiteController.value.text.trim();
    final address = addressController.value.text.trim();
    // final branchName = branchNameController.value.text.trim();
    final description = descriptionController.value.text.trim();
    String ensureHttps(String url) {
      // Check if the URL already contains "http://" or "https://"
      if (url.startsWith("http://") || url.startsWith("https://")) {
        return url; // Already has http:// or https://, return as is
      } else {
        // Add "https://" to the beginning of the URL
        return "https://$url";
      }
    }

    try {
      print(coverFile);
      final request = http.MultipartRequest(
          'POST', Uri.parse(url)); // Create the multipart request
      request.files.add(await http.MultipartFile.fromPath(
          'logo', pickedFile!.path)); // Add the file to the request
      {
        coverFile != null
            ? request.files.add(await http.MultipartFile.fromPath(
                'coverimage', coverFile!.path))
            : null;
      }
      request.fields.addAll({
        'name': name,
        'email': email,
        'password': password,
        'role': "2",
        'phone': phoneNo,
        'whatsapp': whatsappNo,
        'business_name': name,
        'business_address': businessAddress,
        'shop_contact_number': phoneNo,
        'faecbook_page': facebook,
        'insta_page': instagram,
        'web_url': ensureHttps(website),
        'isFeatured': "1",
        'reference': selectedOption.value == 'Other'
            ? '0'
            : selectedSalesman.value!.name,
        'salesman_id': selectedOption.value == 'Other'
            ? '0'
            : selectedSalesman.value!.id.toString(),
        // "branch_name": branchName,
        'shop_name': name,
        'area_id': selectedarea.value!.id.toString(),
        // 'address': address,
        'description': description.toString()
      }); // Add the other fields to the request
      print(request.fields.toString());
      final response = await http.Response.fromStream(
          await request.send()); // Send the request
      final postResponse =
          RegisterPostResponse.fromJson(json.decode(response.body));
      print(response.body.toString());
      if (response.statusCode == 200) {
        // Successful request
        isLoading.value = false;
        if (postResponse.status == "success") {
          showSnackBarSuccess(
            "Message",
            postResponse.message!,
          );
          Get.toNamed(Routes.LOGIN);
        } else {
          showSnackBarError(
            "Message",
            postResponse.message!,
          );
        }
      } else {
        isLoading.value = false;
        showSnackBarError(
          "Message",
          "Something went wrong please try again later",
        );
        // Error occurred
        print('Error occurred while registering user: ${response.statusCode}');
      }
    } catch (e) {
      isLoading.value = false;
      showSnackBarError(
        "Message",
        "Something went wrong please try again later",
      );
      // Exception occurred
      print('Exception occurred while registering user: $e');
    }
  }
}
