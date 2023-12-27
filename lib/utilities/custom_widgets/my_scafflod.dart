import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pink_ad/utilities/colors/colors.dart';

import '../bg_login.dart';

class CustomBackground extends StatelessWidget {
  final Widget child;
  final Widget header;

  CustomBackground({
    super.key,
    required this.child,
    required this.header,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // top: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: primary,
        body: Column(
          children: [
            header,
            10.verticalSpace,
            Expanded(
              child: Stack(
                children: [
                  CustomPaint(
                    size: Size(
                      Get.width,
                      (Get.width * 2.1653333333333333).toDouble(),
                    ), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                    painter: RPSCustomPainter(),
                  ),
                  child,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
