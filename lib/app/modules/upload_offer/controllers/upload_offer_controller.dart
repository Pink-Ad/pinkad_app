import 'dart:convert';
import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:pink_ad/app/data/api_service.dart';
import 'package:pink_ad/app/models/category_model.dart';
import 'package:pink_ad/app/models/cites_model.dart';
import 'package:pink_ad/app/models/login_response.dart';
import 'package:pink_ad/app/models/subcategory_model.dart';
import 'package:pink_ad/app/modules/home/controllers/home_controller.dart';
import 'package:pink_ad/app/modules/splash/controllers/splash_controller.dart';
import 'package:pink_ad/utilities/colors/colors.dart';
import 'package:pink_ad/utilities/functions/show_image_dialog.dart';
import 'package:pink_ad/utilities/utils.dart';

import '../../../../utilities/custom_widgets/snackbars.dart';
import '../../../../utilities/custom_widgets/text_utils.dart';
import '../../../routes/app_pages.dart';

class UploadOfferController extends GetxController {
  HomeController homeController = Get.put(HomeController());
  var switchValue = false.obs;
  final ApiService _apiService = ApiService(http.Client());
  SplashController splashController = Get.find<SplashController>();
  var activeColor = Colors.white.obs;
  final titleController = TextEditingController().obs;
  final hashtagController = TextEditingController().obs;

  final descriptionController = TextEditingController().obs;
  final RxString imageName = RxString('');
  List offerList = [].obs;

  RxList<City> categoryName = <City>[].obs;
  RxList<City> shopName = <City>[].obs;
  Rx<City?> selectedCategory = Rx<City?>(null);
  RxList<City> subCategoryName = <City>[].obs;
  RxList selectedSubCategory = [].obs;
  RxList selectedShops = [].obs;
  RxList<City> provinceName = <City>[].obs;
  Rx<City?> selectedProvince = Rx<City?>(null);
  var emailVerified;
  XFile? pickedFile;
  final inputImage = Image.asset('assets/images/title.png');
  var isLoading = false.obs;
  var isFetching = false.obs;
  final box = GetStorage();
  List temp = [];

  @override
  void onInit() {
    super.onInit();
    getData();
    getCategories();
  }

  void toggleSwitchValue() {
    switchValue.toggle();
  }

  Future<void> getCategories() async {
    try {
      final response = await _apiService.getData(Endpoints.category);
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        List category = result.map((json) => Category.fromJson(json)).toList();
        for (var city in category) {
          categoryName.add(City(id: city?.id, name: city?.name));
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getSubCategories(int id) async {
    try {
      isFetching.value = true;
      final response = await _apiService.getData('subcategory?cat_id=$id');
      print(inspect(response.body));
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        List subCategory = result.map((json) => SubCategory.fromJson(json)).toList();
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
    } finally {
      isFetching.value = false;
    }
  }

  Future<XFile?> pickImage() async {
    final newImage = await showImageDialog();
    if (newImage == null) return null;
    pickedFile = newImage;
    imageName.value = newImage.name;
    return newImage;
  }

  Future<void> uploadOffers() async {
    if (await _canCreateOffer()) {
      if (titleController.value.text.isEmpty) {
        showSnackBarError('Error', 'Title field cannot be empty');
        homeController.setLoading(); // Reset loading state
      } else if (descriptionController.value.text.isEmpty) {
        showSnackBarError('Error', 'Description field cannot be empty');
        homeController.setLoading(); // Reset loading state
      } else if (selectedSubCategory.isEmpty) {
        showSnackBarError('Error', 'Sub-Category field cannot be empty');
        homeController.setLoading(); // Reset loading state
      } else {
        getModel();
      }
    } else {
      homeController.setLoading(); // Reset loading state
    }
  }

  Future<bool> _canCreateOffer() async {
    int offersCreatedToday = await _getOffersCreatedToday();
    if (offersCreatedToday >= 4) {
      showSnackBarError('Limit Reached', 'Cannot create more than 4 offers per day');
      return false;
    }

    int totalOffersCreated = await _getTotalOffersCreated();
    if (totalOffersCreated >= 50) {
      showSnackBarError('Limit Reached', 'Cannot create more than 50 offers in total, delete some offers to create new ones.');
      return false;
    }

    return true;
  }

  Future<int> _getOffersCreatedToday() async {
    final box = GetStorage();
    final today = DateTime.now().toString().split(' ')[0];
    List<dynamic>? offers = box.read('offers_created_today');

    if (offers != null) {
      offers = offers.where((offer) => offer['date'] == today).toList();
      return offers.length;
    }

    return 0;
  }

  Future<int> _getTotalOffersCreated() async {
    final box = GetStorage();
    List<dynamic>? offers = box.read('offers_created_today');
    return offers?.length ?? 0;
  }

  Future<void> _recordNewOffer() async {
    final box = GetStorage();
    final today = DateTime.now().toString().split(' ')[0];
    List<dynamic>? offers = box.read('offers_created_today');

    if (offers == null) {
      offers = [];
    }

    offers.add({'date': today, 'timestamp': DateTime.now().millisecondsSinceEpoch});
    box.write('offers_created_today', offers);
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
              'You want to upload this offer?',
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

  Future<void> getData() async {
    LoginResponse data = await box.read('user_data');
    emailVerified = data.user!.emailVerifiedAt;
  }

  Future<void> getModel() async {
    const url = ApiService.modelBaseUrl + Endpoints.aiModel;
    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        pickedFile!.path,
      ),
    );
    final response = await http.Response.fromStream(
      await request.send(),
    );
    final res = json.decode(response.body);
    uploadData(res['prediction']);
  }

  Future<void> uploadData(predction) async {
    final savedToken = box.read('user_token');
    final shopid = await box.read('selectedShop');
    isLoading.value = true;
    const url = '${ApiService.baseUrl}/create/offer';
    final titleValue = titleController.value.text.trim();
    final descriptionValue = descriptionController.value.text.trim();

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );
      request.files.add(
        await http.MultipartFile.fromPath(
          'banner',
          pickedFile!.path,
        ),
      );

      request.fields.addAll({
        'title': titleValue,
        'IsFeature': '1',
        'description': descriptionValue,
        'category_id': selectedCategory.value!.id.toString(),
        'shop_id[0]': shopid.toString(),
        'gender': predction.toString(),
      });
      selectedSubCategory.value.asMap().forEach(
            (index, value) => request.fields.addAll({
              'subcat_id[$index]': selectedSubCategory.value[index].toString(),
            }),
          );

      request.headers['Authorization'] = 'Bearer $savedToken';

      final response = await http.Response.fromStream(
        await request.send(),
      );

      if (response.statusCode == 200) {
        splashController.getOffers();
        _recordNewOffer(); // Record the new offer creation
        isLoading.value = false;
        titleController.value.clear();
        hashtagController.value.clear();
        descriptionController.value.clear();
        pickedFile = null;
        imageName.value = '';
        switchValue.value = true;
        selectedSubCategory.value = [];
        selectedShops.value = [];
        selectedProvince.value = null;
        selectedCategory.value = null;
        Get.offAllNamed(Routes.User_Bottom_Nav_Bar);
        showSnackBarSuccess(
          'Message',
          'Your offer has been uploaded successfully. kindly go to dashboard to check status.',
        );
        homeController.setLoading();
      } else {
        homeController.setLoading();
        isLoading.value = false;
        print(
          'Error occurred while upload offer: Status Code: ${response.statusCode}\nError: ${response.body}',
        );
      }
    } catch (e) {
      homeController.setLoading();
      isLoading.value = false;
      print('Exception occurred while registering user: $e');
    }
  }
}


// class UploadOfferController extends GetxController {
//   HomeController homeController = Get.put(HomeController());
//   var switchValue = false.obs;
//   final ApiService _apiService = ApiService(http.Client());
//   SplashController splashController = Get.find<SplashController>();
//   var activeColor = Colors.white.obs;
//   final titleController = TextEditingController().obs;
//   final hashtagController = TextEditingController().obs;

//   final descriptionController = TextEditingController().obs;
//   final RxString imageName = RxString('');
//   List offerList = [].obs;

//   RxList<City> categoryName = <City>[].obs;
//   RxList<City> shopName = <City>[].obs;
//   Rx<City?> selectedCategory = Rx<City?>(null);
//   RxList<City> subCategoryName = <City>[].obs;
//   RxList selectedSubCategory = [].obs;
//   RxList selectedShops = [].obs;
//   RxList<City> provinceName = <City>[].obs;
//   Rx<City?> selectedProvince = Rx<City?>(null);
//   var emailVerified;
//   XFile? pickedFile;
//   final inputImage = Image.asset('assets/images/title.png');
//   var isLoading = false.obs;
//   var isFetching = false.obs;
//   final box = GetStorage();
//   List temp = [];

//   @override
//   void onInit() {
//     super.onInit();
//     getData();
//     getCategories();
//   }

//   void toggleSwitchValue() {
//     switchValue.toggle();
//   }

//   Future<void> getCategories() async {
//     try {
//       final response = await _apiService.getData(Endpoints.category);
//       if (response.statusCode == 200) {
//         final result = json.decode(response.body);
//         List category = result.map((json) => Category.fromJson(json)).toList();
//         for (var city in category) {
//           categoryName.add(City(id: city?.id, name: city?.name));
//         }
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<void> getSubCategories(int id) async {
//     try {
//       isFetching.value = true;
//       final response = await _apiService.getData('subcategory?cat_id=$id');
//       print(inspect(response.body));
//       if (response.statusCode == 200) {
//         final result = json.decode(response.body);
//         List subCategory = result.map((json) => SubCategory.fromJson(json)).toList();
//         for (var city in subCategory) {
//           subCategoryName.add(City(id: city?.id, name: city?.name));
//         }
//       } else {
//         // showSnackBarError(
//         //     "Error", "Something went wrong please try again later");
//       }
//       print(subCategoryName[0].name);
//     } catch (e) {
//       // isLoading.value = false;
//       print(e);

//       // showSnackBarError("Error", "Something went wrong please try again later");
//     } finally {
//       isFetching.value = false;
//     }
//   }

//   Future<XFile?> pickImage() async {
//     final newImage = await showImageDialog();
//     if (newImage == null) return null;
//     pickedFile = newImage;
//     imageName.value = newImage.name;
//     return newImage;
//   }

//   Future<void> uploadOffers() async {
//     if (await _canCreateOffer()) {
//       if (titleController.value.text.isEmpty) {
//         showSnackBarError('Error', 'Title field cannot be empty');
//         homeController.setLoading(); // Reset loading state
//       } else if (descriptionController.value.text.isEmpty) {
//         showSnackBarError('Error', 'Description field cannot be empty');
//         homeController.setLoading(); // Reset loading state
//       } else if (selectedSubCategory.isEmpty) {
//         showSnackBarError('Error', 'Sub-Category field cannot be empty');
//         homeController.setLoading(); // Reset loading state
//       } else {
//         getModel();
//       }
//     } else {
//       showSnackBarError('Limit Reached', 'Cannot create more than 4 offers per day');
//       homeController.setLoading(); // Reset loading state
//     }
//   }

//   Future<bool> _canCreateOffer() async {
//     int offersCreatedToday = await _getOffersCreatedToday();
//     return offersCreatedToday < 4;
//   }

//   Future<int> _getOffersCreatedToday() async {
//     final box = GetStorage();
//     final today = DateTime.now().toString().split(' ')[0];
//     List<dynamic>? offers = box.read('offers_created_today');

//     if (offers != null) {
//       offers = offers.where((offer) => offer['date'] == today).toList();
//       return offers.length;
//     }

//     return 0;
//   }

//   Future<void> _recordNewOffer() async {
//     final box = GetStorage();
//     final today = DateTime.now().toString().split(' ')[0];
//     List<dynamic>? offers = box.read('offers_created_today');

//     if (offers == null) {
//       offers = [];
//     }

//     offers.add({'date': today, 'timestamp': DateTime.now().millisecondsSinceEpoch});
//     box.write('offers_created_today', offers);
//   }

//   void showAwesomeDialog() {
//     AwesomeDialog(
//       dialogType: DialogType.noHeader,
//       context: Get.overlayContext!,
//       animType: AnimType.scale,
//       btnOkColor: secondary,
//       padding: EdgeInsets.symmetric(vertical: 10.h),
//       btnCancelColor: bodyTextColor,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             'Are you sure?',
//             style: CustomTextView.getStyle(
//               Get.context!,
//               colorLight: secondary,
//               fontSize: 20.sp,
//               fontFamily: Utils.poppinsBold,
//             ),
//           ),
//           SizedBox(height: 15.h),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: Text(
//               'You want to upload this offer?',
//               textAlign: TextAlign.center,
//               style: CustomTextView.getStyle(
//                 Get.context!,
//                 colorLight: textColor,
//                 fontSize: 14.sp,
//               ),
//             ),
//           ),
//           SizedBox(height: 20.h),
//         ],
//       ),
//       btnOk: GestureDetector(
//         onTap: () {
//           homeController.setLoading();
//           uploadOffers();
//           Get.back();
//         },
//         child: Container(
//           width: 138.0.w,
//           height: 50.0.h,
//           decoration: BoxDecoration(
//             color: secondary,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Center(
//             child: Text(
//               'Upload',
//               style: CustomTextView.getStyle(
//                 Get.context!,
//                 colorLight: Colors.white,
//                 fontSize: 16.sp,
//                 fontFamily: Utils.poppinsMedium,
//               ),
//             ),
//           ),
//         ),
//       ),
//       btnCancel: GestureDetector(
//         onTap: () {
//           Get.back();
//         },
//         child: Container(
//           width: 138.0.w,
//           height: 50.0.h,
//           decoration: BoxDecoration(
//             color: bodyTextColor,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Center(
//             child: Text(
//               'Cancel',
//               style: CustomTextView.getStyle(
//                 Get.context!,
//                 colorLight: Colors.white,
//                 fontSize: 16.sp,
//                 fontFamily: Utils.poppinsMedium,
//               ),
//             ),
//           ),
//         ),
//       ),
//     ).show();
//   }

//   Future<void> getData() async {
//     LoginResponse data = await box.read('user_data');
//     emailVerified = data.user!.emailVerifiedAt;
//   }

//   Future<void> getModel() async {
//     const url = ApiService.modelBaseUrl + Endpoints.aiModel;
//     final request = http.MultipartRequest('POST', Uri.parse(url));
//     request.files.add(
//       await http.MultipartFile.fromPath(
//         'file',
//         pickedFile!.path,
//       ),
//     );
//     final response = await http.Response.fromStream(
//       await request.send(),
//     );
//     final res = json.decode(response.body);
//     uploadData(res['prediction']);
//   }

//   Future<void> uploadData(predction) async {
//     final savedToken = box.read('user_token');
//     final shopid = await box.read('selectedShop');
//     isLoading.value = true;
//     const url = '${ApiService.baseUrl}/create/offer';
//     final titleValue = titleController.value.text.trim();
//     final descriptionValue = descriptionController.value.text.trim();

//     try {
//       final request = http.MultipartRequest(
//         'POST',
//         Uri.parse(url),
//       );
//       request.files.add(
//         await http.MultipartFile.fromPath(
//           'banner',
//           pickedFile!.path,
//         ),
//       );

//       request.fields.addAll({
//         'title': titleValue,
//         'IsFeature': '1',
//         'description': descriptionValue,
//         'category_id': selectedCategory.value!.id.toString(),
//         'shop_id[0]': shopid.toString(),
//         'gender': predction.toString(),
//       });
//       selectedSubCategory.value.asMap().forEach(
//             (index, value) => request.fields.addAll({
//               'subcat_id[$index]': selectedSubCategory.value[index].toString(),
//             }),
//           );

//       request.headers['Authorization'] = 'Bearer $savedToken';

//       final response = await http.Response.fromStream(
//         await request.send(),
//       );

//       if (response.statusCode == 200) {
//         splashController.getOffers();
//         _recordNewOffer(); // Record the new offer creation
//         isLoading.value = false;
//         titleController.value.clear();
//         hashtagController.value.clear();
//         descriptionController.value.clear();
//         pickedFile = null;
//         imageName.value = '';
//         switchValue.value = true;
//         selectedSubCategory.value = [];
//         selectedShops.value = [];
//         selectedProvince.value = null;
//         selectedCategory.value = null;
//         Get.offAllNamed(Routes.User_Bottom_Nav_Bar);
//         showSnackBarSuccess(
//           'Message',
//           'Your offer has been uploaded successfully. kindly go to dashboard to check status.',
//         );
//         homeController.setLoading();
//       } else {
//         homeController.setLoading();
//         isLoading.value = false;
//         print(
//           'Error occurred while upload offer: Status Code: ${response.statusCode}\nError: ${response.body}',
//         );
//       }
//     } catch (e) {
//       homeController.setLoading();
//       isLoading.value = false;
//       print('Exception occurred while registering user: $e');
//     }
//   }
// }
