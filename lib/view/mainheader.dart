import 'package:babysitterapp/components/ratingstars.dart';
import 'package:babysitterapp/styles/colors.dart';
import 'package:flutter/material.dart';

class MainHeader extends StatelessWidget {
  final String img;
  final String name;
  final String email;
  final String address;
  final double rating;
  final int rate;
  final int reviewsNo;

  const MainHeader({
    super.key,
    required this.img,
    required this.name,
    required this.email,
    required this.rating,
    required this.reviewsNo,
    required this.address,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(img),
                radius: 70,
              ),
              const SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      RatingStars(rating: rating.toInt(), iconSize: 30),
                      Text(rating.toString()),
                    ],
                  ),
                  Text(
                    '$reviewsNo reviews',
                    style: const TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text('26 Solds')
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(email),
              Text(address),
              Text('₱ $rate per hour for 1 child'),
            ],
          ),
        ],
      ),
    );
  }
}
