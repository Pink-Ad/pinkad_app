import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pink_ad/app/models/cites_model.dart';
import 'package:pink_ad/utilities/custom_widgets/text_utils.dart';

import '../colors/colors.dart';

class AreaDropDown extends StatelessWidget {
  // final List<String> options = controller.temp;
  final RxString selectedOption = 'Select your city'.obs;
  final List<String> salesmanList = [
    'Select Area',
    'North Karachi',
    'South Karachi',
  ];
  final RxString selectedSalesman = 'Select Area'.obs;
  final RxBool showAnotherDropdown = true.obs;

  final void Function(City?)? onCityChanged;
  final void Function(City?)? onAreaChanged;
  final List<City> cities;
  final List<City> areas;
  final City? selectedCity;
  final City? selectedArea;

  AreaDropDown({
    this.onAreaChanged,
    this.onCityChanged,
    required this.cities,
    required this.areas,
    this.selectedCity,
    this.selectedArea,
    super.key,
  });

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
              items: cities,
              itemAsString: (City u) => u.name,
              compareFn: (city1, city2) => city1.id == city2.id,
              enabled: cities.isNotEmpty ? true : false,
              dropdownDecoratorProps: DropDownDecoratorProps(
                baseStyle: CustomTextView.getStyle(
                  context,
                  colorLight: textColor,
                  fontSize: 15.sp,
                ),
                dropdownSearchDecoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Select your City',
                  hintStyle: CustomTextView.getStyle(
                    context,
                    colorLight: textColor,
                    fontSize: 15.sp,
                  ),
                ),
              ),
              onChanged: (value) {
                onCityChanged?.call(value);
              },
              selectedItem: selectedCity,
            ),
          ),
          if (showAnotherDropdown.value)
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Container(
                // key: ValueKey(controller.selectedCity.value),
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
                  items: areas,
                  itemAsString: (City u) => u.name,
                  enabled: areas.isNotEmpty ? true : false,
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    baseStyle: CustomTextView.getStyle(
                      context,
                      colorLight: textColor,
                      fontSize: 15.sp,
                    ),
                    dropdownSearchDecoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Select your Area',
                      hintStyle: CustomTextView.getStyle(
                        context,
                        colorLight: textColor,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    onAreaChanged?.call(value);
                  },
                  selectedItem: selectedArea,
                ),
                // child: DropdownButton(
                //   isExpanded: true,
                //   value: controller.selectedarea.value,
                //   underline:   SizedBox(),
                //   icon:   Icon(Icons.arrow_drop_down),
                //   hint: Text(
                //     'Select you Area',
                //     style: CustomTextView.getStyle(context,
                //         colorLight: textColor, fontSize: 15.sp),
                //   ),
                //   items: controller.areaName.map((area) {
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
                //     controller.selectedarea.value = value;
                //   },
                // ),
              ),
            ),
        ],
      ),
    );
  }
}
