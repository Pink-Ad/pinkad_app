import 'package:get/get.dart';

import '../controllers/active_package_details_controller.dart';

class ActivePackageDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActivePackageDetailsController>(
      () => ActivePackageDetailsController(),
    );
  }
}
