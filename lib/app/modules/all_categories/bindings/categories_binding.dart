import 'package:get/get.dart';
import 'package:pink_ad/app/modules/all_categories/controllers/categories_controller.dart';

class CategoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoriesController>(
      () => CategoriesController(),
    );
  }
}
