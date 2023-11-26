import 'package:get/get.dart';

import '../controllers/active_packages_controller.dart';

class ActivePackagesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActivePackagesController>(
      () => ActivePackagesController(),
    );
  }
}
