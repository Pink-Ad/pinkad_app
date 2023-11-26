import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pink_ad/app/data/api_service.dart';
import 'package:pink_ad/utilities/colors/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:pink_ad/app/models/banner_modal.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePageSlider extends StatefulWidget {
  @override
  _HomePageSliderState createState() => _HomePageSliderState();
}

class _HomePageSliderState extends State<HomePageSlider> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  int currentPage = 0;
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    // Call the function to start the slider when the widget is first created
    startSlider();
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed to prevent memory leaks
    _timer.cancel();
    super.dispose();
  }

  // Define a timer and a function to update the page controller
  late Timer _timer;

  void startSlider() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (currentPage < 2) {
        currentPage++;
      } else {
        currentPage = 0;
      }
      controller.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> banner = box.read('banner') ?? [];
    final pages = List.generate(
      banner.length,
      (index) => InkWell(
        onTap: () {
          launchUrl(Uri.parse(banner[index].redirectUrl));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey.shade300,
            image: DecorationImage(
              image:
                  NetworkImage(ApiService.imageBaseUrl + banner[index].image!),
              fit: BoxFit.fill,
            ),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 130.h,
              child: PageView.builder(
                controller: controller,
                itemBuilder: (_, index) {
                  return banner.length > 0
                      ? pages[index % pages.length]
                      : const SizedBox();
                },
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
              ),
            ),

            // SmoothPageIndicator(
            //   controller: controller,
            //   count: pages.length,
            //   effect:  WormEffect(
            //     dotHeight: 12.h,
            //     dotWidth: 12.w,
            //     activeDotColor: secondary,
            //     type: WormType.thin,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
