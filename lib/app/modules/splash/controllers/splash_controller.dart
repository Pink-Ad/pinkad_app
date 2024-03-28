import 'dart:async';
import 'dart:convert';

import 'package:app_links/app_links.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pink_ad/app/data/api_service.dart';
import 'package:pink_ad/app/models/areas_model.dart';
import 'package:pink_ad/app/models/banner_modal.dart';
import 'package:pink_ad/app/models/featured_seller_model.dart';
import 'package:pink_ad/app/models/login_response.dart';
import 'package:pink_ad/app/models/offer_list_model.dart';
import 'package:pink_ad/app/models/shop_list_model.dart';
import 'package:pink_ad/app/models/subcategory_model.dart';
import 'package:pink_ad/app/models/tutorial_model.dart';
import 'package:pink_ad/app/modules/home/views/bottom_nav_bar.dart';
import 'package:pink_ad/app/modules/user_dashboard/views/user_bottom_nav_bar.dart';
import 'package:pink_ad/app/routes/app_pages.dart';
import 'package:pink_ad/utilities/functions/show_toast.dart';

class SplashController extends GetxController {
  final box = GetStorage();
  var token;
  var email;
  List shopList = [].obs;
  List bannerList = [].obs;
  List tutorials = [].obs;
  List offerList = [].obs;
  List shopName = [].obs;
  List<FeaturedSeller> fSellerList = <FeaturedSeller>[].obs;
  var password;
  final ApiService _apiService = ApiService(http.Client());
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  void handleAppLink(Uri? uri) {
    if (uri != null && uri.host == 'app.pinkad.pk' && uri.pathSegments.isNotEmpty) {
      if (uri.pathSegments.first == 'email-verified') {
        showToast(message: 'Your account has been verified!');
      }
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await Future.wait([
      getShop(),
      getBanner(),
      getTopSeller(),
      getTopOffer(),
      getAllSeller(),
      getOffers(),
      getTutorial(),
      getFeaturedOffer(),
      getFeaturedSeller(),
    ]);

    // Subscribe to all events when app is started.
    // (Use allStringLinkStream to get it as [String])
    print('SplashController onInit');
    token = box.read('user_token');
    email = box.read('email');
    password = box.read('password');

    _appLinks = AppLinks();
    // Check initial link if app was in cold state (terminated)
    handleAppLink(await _appLinks.getInitialAppLink());

    // Handle link when app is in warm state (front or background)
    _linkSubscription = _appLinks.uriLinkStream.listen(handleAppLink);

    // Future.delayed(const Duration(milliseconds: 2));
    // Timer(const Duration(seconds: 8), () async {
    if (token != null) {
      try {
        Map data = {'email': email, 'password': password, 'role': '2'};

        final response = await _apiService.postData(
          Endpoints.login,
          data,
        );
        final result = json.decode(response.body);

        var loginResponseData = LoginResponse.fromJson(result);
        if (response.statusCode == 200) {
          if (loginResponseData.status == 'success') {
            final token = loginResponseData.authorisation!.token!;
            await getSellerShop(token);
            await box.write('user_data', loginResponseData);
            await box.write('user_token', token);
            // await box.write('user_type', 'seller'); // seller or guest
            if (box.read('user_type') != 'guest') {
              return Get.offAll(UserBottomNavBar());
            }
          }
        }
        // handle success response
      } catch (e) {
        if (e.toString() == 'Unauthorized') {
          await box.remove('user_token');
          await box.remove('email');
          await box.remove('password');
        }
        // return Get.offAll(BottomNavBar());
      }
    }
    Get.offAll(BottomNavBar());
    // Timer(
    //   const Duration(seconds: 3),
    //   () => Get.offAll(BottomNavBar()),
    // );
    // });
    // token = box.read('email');

    // Timer(
    //   const Duration(seconds: 3),
    //   () => Get.offNamed('/bottom-nav-bar'),
    // );
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  Future<void> getHomeData() async {
    await Future.wait([
      getFeaturedSeller(),
      getTopSeller(),
      getTopOffer(),
      getFeaturedOffer(),
    ]);
  }

  Future<void> getSellerShop(String token) async {
    try {
      final response = await _apiService.getDataWithHeader(Endpoints.sellerShop, token);

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        // List category =
        //     result.map((json) => SellerShop.fromJson(json)).toList();
        shopName.assignAll(result);
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

  Future<void> getBanner() async {
    try {
      final response = await _apiService.getData(Endpoints.banner);

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        // shopList = result.map((json) => ShopList.fromJson(json)).toList();
        bannerList.assignAll(result.map((json) => BannerModal.fromJson(json)).toList());
        await box.write('banner', bannerList);
      }
    } catch (e) {
      // isLoading.value = false;
      print(e);

      // showSnackBarError("Error", "Something went wrong please try again later");
    }
  }

  Future<void> getTutorial() async {
    try {
      final response = await _apiService.getData(Endpoints.tutorial);

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        // shopList = result.map((json) => ShopList.fromJson(json)).toList();
        tutorials.assignAll(result.map((json) => TutorialModal.fromJson(json)).toList());
        print(tutorials);
        await box.write('tutorial', tutorials);
      }
    } catch (e) {
      // isLoading.value = false;
      print(e);

      // showSnackBarError("Error", "Something went wrong please try again later");
    }
  }

  Future<List<SubCategory>> getAllSubcategories() async {
    final response = await _apiService.getData(Endpoints.subcategories);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return result.map<SubCategory>((subcat) => SubCategory.fromJson(subcat)).toList();
    } else {
      throw response;
    }
  }

  Future<List<Area>> getAllAreas() async {
    final response = await _apiService.getData(Endpoints.areas);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return result.map<Area>((subcat) => Area.fromJson(subcat)).toList();
    } else {
      throw response;
    }
  }

  Future<void> getFeaturedSeller() async {
    try {
      List<int> areaIds = box.read('user_areas')?.cast<int>() ?? [];
      if (areaIds.length > 0) {
        final url = '${Endpoints.sellerFilter}?${areaIds.map((id) => "area_id[]=${id}").join("&")}';
        final response = await _apiService.getData(url);
        if (response.statusCode == 200) {
          final result = json.decode(response.body);
          await box.write('fseller', result['sellers']);
        }
      } else {
        final response = await _apiService.getData(Endpoints.featureSeller);
        if (response.statusCode == 200) {
          final result = json.decode(response.body);
          await box.write('fseller', result['data']);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getAllSeller() async {
    try {
      final response = await _apiService.getData(Endpoints.getAllSeller);

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        await box.write('allSeller', result);
      }
    } catch (e, stacktrace) {
      print('Exception occurred: $e');
      print('Stacktrace: $stacktrace');
    }
  }

  Future<void> getFeaturedOffer() async {
    try {
      List<int> areaIds = box.read('user_areas')?.cast<int>() ?? [];
      List<int> subcatIds = box.read('user_categories')?.cast<int>() ?? [];
      if (areaIds.isNotEmpty || subcatIds.isNotEmpty) {
        final areaFilter = areaIds.map((id) => 'area_id[]=${id}');
        final subcatFilter = subcatIds.map((id) => 'category_id[]=${id}');
        final url = '${Endpoints.offerFilter}?${[...areaFilter, ...subcatFilter].join("&")}';
        final response = await _apiService.getData(url);
        if (response.statusCode == 200) {
          final result = json.decode(response.body);
          await box.write('fOffer', result['filtered_banner_posts']);
        }
      } else {
        final response = await _apiService.getData(Endpoints.featuredOffers);

        if (response.statusCode == 200) {
          final result = json.decode(response.body);
          await box.write('fOffer', result['data']);
        }
      }
    } catch (e, stacktrace) {
      // Print both the exception and the stack trace for debugging
      print('Exception occurred: $e');
      print('Stack trace: $stacktrace');

      // Optional: handle the error, e.g., show a user-friendly message
      // showSnackBarError("Error", "Something went wrong please try again later");
    }
  }

  Future<void> getTopSeller() async {
    try {
      final response = await _apiService.getData(Endpoints.topSeller);

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        // print(result['data'].length);
        // shopList = result.map((json) => ShopList.fromJson(json)).toList();
        // fSellerList.addAll(result
        //     .map((json) => FeaturedSeller.fromJson(json['data']))
        //     .toList());
        await box.write('topSeller', result['data']);
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

  Future<void> getShop() async {
    try {
      final response = await _apiService.getData(Endpoints.shop);

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        // shopList = result.map((json) => ShopList.fromJson(json)).toList();
        shopList.assignAll(result.map((json) => ShopList.fromJson(json)).toList());
        await box.write('shops', shopList);
      }
    } catch (e) {
      // isLoading.value = false;
      print(e);

      // showSnackBarError("Error", "Something went wrong please try again later");
    }
  }

  Future<void> getOffers() async {
    try {
      final response = await _apiService.getData(Endpoints.allOffers);

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        offerList.assignAll(result.map((json) => OfferList.fromJson(json)).toList());
        await box.write('offers', offerList);
      }
    } catch (e) {
      // isLoading.value = false;
      print(e);

      // showSnackBarError("Error", "Something went wrong please try again later");
    }
  }

  Future<void> guestLogin() async {
    final response = await _apiService.postData('${Endpoints.register}?role=3', null);
    final result = json.decode(response.body);

    var loginResponseData = LoginResponse.fromJson(result);
    if (response.statusCode == 200 && loginResponseData.status == 'success') {
      final token = loginResponseData.authorisation!.token!;
      box.write('user_data', loginResponseData);
      box.write('user_token', token);
      box.write('user_type', 'guest'); // seller or guest
      Get.offAllNamed(Routes.Bottom_Nav_Bar);
      // Get.dialog(FilterDialog());
      final sellerName = loginResponseData.user?.name;
      if (sellerName != null) {
        await box.write('seller_name', sellerName);
      }
    } else {
      showToast(message: loginResponseData.status ?? 'Login Error');
    }
  }

  @override
  void onReady() {
    super.onReady();
    print('SplashController onReady');
  }
}
