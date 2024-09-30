import 'package:flutter/material.dart';

class SizeConfig {
  double heightSize(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  double widthSize(
    BuildContext context,
  ) {
    return MediaQuery.of(context).size.width;
  }
}

SizeConfig sizeConfig = SizeConfig();
