import 'package:babysitterapp/styles/colors.dart';
import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final int rating;
  final double iconSize;
  const RatingStars({
    super.key,
    required this.rating,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int x = 0; x < rating; x++)
          Icon(
            Icons.star,
            color: primaryColor,
            size: iconSize,
          ),
        for (int y = 0; y < 5 - rating; y++)
          Icon(
            Icons.star,
            color: Colors.grey,
            size: iconSize,
          ),
      ],
    );
  }
}
