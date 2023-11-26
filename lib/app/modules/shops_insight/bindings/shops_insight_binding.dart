import 'package:get/get.dart';

import '../controllers/shops_insight_controller.dart';

class ShopsInsightBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShopsInsightController>(
      () => ShopsInsightController(),
    );
  }
}
