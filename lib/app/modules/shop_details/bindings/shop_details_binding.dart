import 'package:get/get.dart';

import '../controllers/shop_details_controller.dart';

class ShopDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShopDetailsController>(
      () => ShopDetailsController(),
    );
  }
}
