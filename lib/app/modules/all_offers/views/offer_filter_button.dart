import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pink_ad/app/models/areas_model.dart';
import 'package:pink_ad/app/models/subcategory_model.dart';
import 'package:pink_ad/app/modules/all_offers/controllers/all_offers_controller.dart';
import 'package:pink_ad/utilities/colors/colors.dart';
import 'package:pink_ad/utilities/custom_widgets/custom_drop_down.dart';
import 'package:pink_ad/utilities/custom_widgets/text_utils.dart';
import 'package:pink_ad/utilities/functions/loading_wrapper.dart';
import 'package:pink_ad/utilities/utils.dart';

class OfferFilterButton extends StatelessWidget {
  const OfferFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.filter_list,
        color: Colors.black,
        size: 30,
      ),
      onPressed: () {
        Get.find<AllOffersController>().showOfferFilterDialog(context);
      },
    );
  }
}

class OfferFilterOverlay extends StatefulWidget {
  const OfferFilterOverlay({super.key});

  @override
  State<OfferFilterOverlay> createState() => _OfferFilterOverlayState();
}

class _OfferFilterOverlayState extends State<OfferFilterOverlay> {
  late List<Area> areas;
  late List<SubCategory> subcats;

  @override
  void initState() {
    super.initState();
    areas = Get.find<AllOffersController>().selectedAreas;
    subcats = Get.find<AllOffersController>().selectedSubcats;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: primary,
      borderRadius: BorderRadius.circular(16.0),
      child: GetBuilder<AllOffersController>(
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                ClipRect(
                  clipBehavior: Clip.antiAlias,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 0.3.sh),
                    child: CustomMultiDropdown<SubCategory>(
                      hintText: 'Interests',
                      asyncItems: (p0) {
                        return controller.subcatFuture;
                      },
                      onChanged: (newSubcats) {
                        subcats = newSubcats;
                      },
                      itemAsString: (val) => val.name ?? '',
                      selectedItems: subcats,
                    ),
                  ),
                ),
                10.horizontalSpace,
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
                        onTap: () => loadingWrapper(() => controller.filterOffers(areas, subcats)),
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
