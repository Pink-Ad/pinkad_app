import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pink_ad/app/models/cites_model.dart';
import 'package:pink_ad/app/modules/upload_offer/controllers/upload_offer_controller.dart';
import 'package:pink_ad/utilities/colors/colors.dart';
import 'package:pink_ad/utilities/custom_widgets/text_utils.dart';
import 'package:pink_ad/utilities/functions/loading_wrapper.dart';

// ignore: must_be_immutable
class CategoriesDropDown extends GetView<UploadOfferController> {
  final List<String> options = ['Food', 'Other'];
  List<String> selectedOption = [];
  final List<City> salesmanList = [
    City(id: 1, name: 'nam'),
    City(id: 2, name: '2nd'),
  ];
  List<City> selectedSalesman = [];
  final RxBool showAnotherDropdown = false.obs;

  CategoriesDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // height: 50.h,
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
              items: controller.categoryName.value,
              itemAsString: (City u) => u.name,
              enabled: controller.categoryName.value.isNotEmpty ? true : false,
              dropdownDecoratorProps: DropDownDecoratorProps(
                baseStyle: CustomTextView.getStyle(
                  context,
                  colorLight: textColor,
                  fontSize: 15.sp,
                ),
                dropdownSearchDecoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Category',
                  hintStyle: CustomTextView.getStyle(
                    context,
                    colorLight: textColor,
                    fontSize: 15.sp,
                  ),
                ),
              ),
              onChanged: (value) async {
                controller.selectedCategory.value = value;
                controller.subCategoryName.clear();
                await loadingWrapper(
                  () => controller.getSubCategories(value!.id),
                );
                showAnotherDropdown.value = true;
              },
              // selectedItem: "Brazil",
            ),
            // child: DropDownMultiSelect(
            //   selected_values_style: CustomTextView.getStyle(context,
            //       colorLight: textColor, fontSize: 15.sp),
            //   onChanged: (List<String> value) {
            //     selectedOption = value;
            //     showAnotherDropdown.value = true;
            //     // setState(() {
            //     // });
            //   },
            //   // options: list,
            //   selectedValues: selectedOption,
            //   decoration:   InputDecoration(
            //     border: InputBorder.none,
            //   ),

            //   whenEmpty: 'Select category', options: options,
            // ),

            // child: DropdownButton(
            //   isExpanded: true,
            //   value: controller.selectedCategory.value,
            //   underline:   SizedBox(),
            //   hint: Text(
            //     'Select you Category',
            //     style: CustomTextView.getStyle(context,
            //         colorLight: textColor, fontSize: 15.sp),
            //   ),
            //   icon:   Icon(Icons.arrow_drop_down),
            //   items: [
            //     ...controller.categoryName.map((city) {
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

            //   // items: controller.citiesName
            //   //     .map((option) => DropdownMenuItem(
            //   //           value: option,
            //   //           child: Text(
            //   //             option.name,
            //   //             style: CustomTextView.getStyle(context,
            //   //                 colorLight: textColor, fontSize: 15.sp),
            //   //           ),
            //   //         ))
            //   //     .toList(),
            //   onChanged: (value) {
            //     // print(inspect());
            //     controller.selectedCategory.value = value;
            //     // controller.selectedarea.value = null;
            //     // controller.areaName.value = [];
            //     controller.getSubCategories(value!.id);
            //     //  controller.citiesName.value= selectedCity;
            //     showAnotherDropdown.value = true;
            //   },

            //   // onChanged: (value) {
            //   //   print(inspect(value));
            //   // controller.selectedCity(va);
            //   // if (value == 'Karachi') {
            //   // } else {
            //   //   showAnotherDropdown.value = false;
            //   // }
            //   // },
            // ),

            // DropdownButton(
            //   isExpanded: true,
            //   value: selectedOption.value,
            //   underline:   SizedBox(),
            //   icon:   Icon(Icons.arrow_drop_down),
            //   items: options
            //       .map((option) => DropdownMenuItem(
            //             value: option,
            //             child: Text(
            //               option,
            //               style: CustomTextView.getStyle(context,
            //                   colorLight: textColor, fontSize: 15.sp),
            //             ),
            //           ))
            //       .toList(),
            //   onChanged: (value) {
            //     selectedOption.value = value!;
            //     if (value == 'Food') {
            //       showAnotherDropdown.value = true;
            //     } else {
            //       showAnotherDropdown.value = false;
            //     }
            //   },
            // ),
          ),
          if (showAnotherDropdown.value)
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Container(
                key: ValueKey(selectedOption),
                // height: 50.h,
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
                child: DropdownSearch<City>.multiSelection(
                  // popupProps:   PopupProps.menu(
                  //     showSelectedItems: true, showSearchBox: true),
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
                    showSelectedItems: false,
                  ),
                  enabled: controller.subCategoryName.value.isNotEmpty ? true : false,
                  items: controller.subCategoryName.value,
                  itemAsString: (City u) => u.name,
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    baseStyle: CustomTextView.getStyle(
                      context,
                      colorLight: textColor,
                      fontSize: 15.sp,
                    ),
                    dropdownSearchDecoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Sub Category',
                      hintStyle: CustomTextView.getStyle(
                        context,
                        colorLight: textColor,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    controller.selectedSubCategory.value = [];
                    for (int i = 0; i < value.length; i++) {
                      controller.selectedSubCategory.value.add(value[i].id.toString());
                    }
                    print(controller.selectedSubCategory.value);
                  },
                  asyncItems: (val) async {
                    print('Search: $val');
                    if (controller.isFetching.isFalse) {
                      return controller.subCategoryName.toList();
                    }
                    final fetched = await controller.isFetching.stream.first;
                    return controller.subCategoryName.toList();
                  },
                  // selectedItem: "Brazil",
                ),

                // child: DropDownMultiSelect(
                //   selected_values_style: CustomTextView.getStyle(context,
                //       colorLight: textColor, fontSize: 15.sp),
                //   onChanged: (value) {
                //     // controller.selectedSubCategory.value = value;
                //     showAnotherDropdown.value = true;
                //   },
                //   // options: list,
                //   selectedValues: controller.selectedSubCategory.value,
                //   decoration:   InputDecoration(
                //     border: InputBorder.none,
                //   ),

                //   whenEmpty: 'Select sub-category',
                //   options: controller.subCategoryName.value,
                // ),
                // child: DropdownButton(
                //   isExpanded: true,
                //   value: selectedSalesman.value,
                //   underline:   SizedBox(),
                //   icon:   Icon(Icons.arrow_drop_down),
                //   items: salesmanList
                //       .map((option) => DropdownMenuItem(
                //             value: option,
                //             child: Text(
                //               option,
                //               style: CustomTextView.getStyle(context,
                //                   colorLight: textColor, fontSize: 15.sp),
                //             ),
                //           ))
                //       .toList(),
                //   onChanged: (value) {
                //     selectedSalesman.value = value!;
                //   },
                // ),
              ),
            ),
          // Container(
          //   // height: 50.h,
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
          //         offset:   Offset(0, 3),
          //       ),
          //     ],
          //   ),
          //   child: DropdownSearch<City>.multiSelection(
          //     // popupProps:   PopupProps.menu(
          //     //     showSelectedItems: true, showSearchBox: true),
          //     popupProps:   PopupPropsMultiSelection.menu(
          //       showSearchBox: true,
          //       showSelectedItems: false,
          //       searchFieldProps: TextFieldProps(
          //           decoration: InputDecoration(
          //         hintText: "Search",
          //       )),
          //     ),
          //     items: controller.shopName.value,
          //     itemAsString: (City u) => u.name,
          //     enabled: controller.shopName.value.length > 0 ? true : false,
          //     dropdownDecoratorProps:   DropDownDecoratorProps(
          //       baseStyle: TextStyle(
          //           color: textColor,
          //           fontSize: 18,
          //           fontWeight: FontWeight.w600),
          //       dropdownSearchDecoration: InputDecoration(
          //         border: InputBorder.none,
          //         hintText: "Shops",
          //       ),
          //     ),
          //     onChanged: (value) {
          //       controller.selectedShops.value = [];
          //       for (int i = 0; i < value.length; i++) {
          //         controller.selectedShops.value.add(value[i].id.toString());
          //       }
          //       print(controller.selectedShops.value);
          //       // controller.selectedCategory.value = value;
          //     },
          //     // selectedItem: "Brazil",
          //   ),
          // child: DropDownMultiSelect(
          //   selected_values_style: CustomTextView.getStyle(context,
          //       colorLight: textColor, fontSize: 15.sp),
          //   onChanged: (List<String> value) {
          //     selectedOption = value;
          //     showAnotherDropdown.value = true;
          //     // setState(() {
          //     // });
          //   },
          //   // options: list,
          //   selectedValues: selectedOption,
          //   decoration:   InputDecoration(
          //     border: InputBorder.none,
          //   ),

          //   whenEmpty: 'Select category', options: options,
          // ),

          // child: DropdownButton(
          //   isExpanded: true,
          //   value: controller.selectedCategory.value,
          //   underline:   SizedBox(),
          //   hint: Text(
          //     'Select you Category',
          //     style: CustomTextView.getStyle(context,
          //         colorLight: textColor, fontSize: 15.sp),
          //   ),
          //   icon:   Icon(Icons.arrow_drop_down),
          //   items: [
          //     ...controller.categoryName.map((city) {
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

          //   // items: controller.citiesName
          //   //     .map((option) => DropdownMenuItem(
          //   //           value: option,
          //   //           child: Text(
          //   //             option.name,
          //   //             style: CustomTextView.getStyle(context,
          //   //                 colorLight: textColor, fontSize: 15.sp),
          //   //           ),
          //   //         ))
          //   //     .toList(),
          //   onChanged: (value) {
          //     // print(inspect());
          //     controller.selectedCategory.value = value;
          //     // controller.selectedarea.value = null;
          //     // controller.areaName.value = [];
          //     controller.getSubCategories(value!.id);
          //     //  controller.citiesName.value= selectedCity;
          //     showAnotherDropdown.value = true;
          //   },

          //   // onChanged: (value) {
          //   //   print(inspect(value));
          //   // controller.selectedCity(va);
          //   // if (value == 'Karachi') {
          //   // } else {
          //   //   showAnotherDropdown.value = false;
          //   // }
          //   // },
          // ),

          // DropdownButton(
          //   isExpanded: true,
          //   value: selectedOption.value,
          //   underline:   SizedBox(),
          //   icon:   Icon(Icons.arrow_drop_down),
          //   items: options
          //       .map((option) => DropdownMenuItem(
          //             value: option,
          //             child: Text(
          //               option,
          //               style: CustomTextView.getStyle(context,
          //                   colorLight: textColor, fontSize: 15.sp),
          //             ),
          //           ))
          //       .toList(),
          //   onChanged: (value) {
          //     selectedOption.value = value!;
          //     if (value == 'Food') {
          //       showAnotherDropdown.value = true;
          //     } else {
          //       showAnotherDropdown.value = false;
          //     }
          //   },
          // ),
          // ),
        ],
      ),
    );
  }
}

Widget _customPopupItemBuilderExample2(
  BuildContext context,
  City item,
  bool isSelected,
) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8),
    decoration: !isSelected
        ? null
        : BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
    child: ListTile(
      selected: isSelected,
      title: Text(item.name),
      subtitle: Text(item.id.toString()),
      // leading: CircleAvatar(
      //   backgroundImage: NetworkImage(item.avatar),
      // ),
    ),
  );
}
