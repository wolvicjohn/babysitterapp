import 'package:babysitterapp/pages/profile/babysitterprofilepage.dart';
import 'package:flutter/material.dart';
import '../../../services/search_service.dart';
import '../../../styles/route_animation.dart';

class AllDefaultWidget extends StatefulWidget {
  const AllDefaultWidget({super.key});

  @override
  State<AllDefaultWidget> createState() => _AllDefaultWidgetState();
}

class _AllDefaultWidgetState extends State<AllDefaultWidget> {
  final SearchService searchService = SearchService();
  late Future<List<Map<String, dynamic>>> babysittersFuture;

  @override
  void initState() {
    super.initState();
    babysittersFuture = searchService.fetchBabysitters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: babysittersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final babysitters = snapshot.data ?? [];
          if (babysitters.isEmpty) {
            return const Center(child: Text('No babysitters found.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: babysitters.length,
            itemBuilder: (context, index) {
              final babysitter = babysitters[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(
                      8.0), // Add ripple effect with border radius
                  onTap: () {
                    Navigator.push(
                        context,
                        RouteAnimate(0.0, -1.0,
                            page: BabysitterProfilePage(
                                babysitterID: babysitter['id'])));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        // Profile picture
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: babysitter['img'] != null
                              ? AssetImage(babysitter['img'])
                              : null,
                          backgroundColor: Colors.grey[200],
                        ),
                        const SizedBox(width: 16),

                        // Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                babysitter['name'] ?? 'Unknown Name',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                babysitter['address'] ?? '',
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Row(
                                    children: _buildStarIcons(
                                        babysitter['rate']?.toDouble() ?? 0.0),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${babysitter['rate'] ?? 0} reviews',
                                    style: const TextStyle(
                                      color: Colors.purple,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'P${babysitter['rate'] ?? 0} per hour',
                                style: const TextStyle(
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
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Generate star icons based on the rating
  List<Widget> _buildStarIcons(double rating) {
    List<Widget> stars = [];
    for (int i = 1; i <= 5; i++) {
      if (i <= rating) {
        stars.add(const Icon(Icons.star, color: Colors.purple, size: 20));
      } else if (i - rating < 1) {
        stars.add(const Icon(Icons.star_half, color: Colors.purple, size: 20));
      } else {
        stars
            .add(const Icon(Icons.star_border, color: Colors.purple, size: 20));
      }
    }
    return stars;
  }
}
