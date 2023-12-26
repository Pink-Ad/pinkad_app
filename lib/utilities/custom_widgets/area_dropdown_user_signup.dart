import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pink_ad/app/models/cites_model.dart';
import 'package:pink_ad/app/modules/chat_inbox/controllers/chat_inbox_controller.dart';
import 'package:pink_ad/utilities/custom_widgets/text_utils.dart';
import 'package:pink_ad/utilities/functions/loading_wrapper.dart';

import '../colors/colors.dart';

class AreaDropDownUserSignup extends GetView<ChatInboxController> {
  ChatInboxController chatInboxController = ChatInboxController();
  // final List<String> options = controller.temp;
  final RxString selectedOption = 'Select your city'.obs;
  final List<String> salesmanList = [
    'Select Area',
    'North Karachi',
    'South Karachi',
  ];
  final RxString selectedSalesman = 'Select Area'.obs;
  final RxBool showAnotherDropdown = true.obs;

  AreaDropDownUserSignup({super.key});

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
                  offset: Offset(0, 3),
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
              items: controller.citiesName.value,
              itemAsString: (City u) => u.name,
              enabled: controller.citiesName.value.length > 0 ? true : false,
              dropdownDecoratorProps: DropDownDecoratorProps(
                baseStyle: CustomTextView.getStyle(
                  context,
                  colorLight: textColor,
                  fontSize: 15.sp,
                ),
                dropdownSearchDecoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Select you City',
                  hintStyle: CustomTextView.getStyle(
                    context,
                    colorLight: textColor,
                    fontSize: 15.sp,
                  ),
                ),
              ),
              onChanged: (value) async {
                controller.selectedCity.value = value;
                controller.selectedarea.value = null;
                controller.areaName.value = [];
                await loadingWrapper(() => controller.getAreas(value!.id));
              },
            ),
          ),
          if (showAnotherDropdown.value)
            AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              child: Container(
                key: ValueKey(controller.selectedCity.value),
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
                        hintText: 'Search',
                        hintStyle: CustomTextView.getStyle(
                          context,
                          colorLight: textColor,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                  ),
                  items: controller.areaName.value,
                  itemAsString: (City u) => u.name,
                  enabled: controller.areaName.value.length > 0 ? true : false,
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    baseStyle: CustomTextView.getStyle(
                      context,
                      colorLight: textColor,
                      fontSize: 15.sp,
                    ),
                    dropdownSearchDecoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Select you Area',
                      hintStyle: CustomTextView.getStyle(
                        context,
                        colorLight: textColor,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    controller.setAreaId(value!);
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
