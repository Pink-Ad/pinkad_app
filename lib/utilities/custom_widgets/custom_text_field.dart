import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pink_ad/utilities/custom_widgets/text_utils.dart';

import '../colors/colors.dart';

class ShadowedTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefixIcon;
  final IconButton? suffixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final FocusNode? focusNode;
  double? height = 50.0.h;
  final List<TextInputFormatter>? textInputFormatter;
  final void Function(String)? onFieldSubmitted;
  final String? errorText;
  final EdgeInsetsGeometry? contentPadding;
  final String? iconName;

  final void Function(String)? onChanged;

  ShadowedTextField({
    Key? key,
    this.controller,
    this.focusNode,
    this.onFieldSubmitted,
    this.textInputFormatter,
    this.hintText,
    this.prefixIcon,
    this.keyboardType,
    this.height,
    this.obscureText = false,
    this.errorText,
    this.iconName,
    this.suffixIcon,
    this.contentPadding,
    this.onChanged,
  }) : super(key: key);

  @override
  State<ShadowedTextField> createState() => _ShadowedTextFieldState();
}

class _ShadowedTextFieldState extends State<ShadowedTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      padding: EdgeInsets.only(left: 20.0.w, right: 5.w, top: 5.h, bottom: 5.h),
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
            "assets/svgIcons/${widget.iconName}.svg",
          ),
          SizedBox(
            width: 15.w,
          ),
          Expanded(
            child: TextFormField(
              focusNode: widget.focusNode,
              inputFormatters: widget.textInputFormatter,
              onFieldSubmitted: widget.onFieldSubmitted,
              controller: widget.controller,
              obscureText: widget.obscureText,
              keyboardType: widget.keyboardType,
              textInputAction: TextInputAction.newline,
              textAlignVertical: TextAlignVertical.center,
              cursorColor: textColor,
              style: CustomTextView.getStyle(context, colorLight: textColor),
              decoration: InputDecoration(
                hintText: widget.hintText,
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.suffixIcon,
                contentPadding: widget.contentPadding,
                hintStyle: CustomTextView.getStyle(context,
                    colorLight: textColor, fontSize: 15.sp),
                border: InputBorder.none,
                errorText: widget.errorText,
                errorStyle: const TextStyle(color: Colors.redAccent),
              ),
              onChanged: widget.onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
