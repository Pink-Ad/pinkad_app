import 'package:get/get.dart';

import '../controllers/user_login_controller.dart';

class UserLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserLoginController>(
      () => UserLoginController(),
    );
  }
}
