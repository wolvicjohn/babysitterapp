import 'package:babysitterapp/styles/size.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({super.key});

  @override
  Widget build(BuildContext context) {
    // store user input
    TextEditingController input = TextEditingController();

    var decoration = InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
        hintText: 'Type Here');
    var padding = const EdgeInsets.symmetric(horizontal: 15);

    return Padding(
      padding: padding,
      child: SizedBox(
        width: sizeConfig.widthSize(context),
        child: TextField(
          controller: input,
          decoration: decoration,
        ),
      ),
    );
  }
}
