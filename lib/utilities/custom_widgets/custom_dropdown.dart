import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pink_ad/app/models/cites_model.dart';
import 'package:pink_ad/app/modules/signup/controllers/signup_controller.dart';
import 'package:pink_ad/utilities/custom_widgets/text_utils.dart';

import '../colors/colors.dart';

class MyDropdown extends GetView<SignupController> {
  final List<String> options = ['How you got PinkAd', 'By Salesman', 'Other'];
  final List<String> salesmanList = ['Select Salesman', 'Akbar', 'Shahid'];
  // final RxString selectedSalesman = 'Select Salesman'.obs;
  final RxBool showAnotherDropdown = false.obs;

  MyDropdown({super.key});

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
              child: DropdownButton(
                isExpanded: true,
                value: controller.selectedOption.value,
                underline: const SizedBox(),
                icon: const Icon(Icons.arrow_drop_down),
                items: options
                    .map((option) => DropdownMenuItem(
                          value: option,
                          child: Text(
                            option,
                            style: CustomTextView.getStyle(context,
                                colorLight: textColor, fontSize: 15.sp),
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  print(value);
                  controller.selectedOption.value = value!;
                  controller.selectedSalesman.value = null;
                  if (controller.selectedOption.value == 'By Salesman') {
                    print(showAnotherDropdown.value);
                    showAnotherDropdown.value = true;
                  } else {
                    showAnotherDropdown.value = false;
                  }
                },
              ),
            ),
            if (controller.selectedOption.value == 'By Salesman')
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Container(
                  key: ValueKey(controller.selectedOption.value),
                  height: 50.h,
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
                  child: DropdownSearch<City>(
                    // popupProps: const PopupProps.menu(
                    //     showSelectedItems: true, showSearchBox: true),
                    popupProps: const PopupPropsMultiSelection.menu(
                      showSearchBox: true,
                      showSelectedItems: false,
                      searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(
                        hintText: "Search",
                      )),
                    ),
                    items: controller.salesmanName.value,
                    itemAsString: (City u) => u.name,
                    enabled:
                        controller.salesmanName.value.isNotEmpty ? true : false,
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      baseStyle: CustomTextView.getStyle(context,
                          colorLight: textColor, fontSize: 15.sp),
                      dropdownSearchDecoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Select Salesman",
                        hintStyle: CustomTextView.getStyle(context,
                            colorLight: textColor, fontSize: 15.sp),
                      ),
                    ),
                    onChanged: (value) {
                      controller.selectedSalesman.value = value;
                    },
                    // selectedItem: "Brazil",
                  ),
                  // child: DropdownButton(
                  //   isExpanded: true,
                  //   value: controller.selectedSalesman.value,
                  //   underline: const SizedBox(),
                  //   icon: const Icon(Icons.arrow_drop_down),
                  //   hint: Text(
                  //     'Select Salesman',
                  //     style: CustomTextView.getStyle(context,
                  //         colorLight: textColor, fontSize: 15.sp),
                  //   ),
                  //   items: controller.salesmanName.map((area) {
                  //     return DropdownMenuItem<City?>(
                  //       value: area,
                  //       child: Text(
                  //         area.name,
                  //         style: CustomTextView.getStyle(context,
                  //             colorLight: textColor, fontSize: 15.sp),
                  //       ),
                  //     );
                  //   }).toList(),
                  //   onChanged: (value) {
                  //     controller.selectedSalesman.value = value;
                  //     print(controller.selectedSalesman.value?.name);
                  //   },
                  // ),
                ),
              )
          ],
        ));
  }
}
