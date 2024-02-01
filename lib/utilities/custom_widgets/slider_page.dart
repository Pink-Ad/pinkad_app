import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:pink_ad/app/data/api_service.dart';
// import 'package:url_launcher/url_launcher.dart';

// class HomePageSlider extends StatefulWidget {
//   const HomePageSlider({super.key});

//   @override
//   _HomePageSliderState createState() => _HomePageSliderState();
// }

// class _HomePageSliderState extends State<HomePageSlider> {
//   final controller = PageController(viewportFraction: 0.8, keepPage: true);
//   int currentPage = 0;
//   final box = GetStorage();

//   @override
//   void initState() {
//     super.initState();
//     // Call the function to start the slider when the widget is first created
//     startSlider();
//   }

//   @override
//   void dispose() {
//     // Cancel the timer when the widget is disposed to prevent memory leaks
//     _timer.cancel();
//     super.dispose();
//   }

//   // Define a timer and a function to update the page controller
//   late Timer _timer;

//   void startSlider() {
//     _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
//       if (currentPage < 2) {
//         currentPage++;
//       } else {
//         currentPage = 0;
//       }
//       controller.animateToPage(
//         currentPage,
//         duration: const Duration(milliseconds: 500),
//         curve: Curves.easeInOut,
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<dynamic> banner = box.read('banner') ?? [];
//     final pages = List.generate(
//       banner.length,
//       (index) => Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
//         //padding: const EdgeInsets.all(8.0),
//         child: InkWell(
//           onTap: () {
//             launchUrl(Uri.parse(banner[index].redirectUrl));
//           },
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//               color: Colors.grey.shade300,
//               image: DecorationImage(
//                 image: NetworkImage(
//                     ApiService.imageBaseUrl + banner[index].image!),
//                 fit: BoxFit.fill,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: SafeArea(
//         child: Column(
//           children: <Widget>[
//             SizedBox(
//               height: 180.h,
//               child: PageView.builder(
//                 controller: controller,
//                 itemBuilder: (_, index) {
//                   return banner.isNotEmpty
//                       ? pages[index % pages.length]
//                       : const SizedBox();
//                 },
//                 onPageChanged: (index) {
//                   setState(() {
//                     currentPage = index;
//                   });
//                 },
//                 clipBehavior: Clip.none,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pink_ad/app/data/api_service.dart';
import 'package:pink_ad/utilities/colors/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePageSlider extends StatefulWidget {
  const HomePageSlider({super.key});

  @override
  _HomePageSliderState createState() => _HomePageSliderState();
}

class _HomePageSliderState extends State<HomePageSlider> {
  final box = GetStorage();
  final CarouselController _carouselController = CarouselController();
  int currentBanner = 0;

  @override
  void initState() {
    super.initState();
    // Start the auto-play feature for the carousel
    // startAutoPlay();
  }

  @override
  void dispose() {
    // Dispose the carousel controller
    // _timer?.cancel();
    // _carouselController.stopAutoPlay();
    super.dispose();
  }

  // void startAutoPlay() {
  //   // Start auto-play using a periodic timer
  //   _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
  //     _carouselController.nextPage(
  //       duration: const Duration(milliseconds: 500),
  //       curve: Curves.easeInOut,
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    List<dynamic> banner = box.read('banner') ?? [];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: (banner.isNotEmpty)
          ? Column(
              children: <Widget>[
                CarouselSlider.builder(
                  itemCount: banner.length,
                  itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                    return InkWell(
                      onTap: () {
                        launchUrl(
                          Uri.parse(banner[itemIndex].redirectUrl),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.shade300,
                            image: DecorationImage(
                              image: NetworkImage(ApiService.imageBaseUrl + banner[itemIndex].image!),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 0.8,
                    aspectRatio: 2.3,
                    initialPage: currentBanner,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentBanner = index;
                        // Update the current page if you need to keep track of the index
                      });
                    },
                  ),
                  carouselController: _carouselController,
                ),
                10.verticalSpace,
                AnimatedSmoothIndicator(
                  activeIndex: currentBanner % 4,
                  count: 4,
                  effect: ExpandingDotsEffect(
                    activeDotColor: primary,
                    expansionFactor: 2.5,
                    dotHeight: 12,
                    dotWidth: 12,
                  ),
                ),
              ],
            )
          : SizedBox(),
    );
  }
}
