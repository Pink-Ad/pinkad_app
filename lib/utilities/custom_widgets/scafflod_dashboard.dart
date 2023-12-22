import 'package:flutter/material.dart';

class CustomBgDashboard extends StatelessWidget {
  Widget child;

  CustomBgDashboard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 1,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg_home.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.transparent,
            body: child),
      ),
    );
  }
}
