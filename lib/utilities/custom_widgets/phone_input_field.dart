import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pink_ad/utilities/colors/colors.dart';
import 'package:pink_ad/utilities/custom_widgets/text_utils.dart';

class PakistaniPhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Only digits are allowed.
    String digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    String formattedText = '';

    // Apply a dash after the 3rd digit if there are more digits following.
    if (digitsOnly.length > 3) {
      formattedText =
          '${digitsOnly.substring(0, 3)}-${digitsOnly.substring(3)}';
    } else {
      formattedText = digitsOnly;
    }

    // Ensure the formatted text isn't longer than the max allowed.
    if (formattedText.length > 12) {
      formattedText = formattedText.substring(0, 12);
    }

    int cursorIndex = newValue.selection.end;
    // Adjust the cursor index for the dash.
    if (formattedText.length > 3 && cursorIndex == 4) {
      cursorIndex++;
    }

    // Ensure the cursor index isn't out of bounds.
    if (cursorIndex < 0) {
      cursorIndex = 0;
    } else if (cursorIndex > formattedText.length) {
      cursorIndex = formattedText.length;
    }

    // Re-create a TextSelection, ensuring it's within the bounds of the formatted text.
    TextSelection newSelection = newValue.selection.copyWith(
      baseOffset: cursorIndex,
      extentOffset: cursorIndex,
    );

    return TextEditingValue(
      text: formattedText,
      selection: newSelection,
    );
  }
}

class CustomPhoneInputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final TextInputAction textInputAction;
  final Function(String) onFieldSubmitted;
  final String prefixText;
  final Function(String)? validator;
  final String? iconName;

  CustomPhoneInputField({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.hintText,
    required this.textInputAction,
    required this.onFieldSubmitted,
    this.prefixText = '+92',
    this.iconName,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0.h,
      margin: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 10.h,
      ),
      padding: EdgeInsets.only(
        left: 20.0.w,
        right: 5.w,
        top: 4.h,
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
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/svgIcons/${iconName}.svg',
          ),
          Expanded(
            child: TextFormField(
              controller: controller,
              focusNode: focusNode,
              textInputAction: textInputAction,
              onFieldSubmitted: onFieldSubmitted,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                PakistaniPhoneInputFormatter(),
                LengthLimitingTextInputFormatter(11),
              ],
              decoration: InputDecoration(
                labelText: hintText,
                labelStyle: CustomTextView.getStyle(
                  context,
                  colorLight: textColor,
                  fontSize: 14.5.sp,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                prefixIcon: Padding(
                  padding: EdgeInsets.fromLTRB(
                    10.w,
                    8.h,
                    4.w,
                    10.h,
                  ),
                  child: Text(
                    prefixText,
                    style: CustomTextView.getStyle(
                      context,
                      colorLight: textColor,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
                prefixIconConstraints: BoxConstraints(
                  minWidth: 0,
                  minHeight: 0,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 2.h),
              ),
              style: CustomTextView.getStyle(
                context,
                colorLight: textColor,
                fontSize: 15.sp,
              ),
              validator: validator as String? Function(String?)?,
            ),
          ),
        ],
      ),
    );
  }
}
