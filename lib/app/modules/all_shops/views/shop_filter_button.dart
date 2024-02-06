import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pink_ad/app/models/areas_model.dart';
import 'package:pink_ad/app/modules/all_offers/controllers/all_offers_controller.dart';
import 'package:pink_ad/app/modules/all_shops/controllers/all_shops_controller.dart';
import 'package:pink_ad/utilities/colors/colors.dart';
import 'package:pink_ad/utilities/custom_widgets/custom_drop_down.dart';
import 'package:pink_ad/utilities/custom_widgets/text_utils.dart';
import 'package:pink_ad/utilities/functions/loading_wrapper.dart';
import 'package:pink_ad/utilities/utils.dart';

class ShopFilterButton extends StatelessWidget {
  const ShopFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.filter_list,
        color: Colors.black,
        size: 30,
      ),
      onPressed: () {
        Get.find<AllShopsController>().showShopFilterDialog(context);
      },
    );
  }
}

class ShopFilterOverlay extends StatefulWidget {
  const ShopFilterOverlay({super.key});

  @override
  State<ShopFilterOverlay> createState() => _ShopFilterOverlayState();
}

class _ShopFilterOverlayState extends State<ShopFilterOverlay> {
  late List<Area> areas;

  @override
  void initState() {
    super.initState();
    areas = Get.find<AllOffersController>().selectedAreas;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: primary,
      borderRadius: BorderRadius.circular(16.0),
      child: GetBuilder<AllShopsController>(
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                ClipRect(
                  clipBehavior: Clip.antiAlias,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 0.3.sh),
                    child: CustomMultiDropdown<Area>(
                      hintText: 'City or Area',
                      onChanged: (newAreas) {
                        areas = newAreas;
                      },
                      asyncItems: (p0) {
                        return controller.areaFuture;
                      },
                      itemAsString: (val) => val.name ?? '',
                      selectedItems: areas,
                    ),
                  ),
                ),
                10.verticalSpace,
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          controller.clearFilters();
                          Get.back();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Clear',
                            style: CustomTextView.getStyle(
                              Get.context!,
                              colorLight: primary,
                              fontSize: 16.sp,
                              fontFamily: Utils.poppinsSemiBold,
                            ),
                          ),
                        ),
                      ),
                      10.horizontalSpace,
                      GestureDetector(
                        onTap: () => loadingWrapper(() => controller.filterShops(areas)),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Filter',
                            style: CustomTextView.getStyle(
                              Get.context!,
                              colorLight: primary,
                              fontSize: 16.sp,
                              fontFamily: Utils.poppinsSemiBold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
