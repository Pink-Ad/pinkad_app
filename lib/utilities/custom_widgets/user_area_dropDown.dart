import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pink_ad/app/models/cites_model.dart';
import 'package:pink_ad/app/modules/signup/controllers/signup_controller.dart';
import 'package:pink_ad/app/modules/user_profile/controllers/user_profile_controller.dart';
import 'package:pink_ad/utilities/custom_widgets/text_utils.dart';

import '../colors/colors.dart';

class UserAreaDropDown extends GetView<UserProfileController> {
  // final List<String> options = controller.temp;
  final RxString selectedOption = 'Select your city'.obs;
  final List<String> salesmanList = [
    'Select Area',
    'North Karachi',
    'South Karachi'
  ];
  final RxString selectedSalesman = 'Select Area'.obs;
  final RxBool showAnotherDropdown = true.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   height: 50.h,
            //   width: Get.width,
            //   margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            //   padding: EdgeInsets.only(
            //       left: 20.0.w, right: 20.w, top: 5.h, bottom: 5.h),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(8.0),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.grey.withOpacity(0.5),
            //         spreadRadius: 0,
            //         blurRadius: 5,
            //         offset: Offset(0, 3),
            //       ),
            //     ],
            //   ),
            //   child: DropdownSearch<City>(
            //     // popupProps:   PopupProps.menu(
            //     //     showSelectedItems: true, showSearchBox: true),
            //     popupProps: PopupPropsMultiSelection.menu(
            //       showSearchBox: true,
            //       showSelectedItems: false,
            //       searchFieldProps: TextFieldProps(
            //           decoration: InputDecoration(
            //         hintText: "Search",
            //         hintStyle: CustomTextView.getStyle(context,
            //             colorLight: textColor, fontSize: 15.sp),
            //       )),
            //     ),
            //     items: controller.provinceName.value,
            //     itemAsString: (City u) => u.name,
            //     // enabled: controller.citiesName.value.length > 0 ? true : false,
            //     dropdownDecoratorProps: DropDownDecoratorProps(
            //       baseStyle: CustomTextView.getStyle(context,
            //           colorLight: textColor, fontSize: 15.sp),
            //       dropdownSearchDecoration: InputDecoration(
            //         border: InputBorder.none,
            //         hintText: "Select you Province",
            //         hintStyle: CustomTextView.getStyle(context,
            //             colorLight: textColor, fontSize: 15.sp),
            //       ),
            //     ),
            //     onChanged: (value) {
            //       controller.selectedProvince.value = value;
            //       controller.selectedCity.value = null;
            //       controller.citiesName.value = [];
            //       controller.gerCities();
            //     },
            //     // selectedItem: "Brazil",
            //   ),
            //   // child: DropdownButton(
            //   //   isExpanded: true,
            //   //   value: controller.selectedCity.value,
            //   //   underline:   SizedBox(),
            //   //   hint: Text(
            //   //     'Select you City',
            //   //     style: CustomTextView.getStyle(context,
            //   //         colorLight: textColor, fontSize: 15.sp),
            //   //   ),
            //   //   icon:   Icon(Icons.arrow_drop_down),
            //   //   items: [
            //   //     ...controller.citiesName.map((city) {
            //   //       return DropdownMenuItem<City?>(
            //   //         value: city,
            //   //         child: Text(
            //   //           city.name,
            //   //           style: CustomTextView.getStyle(context,
            //   //               colorLight: textColor, fontSize: 15.sp),
            //   //         ),
            //   //       );
            //   //     }).toList(),
            //   //   ],
            //   //   onChanged: (value) {
            //   //     controller.selectedCity.value = value;
            //   //     controller.selectedarea.value = null;
            //   //     controller.areaName.value = [];
            //   //     controller.getAreas(value!.id);
            //   //   },
            //   // ),
            // ),

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
                    offset: Offset(0, 3),
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
                        colorLight: textColor, fontSize: 15.sp),
                  )),
                ),
                items: controller.citiesName.value,
                itemAsString: (City u) => u.name,
                enabled: controller.citiesName.value.length > 0 ? true : false,
                dropdownDecoratorProps: DropDownDecoratorProps(
                  baseStyle: CustomTextView.getStyle(context,
                      colorLight: textColor, fontSize: 15.sp),
                  dropdownSearchDecoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Select you City",
                    hintStyle: CustomTextView.getStyle(context,
                        colorLight: textColor, fontSize: 15.sp),
                  ),
                ),
                onChanged: (value) {
                  controller.selectedCity.value = value;
                  controller.selectedarea.value = null;
                  controller.areaName.value = [];
                  controller.getAreas(value!.id);
                },
                // selectedItem: "Brazil",
              ),
              // child: DropdownButton(
              //   isExpanded: true,
              //   value: controller.selectedCity.value,
              //   underline:   SizedBox(),
              //   hint: Text(
              //     'Select you City',
              //     style: CustomTextView.getStyle(context,
              //         colorLight: textColor, fontSize: 15.sp),
              //   ),
              //   icon:   Icon(Icons.arrow_drop_down),
              //   items: [
              //     ...controller.citiesName.map((city) {
              //       return DropdownMenuItem<City?>(
              //         value: city,
              //         child: Text(
              //           city.name,
              //           style: CustomTextView.getStyle(context,
              //               colorLight: textColor, fontSize: 15.sp),
              //         ),
              //       );
              //     }).toList(),
              //   ],
              //   onChanged: (value) {
              //     controller.selectedCity.value = value;
              //     controller.selectedarea.value = null;
              //     controller.areaName.value = [];
              //     controller.getAreas(value!.id);
              //   },
              // ),
            ),
            if (showAnotherDropdown.value)
              AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                child: Container(
                  key: ValueKey(controller.selectedCity.value),
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
                        offset: Offset(0, 3),
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
                            colorLight: textColor, fontSize: 15.sp),
                      )),
                    ),
                    items: controller.areaName.value,
                    itemAsString: (City u) => u.name,
                    enabled:
                        controller.areaName.value.length > 0 ? true : false,
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      baseStyle: CustomTextView.getStyle(context,
                          colorLight: textColor, fontSize: 15.sp),
                      dropdownSearchDecoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Select you Area",
                        hintStyle: CustomTextView.getStyle(context,
                            colorLight: textColor, fontSize: 15.sp),
                      ),
                    ),
                    onChanged: (value) {
                      controller.selectedarea.value = value;
                    },
                    // selectedItem: "Brazil",
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
              )
          ],
        ));
  }
}
