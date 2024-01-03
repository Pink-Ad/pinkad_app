import 'package:flutter/material.dart';

class MyLoading extends StatelessWidget {
  const MyLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.transparent,
        child: Center(
          child: CircularProgressIndicator(),
        ),
        // child: Image.asset(
        //   "assets/icons/ic_loader.gif",
        //   scale: 3.6,
        // ),
      ),
    );
  }
}
