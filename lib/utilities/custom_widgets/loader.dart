import 'package:flutter/material.dart';

class MyLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.transparent,
        child: Image.asset(
          "assets/icons/ic_loader.gif",
          scale: 3.6,
        ),
      ),
    );
  }
}
