import 'package:flutter/material.dart';

class BabysitterCard extends StatelessWidget {
  final String name;
  final String rate;
  final double rating;
  final int reviews;
  final String profileImage;

  const BabysitterCard({
    super.key,
    required this.name,
    required this.rate,
    required this.rating,
    required this.reviews,
    this.profileImage = 'assets/avatar.png',
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundImage: AssetImage(profileImage),
          radius: 30,
        ),
        title: Row(
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            const Spacer(),
            Text(
              rate,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        subtitle: Row(
          children: [
            Icon(Icons.star,
                color: Theme.of(context).colorScheme.primary, size: 18),
            const SizedBox(width: 4),
            Text(
              rating.toStringAsFixed(1),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              ' / $reviews reviews',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            const Spacer(),
            IconButton(
              icon: Icon(Icons.favorite_border,
                  color: Theme.of(context).colorScheme.primary),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
