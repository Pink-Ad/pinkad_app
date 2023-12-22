// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:pink_ad/utilities/colors/colors.dart';

// class DashboardPageSlider extends StatefulWidget {
//   const DashboardPageSlider({super.key});

//   @override
//   _DashboardPageSliderState createState() => _DashboardPageSliderState();
// }

// class _DashboardPageSliderState extends State<DashboardPageSlider> {
//   final controller = PageController(viewportFraction: 0.8, keepPage: true);
//   int currentPage = 0;
//   bool show = false;
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
//   showStats() {
//     setState(() {
//       show = !show;
//     });
//   }

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
//     final pages = List.generate(
//       3,
//       (index) => Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           color: Colors.grey.shade300,
//           // image: DecorationImage(
//           //   image: AssetImage('assets/images/banner.png'),
//           //   fit: BoxFit.fill,
//           // ),
//         ),
//         margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
//         child: Stack(
//           children: [
//             Image.asset(
//               'assets/images/banner.png',
//               fit: BoxFit.fill,
//               height: 120.h,
//             ),
//             Positioned(
//                 top: 10,
//                 right: 10,
//                 child: Container(
//                   height: 30.h,
//                   width: 35.w,
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(30)),
//                   child: const Icon(
//                     Icons.delete,
//                     color: Colors.red,
//                     // size: 12.sh,
//                   ),
//                 )),
//             Positioned(
//                 top: 50.h,
//                 right: 10.h,
//                 child: InkWell(
//                   onTap: showStats,
//                   child: Container(
//                     height: 30.h,
//                     width: 35.w,
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(30)),
//                     child: const Icon(
//                       Icons.remove_red_eye,
//                       color: primary,
//                       // size: 12.sh,
//                     ),
//                   ),
//                 )),
//           ],
//         ),
//       ),
//     );
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.transparent,
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             SizedBox(
//               height: 130.h,
//               child: PageView.builder(
//                 controller: controller,
//                 itemBuilder: (_, index) {
//                   return pages[index % pages.length];
//                 },
//                 onPageChanged: (index) {
//                   setState(() {
//                     currentPage = index;
//                   });
//                 },
//               ),
//             ),
//             show
//                 ? Padding(
//                     padding: EdgeInsets.only(top: 20.h),
//                     // child:  StatsTiles(),
//                   )
//                 : const SizedBox()
//             // SmoothPageIndicator(
//             //   controller: controller,
//             //   count: pages.length,
//             //   effect:  WormEffect(
//             //     dotHeight: 12.h,
//             //     dotWidth: 12.w,
//             //     activeDotColor: secondary,
//             //     type: WormType.thin,
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
