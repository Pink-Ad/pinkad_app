import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pink_ad/app/data/api_service.dart';
import 'package:pink_ad/app/modules/profile/views/profile_view.dart';
import 'package:pink_ad/app/modules/tutorial/views/video.dart';
import 'package:pink_ad/utilities/custom_widgets/custom_appbar_user.dart';
import 'package:pink_ad/utilities/custom_widgets/scafflod_dashboard.dart';

import '../controllers/tutorial_controller.dart';

class TutorialView extends GetView<TutorialController> {
  final box = GetStorage();
  TutorialView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List tutorials = box.read('tutorial') ?? [];
    print(tutorials);
    return CustomBgDashboard(
      child: SafeArea(
        child: Column(
          children: [
            UserAppBar(
              profileIconVisibility: true,
              backButton: false,
              title: "Tutorial",
              onMenuTap: () {
                print("object");
              },
              onProfileTap: () {
                print("object");
                Get.to(ProfileView());
              },
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 13.w),
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 100.h,
              ),
              child: ListView.builder(
                itemCount: tutorials.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => PromoScreem(
                                    videoUrl: ApiService.imageBaseUrl +
                                        tutorials[index].video,
                                    promoText: tutorials[index].title ?? '',
                                  )));
                    },
                    child: Container(
                        padding: EdgeInsets.all(10.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFFffffff),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 10.0, // soften the shadow
                              spreadRadius: 5.0, //extend the shadow
                              offset: Offset(
                                1.0, // Move to right 5  horizontally
                                1.0, // Move to bottom 5 Vertically
                              ),
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 150.h,
                              child: Image.network(
                                ApiService.imageBaseUrl +
                                    tutorials[index].thumbnail,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(tutorials[index]?.title ?? '',
                                style: TextStyle(
                                    fontSize: 18.sp, color: Colors.black)),
                            Text(tutorials[index]?.description ?? '',
                                style: TextStyle(fontSize: 16.sp)),
                          ],
                        )),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
