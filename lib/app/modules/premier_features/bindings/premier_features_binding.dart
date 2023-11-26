import 'package:get/get.dart';

import '../controllers/premier_features_controller.dart';

class PremierFeaturesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PremierFeaturesController>(
      () => PremierFeaturesController(),
    );
  }
}
