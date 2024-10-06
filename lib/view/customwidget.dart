import 'package:babysitterapp/components/ratingstars.dart';
import 'package:flutter/material.dart';

class CustomWidget {
  floatingBtn(
    context,
    Function() onPressed,
    Color backgroundColor,
    Color borderColor,
    Icon icon,
    String label,
    Color txtColor,
  ) =>
      ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            fixedSize: const Size.fromWidth(180),
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: borderColor,
              ),
            )),
        icon: icon,
        label: Text(
          label,
          style: TextStyle(color: txtColor),
        ),
      );

  carouselItem(String img, String name, int rating, String feedback) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(img),
            radius: 40,
          ),
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 15),
          RatingStars(rating: rating, iconSize: 30),
          const SizedBox(height: 15),
          SelectableText(
            feedback,
            textAlign: TextAlign.center,
          )
        ],
      );
}
