import 'package:flutter/material.dart';

class CustomBgDashboard extends StatelessWidget {
  Widget child;
  final bool? isShopsInsightView;

  CustomBgDashboard({super.key, required this.child, this.isShopsInsightView});

  @override
  Widget build(BuildContext context) {
    String backgroundImage = isShopsInsightView == true
        ? 'assets/images/bg_homecopy.png'
        : 'assets/images/bg_home.png';

    return SafeArea(
      top: false,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 1,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          body: child,
        ),
      ),
    );
  }
}
