import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pink_ad/app/modules/splash/bindings/splash_binding.dart';
import 'package:pink_ad/app/modules/splash/views/splash_view.dart';
import 'package:pink_ad/utilities/colors/colors.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // Locks the device in portrait mode
    // DeviceOrientation.landscapeLeft, // Uncomment this line to lock the device in landscape mode
    // DeviceOrientation.landscapeRight, // Uncomment this line to lock the device in landscape mode
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeData lightTheme = ThemeData.light();
  final ThemeData darkTheme = ThemeData.dark();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: "Pink Ad",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: const Color(0xFF460C68),
            primaryColorLight: Colors.transparent,
            // primaryColorDark: Color(0xFF460C68),
            // colorScheme: const ColorScheme.light(),

            colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary: secondary),
            // useMaterial3: true,
            // primaryTextTheme: Typography().white, // or white
            // Set the default text style for the app
            textTheme: TextTheme(
              titleLarge: TextStyle(
                color: textColor,
                fontSize: 30.sp,
                fontFamily: "Radomir Tinkov - Gilroy-ExtraBold",
                // fontWeight: FontWeight.w700,
              ),
              titleMedium: TextStyle(
                color: textColor,
                fontSize: 18.sp,
                fontFamily: "Radomir Tinkov - Gilroy-ExtraBold",
                // fontWeight: FontWeight.w700,
              ),
              titleSmall: TextStyle(
                color: textColor,
                fontSize: 16.sp,
                fontFamily: "Radomir Tinkov - Gilroy-Light",
                // fontWeight: FontWeight.w700,
              ),
              bodyLarge: TextStyle(
                color: textColor,
                fontSize: 18.sp,
                fontFamily: "Poppins-Regular",
                // fontWeight: FontWeight.w700,
              ),
              bodyMedium: TextStyle(
                color: textColor,
                fontSize: 16.sp,
                fontFamily: "Poppins-Regular",
                // fontWeight: FontWeight.w700,
              ),
              bodySmall: TextStyle(
                color: textColor,
                fontSize: 14.sp,
                fontFamily: "Poppins-Regular",
              ),
            ),
          ).copyWith(
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: primary,
              ),
            ),
          ),
          useInheritedMediaQuery: true,
          initialBinding: SplashBinding(),
          home: const SplashView(),
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
        );
      },
    );
  }
}
