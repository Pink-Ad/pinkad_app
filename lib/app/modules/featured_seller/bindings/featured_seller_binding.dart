import 'package:get/get.dart';

import '../controllers/featured_seller_controller.dart';

class FeaturedSellerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeaturedSellerController>(
      () => FeaturedSellerController(),
    );
  }
}
