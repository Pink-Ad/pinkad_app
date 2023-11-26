import 'package:get/get.dart';

import '../controllers/all_shops_controller.dart';

class AllShopsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllShopsController>(
      () => AllShopsController(),
    );
  }
}
