import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomBackground extends StatelessWidget {
  Widget child;

  CustomBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Container(
              height: Get.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg_login.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [child],
              ),
            ),
          ),
        ));
  }
}
