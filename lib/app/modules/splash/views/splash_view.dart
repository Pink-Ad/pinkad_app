import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pink_ad/utilities/colors/colors.dart';
import 'package:pink_ad/utilities/custom_widgets/text_utils.dart';

import '../controllers/splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashController>(
        init: SplashController(),
        builder: (_) => Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xffD43790), Color(0xff791961)])
                // image: DecorationImage(
                //   image: AssetImage("assets/images/bg_splash.png"),
                //   fit: BoxFit.cover,
                // ),
                ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/newTile.png',
                    width: 270.w,
                    height: 45.h,
                    fit: BoxFit.fill,
                  ),
                  //   SvgPicture.asset("assets/svgIcons/app_logo.svg"),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text("Free Business Promotion Platform",
                      textAlign: TextAlign.center,
                      style: CustomTextView.getStyle(context,
                          colorLight: Colors.white,
                          fontSize: 15.sp,
                          fontFamily: "Poppins-SemiBold")),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    width: 200.w,
                    child: const ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: LinearProgressIndicator(
                        backgroundColor: secondary,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                        minHeight: 10,
                      ),
                    ),
                  )
                ],
              ),
            ) // Your other widgets go here
            ),
      ),
    );
  }
}
