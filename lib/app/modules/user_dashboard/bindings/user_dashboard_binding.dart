import 'package:get/get.dart';

import '../controllers/user_dashboard_controller.dart';

class UserDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserDashboardController>(
      () => UserDashboardController(),
    );
  }
}
