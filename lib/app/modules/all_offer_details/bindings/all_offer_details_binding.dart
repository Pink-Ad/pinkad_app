import 'package:get/get.dart';

import '../controllers/all_offer_details_controller.dart';

class AllOfferDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllOfferDetailsController>(
      () => AllOfferDetailsController(),
    );
  }
}
