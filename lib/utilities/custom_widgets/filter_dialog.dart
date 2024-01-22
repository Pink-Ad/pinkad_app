import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pink_ad/app/models/areas_model.dart';
import 'package:pink_ad/app/models/subcategory_model.dart';
import 'package:pink_ad/app/modules/splash/controllers/splash_controller.dart';
import 'package:pink_ad/utilities/colors/colors.dart';
import 'package:pink_ad/utilities/custom_widgets/custom_drop_down.dart';
import 'package:pink_ad/utilities/custom_widgets/text_utils.dart';
import 'package:pink_ad/utilities/functions/loading_wrapper.dart';
import 'package:pink_ad/utilities/functions/show_toast.dart';
import 'package:pink_ad/utilities/utils.dart';

class FilterDialog extends StatefulWidget {
  FilterDialog({super.key});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  Future<List<SubCategory>> subcatFuture = Get.find<SplashController>().getAllSubcategories();
  Future<List<Area>> areaFuture = Get.find<SplashController>().getAllAreas();
  List<SubCategory> selectedSubcats = [];
  List<Area> selectedAreas = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black45,
      child: Center(
        child: Container(
          width: 0.85.sw,
          // height: 0.21.sh,
          decoration: BoxDecoration(
            color: Get.theme.cardColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: kElevationToShadow[1],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // SvgPicture.asset("assets/svgIcons/dialog_icon.svg"),
                // SizedBox(
                //   height: 20.h,
                // ),
                Text(
                  'Filter Offers and Sellers',
                  style: CustomTextView.getStyle(
                    Get.context!,
                    colorLight: secondary,
                    fontSize: 20.sp,
                    fontFamily: Utils.poppinsBold,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Column(
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 0.3.sh),
                        child: CustomMultiDropdown<SubCategory>(
                          hintText: 'Sub Categories',
                          asyncItems: (p0) {
                            return subcatFuture;
                          },
                          onChanged: (subcats) {
                            print('on change');
                            selectedSubcats = subcats;
                          },
                          itemAsString: (val) => val.name ?? '',
                        ),
                      ),
                      10.horizontalSpace,
                      ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 0.3.sh),
                        child: CustomMultiDropdown<Area>(
                          hintText: 'Areas',
                          onChanged: (areas) {
                            print('on change');
                            selectedAreas = areas;
                          },
                          asyncItems: (p0) {
                            return areaFuture;
                          },
                          itemAsString: (val) => val.name ?? '',
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                  child: GestureDetector(
                    onTap: () async {
                      final box = GetStorage();
                      if (selectedSubcats.isEmpty || selectedAreas.isEmpty) {
                        showToast(message: 'Please select the filters');
                        return;
                      }
                      box.write('user_categories', selectedSubcats.map((e) => e.id ?? 0).toList());
                      box.write('user_areas', selectedAreas.map((e) => e.id ?? 0).toList());
                      final splashController = Get.find<SplashController>();
                      loadingWrapper(() async {
                        return Future.wait([
                          splashController.getFeaturedOffer(),
                          splashController.getFeaturedSeller(),
                        ]);
                      });
                    },
                    child: Container(
                      height: 50.0.h,
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Filter',
                          style: CustomTextView.getStyle(
                            Get.context!,
                            colorLight: Colors.white,
                            fontSize: 16.sp,
                            fontFamily: Utils.poppinsSemiBold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
