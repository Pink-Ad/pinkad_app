import 'package:get/get.dart';
import 'package:pink_ad/app/modules/sub_categories/controllers/sub_categories_controller.dart';

class SubCategoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubCategoryController>(
      () => SubCategoryController(),
    );
  }
}
