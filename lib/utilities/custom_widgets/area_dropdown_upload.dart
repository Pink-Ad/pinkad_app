import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pink_ad/app/models/cites_model.dart';
import 'package:pink_ad/app/modules/upload_offer/controllers/upload_offer_controller.dart';
import 'package:pink_ad/utilities/custom_widgets/text_utils.dart';
import 'package:pink_ad/utilities/functions/loading_wrapper.dart';

import '../colors/colors.dart';

class AreaDropDownUpload extends GetView<UploadOfferController> {
  // final List<String> options = controller.temp;
  final RxString selectedOption = 'Select your city'.obs;
  final List<String> salesmanList = [
    'Select Area',
    'North Karachi',
    'South Karachi',
  ];
  final RxString selectedSalesman = 'Select Area'.obs;
  final RxBool showAnotherDropdown = true.obs;

  final City selectAll = City(id: -1, name: 'Select All');

  AreaDropDownUpload({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50.h,
            width: Get.width,
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            padding: EdgeInsets.only(
              left: 20.0.w,
              right: 20.w,
              top: 5.h,
              bottom: 5.h,
            ),
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
                    hintText: 'Search',
                    hintStyle: CustomTextView.getStyle(
                      context,
                      colorLight: textColor,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ),
              items: controller.citiesName.value,
              itemAsString: (City u) => u.name,
              // enabled: controller.citiesName.value.length > 0 ? true : false,
              dropdownDecoratorProps: DropDownDecoratorProps(
                baseStyle: CustomTextView.getStyle(
                  context,
                  colorLight: textColor,
                  fontSize: 15.sp,
                ),
                dropdownSearchDecoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Select Targeted City',
                  hintStyle: CustomTextView.getStyle(
                    context,
                    colorLight: textColor,
                    fontSize: 15.sp,
                  ),
                ),
              ),
              onChanged: (value) async {
                controller.selectedCity.value = value;
                controller.selectedarea.clear();
                controller.areaName.value = [];
                await loadingWrapper(() => controller.getAreas(value!.id));
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
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                padding: EdgeInsets.only(
                  left: 10.w,
                  right: 10.w,
                  top: 5.h,
                  bottom: 5.h,
                ),
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
                // child: GetBuilder<UploadOfferController>(
                //   builder: (controller) {
                //     print(controller.selectedAreas);
                //     return IgnorePointer(
                //       ignoring: controller.areaOptions.isEmpty,
                //       child: MultiSelectDropDown<int>(
                //         controller: controller.areaController,
                //         selectedOptions: controller.selectedAreas,
                //         onOptionSelected: (newSelections) {
                //           // final areaController = controller.areaController;
                //           controller.selectedAreas = [controller.selectAll];
                //           controller.update();
                //           // final selectedAreas = controller.selectedAreas;
                //           // print('option selected');
                //           // print(newSelections.map((e) => e.label));
                //           // print(selectedAreas.map((e) => e.label));
                //           // final ids = Set();
                //           // newSelections..retainWhere((x) => ids.add(x.value));
                //           // final allSelectedBefore = controller.selectedAreas.any((area) => area.value == controller.selectAll.value);
                //           // final allSelectedAfter = newSelections.any((area) => area.value == controller.selectAll.value);
                //           // if (allSelectedBefore && !allSelectedAfter) {
                //           //   print('clearing all');
                //           //   selectedAreas.clear();
                //           //   // areaController.clearAllSelection();
                //           // } else if (!allSelectedBefore && allSelectedAfter) {
                //           //   print('selecting all');
                //           //   controller.selectedAreas = controller.areaOptions;
                //           //   controller.selectedAreas.add(controller.selectAll);
                //           //   // areaController.setSelectedOptions(controller.areaOptions + [controller.selectAll]);
                //           // } else {
                //           //   controller.selectedAreas = newSelections;
                //           //   if (!allSelectedBefore && newSelections.length == controller.areaOptions.length) {
                //           //     selectedAreas.add(controller.selectAll);
                //           //     // areaController.addSelectedOption(controller.selectAll);
                //           //   } else if (allSelectedBefore && newSelections.length < controller.areaOptions.length) {
                //           //     selectedAreas.remove(controller.selectAll);
                //           //     // areaController.clearSelection(controller.selectAll);
                //           //   }
                //           // }
                //           // controller.update();
                //         },
                //         options: [controller.selectAll, ...controller.areaOptions],
                //         selectionType: SelectionType.multi,
                //         chipConfig: const ChipConfig(
                //           wrapType: WrapType.wrap,
                //           runSpacing: -10,
                //           spacing: 0,
                //           backgroundColor: primary,
                //         ),
                //         showClearIcon: false,
                //         dropdownHeight: 300,
                //         optionTextStyle: const TextStyle(fontSize: 16),
                //         selectedOptionIcon: const Icon(
                //           Icons.check_circle,
                //           color: primary,
                //         ),
                //         selectedOptionBackgroundColor: primary.withOpacity(0.1),
                //         borderColor: Colors.transparent,
                //         suffixIcon: Icon(Icons.arrow_drop_down, color: controller.areaName.isEmpty ? textColor : null),
                //         searchEnabled: true,
                //         hintStyle: CustomTextView.getStyle(
                //           context,
                //           colorLight: textColor,
                //           fontSize: 15.sp,
                //         ),
                //         padding: EdgeInsets.only(right: 20.w),
                //       ),
                //     );
                //   },
                // ),
                child: DropdownSearch<City>.multiSelection(
                  popupProps: PopupPropsMultiSelection.menu(
                    showSearchBox: true,
                    searchFieldProps: TextFieldProps(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: CustomTextView.getStyle(
                          context,
                          colorLight: textColor,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                    // onItemAdded: (value, addedItem) {
                    //   if (addedItem.id == -1) {
                    //     controller.selectedarea.value = controller.areaName.toList();
                    //     controller.selectedarea.add(addedItem);
                    //   } else {
                    //     final ids = Set();
                    //     value..retainWhere((x) => ids.add(x.id));
                    //     controller.selectedarea.value = value;
                    //   }
                    //   controller.update();
                    // },
                    // onItemRemoved: (value, removedItem) {
                    //   if (removedItem.id == -1) {
                    //     controller.selectedarea.clear();
                    //   } else {
                    //     final ids = Set();
                    //     value..retainWhere((x) => ids.add(x.id));
                    //     controller.selectedarea.value = value;
                    //   }
                    //   controller.update();
                    // },
                  ),
                  enabled: controller.areaName.isNotEmpty ? true : false,
                  items: [selectAll, ...controller.areaName],
                  itemAsString: (City u) => u.name,
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    baseStyle: CustomTextView.getStyle(
                      context,
                      colorLight: textColor,
                      fontSize: 15.sp,
                    ),
                    dropdownSearchDecoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Select Targeted Area',
                      hintStyle: CustomTextView.getStyle(
                        context,
                        colorLight: textColor,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                  dropdownBuilder: (BuildContext context, List<City>? selectedItems) {
                    // If 'Select All' is selected or the number of selected items equals the total number of areas
                    if (selectedItems != null && selectedItems.any((item) => item.id == -1)) {
                      // Display "All areas"
                      return const Text('All areas');
                    } else if (selectedItems != null && selectedItems.isNotEmpty) {
                      // If there are some but not all areas selected, show the selected area names separated by commas
                      return Text(
                        selectedItems.map((city) => city.name).join(', '),
                      );
                    } else {
                      // When nothing is selected, show a placeholder
                      return const Text('No area selected');
                    }
                  },
                  compareFn: (item1, item2) => item1.id == item2.id,
                  onChanged: (List<City>? value) {
                    final ids = Set();
                    value?..retainWhere((x) => ids.add(x.id));
                    if (value != null) {
                      // Check if the 'Select All' option is part of the selection.
                      if (value.any((area) => area.id == -1)) {
                        // If 'Select All' is selected, add all the areas to selectedarea.
                        controller.selectedarea.value = controller.areaName.toList();
                        // Also, make sure to add 'Select All' option itself to the list
                        controller.selectedarea.add(selectAll);
                      } else {
                        // If 'Select All' is not selected, set the selectedarea to the current value.
                        controller.selectedarea.value = value;
                      }
                    } else {
                      // If the selection is cleared, also clear the selectedarea.
                      controller.selectedarea.clear();
                    }
                    // This call updates the UI based on the new state of the selected items.
                    controller.update();
                  },
                  selectedItems: controller.selectedarea.toList(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
