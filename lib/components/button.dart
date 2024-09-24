import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final double width;
  final double height;
  final Function()? onPressed;
  final String text;

  const AppButton(
      {super.key,
      required this.width,
      required this.text,
      required this.height,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    var buttonStyle = ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)));
    var textStyle = const TextStyle(fontWeight: FontWeight.w500);

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: buttonStyle,
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }
}
