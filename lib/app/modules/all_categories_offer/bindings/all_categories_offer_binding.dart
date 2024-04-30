import 'package:get/get.dart';
import 'package:pink_ad/app/modules/all_categories_offer/controllers/all_categories_offer_controller.dart';


class AllCategoryOffersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllCategoryOffersController>(
      () => AllCategoryOffersController(),
    );
  }
}
