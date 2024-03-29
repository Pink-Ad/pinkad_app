import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
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
  final nameController = TextEditingController().obs;
  final whatsappNoController = TextEditingController().obs;
  final phoneNoController = TextEditingController().obs;
  final businessNameController = TextEditingController().obs;
  final businessAddressController = TextEditingController().obs;
  final facebookController = TextEditingController().obs;
  final instagramController = TextEditingController().obs;
  final webSiteController = TextEditingController().obs;
  final descriptionController = TextEditingController().obs;
  late final isPasswordVisible = false.obs;
  var isCurrentPasswordVisible = false.obs;
  var isNewPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;
  final currentpasswordController = TextEditingController().obs;
  final user_id = TextEditingController().obs;

  final newpasswordController = TextEditingController().obs;
  final confirmpasswordController = TextEditingController().obs;
  final box = GetStorage();
  final ApiService _apiService = ApiService(http.Client());
  XFile? pickedFile;
  XFile? coverFile;
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
    gerCities();
  }

  Future<void> onChange() async {
    final currentpassword = currentpasswordController.value.text.trim();
    final newpassword = newpasswordController.value.text.trim();
    final confirmpassword = confirmpasswordController.value.text.trim();

    isLoading.value = true; // Start loading

    if (currentpassword.isEmpty || newpassword.isEmpty || confirmpassword.isEmpty) {
      await Future.delayed(const Duration(seconds: 1)); // Simulate loading for a brief moment
      isLoading.value = false; // Stop loading

      if (currentpassword.isEmpty) {
        showSnackBarError('Error', 'Current Password cannot be empty');
      } else if (newpassword.isEmpty) {
        showSnackBarError('Error', 'New Password cannot be empty');
      } else if (confirmpassword.isEmpty) {
        showSnackBarError('Error', 'Confirm Password cannot be empty');
      }
      return;
    }

    await changePassword();
    isLoading.value = false; // Stop loading after password change process is complete
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

  String formatPhoneNumber(String number) {
    String numericOnly = number.replaceAll(RegExp(r'[^0-9]'), '');
    return '+92$numericOnly';
  }

  void onSubmit() {
    String? whatsappError = validateWhatsppNumber(whatsappNoController.value.text);
    if (whatsappError != null) {
      showSnackBarError('Error', whatsappError);
      return; // Stop execution if there is an error
    }
    String? phoneError = validatePakistaniPhoneNumber(phoneNoController.value.text);
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

    print('JSON Response in gerCities: ${response.body}');

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

  String stripCountryCode(String phoneNumber) {
    // Regular expression to match the '+92' country code and any non-numeric characters
    RegExp regExp = RegExp(r'\+92|\D');

    // Replace the matched part with an empty string, effectively removing it
    return phoneNumber.replaceAll(regExp, '');
  }

  Future<void> autoFill() async {
    LoginResponse data = await box.read('user_data');
    print(data.toJson());
    // Use the stripCountryCode function to remove the country code
    String formattedPhone = stripCountryCode(data.user!.seller!.phone!);
    String formattedWhatsApp = stripCountryCode(data.user!.seller!.whatsapp!);

    nameController.value.text = data.user?.name ?? '';
    phoneNoController.value.text = formattedPhone;
    whatsappNoController.value.text = formattedWhatsApp;
    // businessNameController.value.text = data.user!.seller!.businessName!;
    businessAddressController.value.text = data.user!.seller!.businessAddress!;
    //facebookController.value.text = data.user!.seller!.facebookPage!;
    facebookController.value.text = data.user?.seller?.facebookPage ?? '';
    instagramController.value.text = data.user?.seller?.instaPage ?? '';
    webSiteController.value.text = data.user!.seller!.webUrl!;
    descriptionController.value.text = data.shop?.description ?? '';
    if (data.cityId != null) {
      selectedCity.value = City(id: data.cityId!, name: data.cityName ?? '');
      getAreas(data.cityId!);
      if (data.shop?.area != null) {
        selectedarea.value = City(id: data.shop!.area!, name: data.areaName ?? '');
      }
    }
  }

  Future<XFile?> pickImage() async {
    final newImage = await showImageDialog();
    if (newImage == null) return null;
    pickedFile = newImage;
    logoName.value = newImage.name;
    return newImage;
  }

  Future<XFile?> pickCoverImage() async {
    final newImage = await showImageDialog();
    if (newImage == null) return null;
    coverFile = newImage;
    coverLogoName.value = newImage.name;
    return newImage;
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
    final name = nameController.value.text.trim();
    final whatsappNoFormatted = formatPhoneNumber(whatsappNoController.value.text);
    final phoneNoFormatted = formatPhoneNumber(phoneNoController.value.text);
    final businessName = businessNameController.value.text.trim();
    final businessAddress = businessAddressController.value.text.trim();
    final facebook = facebookController.value.text.trim();
    final instagram = instagramController.value.text.trim();
    final website = webSiteController.value.text.trim();
    final description = descriptionController.value.text.trim();
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
      print('Request Fields: ${request.fields}');
      print('Request Headers: ${request.headers}');
      if (pickedFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'logo',
            pickedFile!.path,
          ),
        );
      }
      if (coverFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'coverimage',
            coverFile!.path,
          ),
        );
      }

      request.fields.addAll({
        'user_id': data.user!.id.toString(),
        'role': '2',
        'name': name,
        'phone': phoneNoFormatted,
        'whatsapp': whatsappNoFormatted,
        'business_address': businessAddress,
        'faecbook_page': facebook,
        'insta_page': instagram,
        'web_url': ensureHttps(website),
        'isFeatured': '1',
        'email': data.user?.email ?? '',
        'area_id': selectedarea.value?.id.toString() ?? data.shop?.area?.toString() ?? '0',
        'description': description.toString(),
      }); // Add the other fields to the request
      // Add the bearer token to the request headers
      request.headers['Authorization'] = 'Bearer $savedToken';
      final response = await http.Response.fromStream(
        await request.send(),
      ); // Send the request
      // http.StreamedResponse response = await request.send();
      print('JSON Response in registerUser: ${response.body}');

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

  Future<void> changePassword() async {
    LoginResponse data = await box.read('user_data');
    final savedToken = box.read('user_token');

    isLoading.value = true;
    const url = 'https://pinkad.pk/portal/api/seller/change_password';
    final current_password = currentpasswordController.value.text.trim();
    final new_password = newpasswordController.value.text.trim();
    final confirm_password = confirmpasswordController.value.text.trim();

    String ensureHttps(String url) {
      // Check if the URL already contains "http://" or "https://"
      if (url.startsWith('http://') || url.startsWith('https://')) {
        return url; // Already has http:// or https://, return as is
      } else {
        // Add "https://" to the beginning of the URL
        return 'https://$url';
      }
    }

    if (new_password != confirm_password) {
      // If new password and confirm password do not match, show a Snackbar
      showSnackBarError(
        'Error',
        'New password and confirm password do not match',
      );
      isLoading.value = false;
      return; // Exit the function early
    }

    if (current_password == new_password) {
      // If current password and new password are the same, show a Snackbar
      showSnackBarError(
        'Error',
        'New password cannot be same as old password',
      );
      isLoading.value = false;
      return; // Exit the function early
    }

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      ); // Create the multipart request
      print('Request Fields: ${request.fields}');
      print('Request Headers: ${request.headers}');

      request.fields.addAll({
        'user_id': data.user!.id.toString(),
        'current_password': current_password,
        'new_password': new_password,
        'confirm_password': confirm_password,
      }); // Add the other fields to the request
      // Add the bearer token to the request headers
      request.headers['Authorization'] = 'Bearer $savedToken';
      final response = await http.Response.fromStream(
        await request.send(),
      ); // Send the request
      // http.StreamedResponse response = await request.send();
      print('JSON Response in changing password: ${response.body}');

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
          showSnackBarSuccess(
            'Message',
            result['message'],
          );
        }
      } else if (response.statusCode == 401) {
        // Incorrect current password
        showSnackBarError(
          'Error',
          'Current password is incorrect',
        );
      } else {
        isLoading.value = false;
        // Error occurred
        print('Error occurred while changing password: ${response.statusCode}');
      }
    } catch (e) {
      isLoading.value = false;
      // Exception occurred
      print('Exception occurred while changing password: $e');
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
