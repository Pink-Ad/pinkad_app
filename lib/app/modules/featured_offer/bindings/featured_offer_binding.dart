import 'package:get/get.dart';

import '../controllers/featured_offer_controller.dart';

class FeaturedOfferBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeaturedOfferController>(
      () => FeaturedOfferController(),
    );
  }
}
