import 'dart:convert';
import 'dart:developer';

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
import 'package:pink_ad/app/routes/app_pages.dart';
import 'package:pink_ad/utilities/custom_widgets/snackbars.dart';
import 'package:pink_ad/utilities/functions/show_image_dialog.dart';

class UserProfileController extends GetxController {
  //TODO: Implement UserProfileController
  RxBool isLoading = false.obs;
  Color secondButtonColor = Colors.white;
  final whatsappNoController = TextEditingController().obs;
  final phoneNoController = TextEditingController().obs;
  final businessNameController = TextEditingController().obs;
  final businessAddressController = TextEditingController().obs;
  final facebookController = TextEditingController().obs;
  final instagramController = TextEditingController().obs;
  final webSiteController = TextEditingController().obs;
  final box = GetStorage();
  final ApiService _apiService = ApiService(http.Client());
  XFile? pickedFile;
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
  @override
  void onInit() {
    super.onInit();
    autoFill();
    // gerCities();
    getData();
  }

  String? validatePakistaniPhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    value = value.replaceAll('-', ''); // Remove dashes before validation
    if (value.length != 10) {
      // Change this to 10 if you need 10 digits excluding the country code
      return 'The phone number must be 10 digits long';
    }
    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      // Ensure this regex matches the number of digits you need
      return 'Enter a valid phone number';
    }
    return null;
  }

  String? validateWhatsppNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'WhatsApp number is required';
    }
    value = value.replaceAll('-', '');
    if (value.length != 10) {
      return 'The WhatsApp number must be 10 digits long';
    }
    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return 'Enter a valid WhatsApp number';
    }
    return null;
  }

  void onSubmit() {
    String? whatsappError =
        validateWhatsppNumber(whatsappNoController.value.text);
    if (whatsappError != null) {
      showSnackBarError('Error', whatsappError);
      return; // Stop execution if there is an error
    }
    String? phoneError =
        validatePakistaniPhoneNumber(phoneNoController.value.text);
    if (phoneError != null) {
      showSnackBarError('Error', phoneError);
      return; // Stop execution if there is an error
    }
    // else if (businessNameController.value.text.isEmpty) {
    //   showSnackBarError("Error", "Business name field cannot be empty");
    // }
    else if (businessAddressController.value.text.isEmpty) {
      showSnackBarError('Error', 'Business address field cannot be empty');
    }
    // else if (facebookController.value.text.isEmpty) {
    //   showSnackBarError("Error", "Facebook field cannot be empty");
    // } else if (instagramController.value.text.isEmpty) {
    //   showSnackBarError("Error", "Instagram field cannot be empty");
    // } else if (webSiteController.value.text.isEmpty) {
    //   showSnackBarError("Error", "Website field cannot be empty");
    // }
    else {
      registerUser();
    }
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

  bool isNameValid(String name) {
    const pattern = r'^[a-zA-Z ]+$';
    final regex = RegExp(pattern);
    return regex.hasMatch(name);
  }

  bool isValidPhoneNumber(String input) {
    final RegExp regex = RegExp(
      r'^\+?1?\d{9,15}$',
    ); // This regex matches US phone numbers in various formats
    return regex.hasMatch(input);
  }

  Future<void> autoFill() async {
    LoginResponse data = await box.read('user_data');
    phoneNoController.value.text = data.user!.seller!.phone!;
    whatsappNoController.value.text = data.user!.seller!.whatsapp!;
    // businessNameController.value.text = data.user!.seller!.businessName!;
    businessAddressController.value.text = data.user!.seller!.businessAddress!;
    //facebookController.value.text = data.user!.seller!.facebookPage!;
    facebookController.value.text = data.user?.seller?.facebookPage ?? '';
    instagramController.value.text = data.user?.seller?.instaPage ?? '';
    webSiteController.value.text = data.user!.seller!.webUrl!;
  }

  Future<XFile?> pickImage() async {
    if (await showImageDialog() != true) return null;
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
    LoginResponse data = await box.read('user_data');
    final savedToken = box.read('user_token');

    isLoading.value = true;
    const url = 'https://pinkad.pk/portal/api/seller/update';
    final whatsappNo = whatsappNoController.value.text.trim();
    final phoneNo = phoneNoController.value.text.trim();
    final businessName = businessNameController.value.text.trim();
    final businessAddress = businessAddressController.value.text.trim();
    final facebook = facebookController.value.text.trim();
    final instagram = instagramController.value.text.trim();
    final website = webSiteController.value.text.trim();
    String ensureHttps(String url) {
      // Check if the URL already contains "http://" or "https://"
      if (url.startsWith('http://') || url.startsWith('https://')) {
        return url; // Already has http:// or https://, return as is
      } else {
        // Add "https://" to the beginning of the URL
        return 'https://$url';
      }
    }

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      ); // Create the multipart request
      {
        pickedFile != null
            ? request.files.add(
                await http.MultipartFile.fromPath(
                  'coverimage',
                  pickedFile!.path,
                ),
              )
            : null;
      }

      request.fields.addAll({
        'user_id': data.user!.id.toString(),
        'role': '2',
        'phone': phoneNo,
        'whatsapp': whatsappNo,
        'business_address': businessAddress,
        'faecbook_page': facebook,
        'insta_page': instagram,
        'web_url': ensureHttps(website),
        'isFeatured': '1',
      }); // Add the other fields to the request
      // Add the bearer token to the request headers
      request.headers['Authorization'] = 'Bearer $savedToken';
      final response = await http.Response.fromStream(
        await request.send(),
      ); // Send the request
      // http.StreamedResponse response = await request.send();

      final result = json.decode(response.body);
      if (response.statusCode == 200) {
        // Successful request
        isLoading.value = false;
        if (result['status'] == 'success') {
          showSnackBarSuccess(
            'Message',
            result['message'],
          );
          Get.toNamed(Routes.User_Bottom_Nav_Bar);
        } else {
          showSnackBarError(
            'Message',
            result['message'],
          );
        }
      } else {
        isLoading.value = false;
        // Error occurred
        print('Error occurred while registering user: ${response.statusCode}');
      }
    } catch (e) {
      isLoading.value = false;
      // Exception occurred
      print('Exception occurred while registering user: $e');
    }
  }

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  var selectedButton = 0.obs;
  Future<void> getData() async {
    LoginResponse data = await box.read('user_data');
    print(inspect(data.user!.emailVerifiedAt));
  }

  void selectButton(int buttonIndex) {
    selectedButton.value = buttonIndex;
  }
}
