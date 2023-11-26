import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_ad/utilities/custom_widgets/text_utils.dart';
class GlobalButton extends StatelessWidget {
  const GlobalButton({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.buttonColor,
    required this.textColor,
  }) : super(key: key);

  final String title;
  final VoidCallback onPressed;
  final Color buttonColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50.h,
        margin: EdgeInsets.symmetric(horizontal: 20.0.w),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            title,
            style: CustomTextView.getStyle(context, colorLight: Colors.white ,  fontSize: 15.sp ,fontFamily: "Poppins-Medium")
            ),
          ),
        ),
      );
  }
}
