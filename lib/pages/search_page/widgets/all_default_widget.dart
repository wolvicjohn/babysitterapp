import 'package:babysitterapp/models/search_result.dart';
import 'package:babysitterapp/styles/colors.dart';
import 'package:flutter/material.dart';

class AllDefaultWidget extends StatelessWidget {
  const AllDefaultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final babysitters = SearchResult.fetchBabysitters();

    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: babysitters.length,
        itemBuilder: (context, index) {
          final babysitter = babysitters[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  //profile picture
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(babysitter.profileImage),
                    backgroundColor: Colors.grey[200],
                  ),
                  const SizedBox(width: 16),

                  //details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          babysitter.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          babysitter.bio,
                          style: const TextStyle(color: Colors.grey),
                        ),

                        const SizedBox(height: 8),

                        Row(
                          children: [
                            Row(
                              children: _buildStarIcons(babysitter.rating),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${babysitter.reviewsCount} reviews',
                              style: const TextStyle(
                                color: primaryColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 4),
                        Text(
                          '${babysitter.distance.toStringAsFixed(1)} km away',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          '\$200 per hour for 1 child',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  //generate star icons based on the rating
  List<Widget> _buildStarIcons(double rating) {
    List<Widget> stars = [];
    for (int i = 1; i <= 5; i++) {
      if (i <= rating) {
        stars.add(
            const Icon(Icons.star, color: Colors.purple, size: 20)
        );
      } else if (i - rating < 1) {
        stars.add(
            const Icon(Icons.star_half, color: Colors.purple, size: 20)
        );
      } else {
        stars.add(
            const Icon(Icons.star_border, color: Colors.purple, size: 20)
        );
      }
    }
    return stars;
  }
}
