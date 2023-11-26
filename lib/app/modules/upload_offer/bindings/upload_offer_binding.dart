import 'package:get/get.dart';

import '../controllers/upload_offer_controller.dart';

class UploadOfferBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UploadOfferController>(
      () => UploadOfferController(),
    );
  }
}
