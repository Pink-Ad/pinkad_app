import 'package:get/get.dart';

import '../controllers/specific_seller_controllers.dart';

class SpecificSellerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpecificSellerController>(
      () => SpecificSellerController(),
    );
  }
}
