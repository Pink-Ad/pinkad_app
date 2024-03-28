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
  final Future<List<SubCategory>> subcatFuture = Get.find<SplashController>().getAllSubcategories();
  final Future<List<Area>> areaFuture = Get.find<SplashController>().getAllAreas();
  List<SubCategory> selectedSubcats = [];
  List<Area> selectedAreas = [];

  @override
  void initState() {
    super.initState();
    final box = GetStorage();
    final existingAreas = box.read<List>('user_areas')?.cast<int>();
    final existingSubcats = box.read<List>('user_categories')?.cast<int>();
    if (existingAreas?.isNotEmpty == true) {
      areaFuture.then((value) {
        selectedAreas = value.where((element) => existingAreas!.contains(element.id)).toList();
        setState(() {});
      });
    }
    if (existingSubcats?.isNotEmpty == true) {
      subcatFuture.then((value) {
        selectedSubcats = value.where((element) => existingSubcats!.contains(element.id)).toList();
        setState(() {});
      });
    }
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
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder(
              future: Future.wait([areaFuture, subcatFuture]),
              builder: (context, snapshot) {
                final loading = snapshot.connectionState == ConnectionState.waiting;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // SvgPicture.asset("assets/svgIcons/dialog_icon.svg"),
                    // SizedBox(
                    //   height: 20.h,
                    // ),
                    Text(
                      'Choose interest, city OR area to see better results.',
                      style: CustomTextView.getStyle(
                        Get.context!,
                        colorLight: secondary,
                        fontSize: 18.sp,
                        fontFamily: Utils.poppinsBold,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          children: [
                            ClipRect(
                              clipBehavior: Clip.antiAlias,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxHeight: 0.3.sh),
                                child: CustomMultiDropdown<SubCategory>(
                                  enabled: !loading,
                                  hintText: 'Interests',
                                  asyncItems: (p0) {
                                    return subcatFuture;
                                  },
                                  onChanged: (subcats) {
                                    selectedSubcats = subcats;
                                  },
                                  itemAsString: (val) => val.name ?? '',
                                  selectedItems: selectedSubcats,
                                ),
                              ),
                            ),
                            10.horizontalSpace,
                            ClipRect(
                              clipBehavior: Clip.antiAlias,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxHeight: 0.3.sh),
                                child: CustomMultiDropdown<Area>(
                                  enabled: !loading,
                                  hintText: 'City or Area',
                                  onChanged: (areas) {
                                    selectedAreas = areas;
                                  },
                                  asyncItems: (p0) {
                                    return areaFuture;
                                  },
                                  itemAsString: (val) => val.name ?? '',
                                  selectedItems: selectedAreas,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (loading) CircularProgressIndicator(color: primary),
                      ],
                    ),
                    15.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              Get.back();
                            },
                            child: Container(
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: tertiary,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Skip',
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
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              final box = GetStorage();
                              if (selectedSubcats.isEmpty != selectedAreas.isEmpty) {
                                showToast(message: 'Please select both filters');
                                return;
                              }
                              box.write('user_categories', selectedSubcats.map((e) => e.id ?? 0).toList());
                              box.write('user_areas', selectedAreas.map((e) => e.id ?? 0).toList());
                              final splashController = Get.find<SplashController>();
                              await loadingWrapper(() async {
                                return Future.wait([
                                  splashController.getFeaturedOffer(),
                                  splashController.getFeaturedSeller(),
                                ]);
                              });
                              Get.back();
                            },
                            child: Container(
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
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
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
