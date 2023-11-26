import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextView {
  static TextStyle? getStyle(
      BuildContext context, {
        double fontSize = 14.0,
        Color? colorDark,
        Color? colorLight,
        FontWeight fontWeight = FontWeight.normal,
        String fontFamily = "Poppins-Regular",
      }) {
    final color = colorLight ;

    switch (fontWeight) {
      case FontWeight.bold:
        return Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: fontSize.sp,
            color: color,
            fontFamily: fontFamily,
            fontWeight: fontWeight);
      case FontWeight.w600:
        return Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: fontSize.sp,
            color: color,
            fontFamily: fontFamily,
            fontWeight: fontWeight);
      case FontWeight.w500:
        return Theme.of(context).textTheme.titleSmall?.copyWith(
            fontSize: fontSize.sp,
            color: color,
            fontFamily: fontFamily,
            fontWeight: fontWeight);
      case FontWeight.w400:
      default:
        return Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: fontSize.sp,
            color: color,
            fontFamily: fontFamily,
            fontWeight: fontWeight);
    }
  }
}
