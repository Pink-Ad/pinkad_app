import 'package:flutter/material.dart';

class CustomBgDashboard extends StatelessWidget {
  Widget child;
  final bool? isUserProfileView;
  final bool? isterms_view;
  final bool? isfeedback;

  CustomBgDashboard({
    super.key,
    required this.child,
    this.isUserProfileView,
    this.isfeedback,
    this.isterms_view,
  });

  @override
  Widget build(BuildContext context) {
    String backgroundImage =
        isUserProfileView == true || isterms_view == true || isfeedback == true
            ? 'assets/images/bg_home.png'
            : 'assets/images/bg_homecopy.png';

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
