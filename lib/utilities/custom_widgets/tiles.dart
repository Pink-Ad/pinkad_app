import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_ad/utilities/colors/colors.dart';

class Tile extends StatelessWidget {
  final String title;
  final String stats;
  const Tile({super.key, required this.title, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: 120.w,
      decoration: BoxDecoration(
          // gradient: LinearGradient(
          //   begin: Alignment.topRight,
          //   end: Alignment.bottomLeft,
          //   colors: [
          //     primary,
          //     secondary,
          //   ],
          // ),
          // boxShadow:BoxShadow(blurRadius: 1,color: Colors.) ,
          border: Border.all(width: 1),
          color: const Color.fromARGB(255, 235, 235, 235),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 17.sp, color: primary),
            ),
            Text(stats, style: TextStyle(fontSize: 17.sp, color: primary))
          ]),
    );
  }
}
