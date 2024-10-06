import 'package:flutter/material.dart';

class MyFunction {
  Widget ratingStar(i, double size_) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int x = 0; x < i; x++)
            Icon(
              Icons.star,
              color: Colors.deepPurple,
              size: size_,
            ),
          for (int y = 0; y < 5 - i; y++)
            Icon(
              Icons.star,
              color: Colors.grey,
              size: size_,
            ),
        ],
      );
}
