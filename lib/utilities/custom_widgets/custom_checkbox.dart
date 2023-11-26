import 'package:flutter/material.dart';
import 'package:pink_ad/utilities/colors/colors.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;

  const CustomCheckbox({Key? key, required this.value, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.8,
      child: Checkbox(
        value: value,
        onChanged: onChanged,
        checkColor: Colors.white,
        fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return const Color(0xffD1349B); // Change the color of the checkbox when it's checked
          }

          return secondary; // Change the color of the checkbox when it's not checked
        }),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(color: Colors.white ,width: .5) // Change the border color of the checkbox
        ),

      ),
    );
  }
}
