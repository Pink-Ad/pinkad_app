import 'package:get/get.dart';
import 'package:pink_ad/app/modules/premier_features/controllers/premier_features_controller.dart';
import 'package:pink_ad/app/modules/upload_offer/controllers/upload_offer_controller.dart';
import 'package:pink_ad/app/modules/user_profile/controllers/user_profile_controller.dart';

import '../../user_dashboard/controllers/user_dashboard_controller.dart';
import '../controllers/splash_controller.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    print('SplashBinding dependencies');
    Get.lazyPut<SplashController>(() => SplashController());
    Get.lazyPut<UserProfileController>(() => UserProfileController());
    Get.lazyPut<UploadOfferController>(() => UploadOfferController());
    Get.lazyPut<PremierFeaturesController>(() => PremierFeaturesController());
    Get.lazyPut<UserDashboardController>(() => UserDashboardController());
  }
}
