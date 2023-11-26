import 'package:get/get.dart';

import '../controllers/add_shop_controller.dart';

class AddShopBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddShopController>(
      () => AddShopController(),
    );
  }
}
