import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_ad/utilities/colors/colors.dart';

class Tile extends StatelessWidget {
  final String title;
  final String stats;
  final IconData icon;
  const Tile({
    super.key,
    required this.title,
    required this.stats,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: 120.w,
      padding: EdgeInsets.symmetric(horizontal: 8.w), // Add horizontal padding
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        color: Color.fromARGB(255, 245, 241, 241),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment
            .start, // Align children to the start of the cross axis
        children: [
          Row(
            mainAxisSize: MainAxisSize.min, // Align Row to the start
            children: [
              Icon(
                icon, // Use the icon data
                color: primary,
                size: 20.w, // Set the size of the icon
              ),
              SizedBox(width: 5.w), // Add space between icon and text
              Text(
                stats,
                style: TextStyle(fontSize: 17.sp, color: primary),
              ),
            ],
          ),
          SizedBox(height: 4.h), // Add space between the Row and the next Text
          Text(
            title,
            style: TextStyle(fontSize: 17.sp, color: primary),
          ),
        ],
      ),
    );
  }
}
