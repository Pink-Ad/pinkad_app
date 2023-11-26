import 'package:get/get.dart';

import '../controllers/all_offers_controller.dart';

class AllOffersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllOffersController>(
      () => AllOffersController(),
    );
  }
}
