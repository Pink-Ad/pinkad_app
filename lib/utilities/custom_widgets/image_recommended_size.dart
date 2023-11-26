import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageRecommendedSizeText extends StatelessWidget {
  const ImageRecommendedSizeText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 20.w,
      ),
      child: Text(
        'Recommended dimension would be 217 × 217',
        style: TextStyle(fontSize: 11.sp, color: Colors.red),
      ),
    );
  }
}
