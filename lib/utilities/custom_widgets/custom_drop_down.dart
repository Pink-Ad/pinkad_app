import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_ad/utilities/colors/colors.dart';
import 'package:pink_ad/utilities/custom_widgets/text_utils.dart';

class CustomMultiDropdown<T> extends StatelessWidget {
  final bool enabled;
  final String? hintText;
  final Future<List<T>> Function(String)? asyncItems;
  final Function(List<T>)? onChanged;
  final String Function(T)? itemAsString;
  const CustomMultiDropdown({
    super.key,
    this.enabled = true,
    this.hintText,
    this.asyncItems,
    this.onChanged,
    this.itemAsString,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
      padding: EdgeInsets.all(5.w),
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
      child: DropdownSearch<T>.multiSelection(
        popupProps: PopupPropsMultiSelection.menu(
          searchDelay: Duration.zero,
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
        enabled: enabled,
        itemAsString: itemAsString,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: CustomTextView.getStyle(
            context,
            colorLight: textColor,
            fontSize: 15.sp,
          ),
          dropdownSearchDecoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: CustomTextView.getStyle(
              context,
              colorLight: textColor,
              fontSize: 15.sp,
            ),
          ),
        ),
        onChanged: onChanged,
        asyncItems: asyncItems,
      ),
    );
  }
}
