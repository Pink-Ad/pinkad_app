import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pink_ad/app/models/cites_model.dart';
import 'package:pink_ad/app/modules/upload_offer/controllers/upload_offer_controller.dart';
import 'package:pink_ad/utilities/custom_widgets/text_utils.dart';

import '../colors/colors.dart';

class AreaDropDownUpload extends GetView<UploadOfferController> {
  // final List<String> options = controller.temp;
  final RxString selectedOption = 'Select your city'.obs;
  final List<String> salesmanList = [
    'Select Area',
    'North Karachi',
    'South Karachi'
  ];
  final RxString selectedSalesman = 'Select Area'.obs;
  final RxBool showAnotherDropdown = true.obs;

  final List<City> allAreas = [
    City(id: -1, name: 'Select All'),
  ];

  AreaDropDownUpload({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50.h,
              width: Get.width,
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              padding: EdgeInsets.only(
                  left: 20.0.w, right: 20.w, top: 5.h, bottom: 5.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: DropdownSearch<City>(
                // popupProps:   PopupProps.menu(
                //     showSelectedItems: true, showSearchBox: true),
                popupProps: PopupPropsMultiSelection.menu(
                  showSearchBox: true,
                  showSelectedItems: false,
                  searchFieldProps: TextFieldProps(
                      decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: CustomTextView.getStyle(context,
                              colorLight: textColor, fontSize: 15.sp))),
                ),
                items: controller.citiesName.value,
                itemAsString: (City u) => u.name,
                // enabled: controller.citiesName.value.length > 0 ? true : false,
                dropdownDecoratorProps: DropDownDecoratorProps(
                  baseStyle: CustomTextView.getStyle(context,
                      colorLight: textColor, fontSize: 15.sp),
                  dropdownSearchDecoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Select Targeted City",
                      hintStyle: CustomTextView.getStyle(context,
                          colorLight: textColor, fontSize: 15.sp)),
                ),
                onChanged: (value) {
                  controller.selectedCity.value = value;
                  controller.selectedarea.value.clear();
                  controller.areaName.value = [];
                  controller.getAreas(value!.id);
                },
                // selectedItem: "Brazil",
              ),
            ),
            if (showAnotherDropdown.value)
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Container(
                  key: ValueKey(controller.selectedCity.value),
                  // height: 50.h,
                  width: Get.width,
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  padding: EdgeInsets.only(
                      left: 20.0.w, right: 20.w, top: 5.h, bottom: 5.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: DropdownSearch<City>.multiSelection(
                    popupProps: PopupPropsMultiSelection.menu(
                      showSearchBox: true,
                      searchFieldProps: TextFieldProps(
                        decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: CustomTextView.getStyle(context,
                              colorLight: textColor, fontSize: 15.sp),
                        ),
                      ),
                      showSelectedItems: false,
                    ),
                    enabled:
                        controller.areaName.value.isNotEmpty ? true : false,
                    items: [City(id: -1, name: 'Select All')] +
                        controller.areaName.value,
                    itemAsString: (City u) => u.name,
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      baseStyle: CustomTextView.getStyle(context,
                          colorLight: textColor, fontSize: 15.sp),
                      dropdownSearchDecoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Select Targeted Area",
                        hintStyle: CustomTextView.getStyle(context,
                            colorLight: textColor, fontSize: 15.sp),
                      ),
                    ),
                    dropdownBuilder:
                        (BuildContext context, List<City>? selectedItems) {
                      // If 'Select All' is selected or the number of selected items equals the total number of areas
                      if (selectedItems != null &&
                          selectedItems.any((item) => item.id == -1)) {
                        // Display "All areas"
                        return const Text('All areas');
                      } else if (selectedItems != null &&
                          selectedItems.isNotEmpty) {
                        // If there are some but not all areas selected, show the selected area names separated by commas
                        return Text(
                            selectedItems.map((city) => city.name).join(', '));
                      } else {
                        // When nothing is selected, show a placeholder
                        return const Text('No area selected');
                      }
                    },
                    onChanged: (List<City>? value) {
                      if (value != null) {
                        // Check if the 'Select All' option is part of the selection.
                        if (value.any((city) => city.id == -1)) {
                          // If 'Select All' is selected, add all the areas to selectedarea.
                          controller.selectedarea.value =
                              List<City>.from(controller.areaName.value);
                          // Also, make sure to add 'Select All' option itself to the list
                          if (!controller.selectedarea.contains(allAreas[0])) {
                            controller.selectedarea.add(allAreas[0]);
                          }
                        } else {
                          // If 'Select All' is not selected, set the selectedarea to the current value.
                          controller.selectedarea.value =
                              List<City>.from(value);
                          // Optionally, if 'Select All' is deselected, remove it from the list.
                          controller.selectedarea.remove(allAreas[0]);
                        }
                      } else {
                        // If the selection is cleared, also clear the selectedarea.
                        controller.selectedarea.clear();
                      }
                      // This call updates the UI based on the new state of the selected items.
                      controller.update();
                    },
                    selectedItems: controller.selectedarea,
                  ),
                ),
              )
          ],
        ));
  }
}
