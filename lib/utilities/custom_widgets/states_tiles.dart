import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_ad/utilities/custom_widgets/tiles.dart';

class StatsTiles extends StatelessWidget {
  final int view, reach, impression, conversion;
  const StatsTiles({
    super.key,
    required this.reach,
    required this.view,
    required this.impression,
    required this.conversion,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Tile(
              title: 'Reach',
              stats: reach.toString(),
              icon: Icons.group,
            ),
            Tile(
              title: 'View',
              stats: view.toString(),
              icon: Icons.visibility,
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Tile(
              title: 'Impression',
              stats: impression.toString(),
              icon: Icons.assessment,
            ),
            Tile(
              title: 'Conversion',
              stats: conversion.toString(),
              icon: Icons.swap_horiz,
            ),
          ],
        ),
      ],
    );
  }
}
