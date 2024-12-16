import 'package:babysitterapp/pages/profile/babysitterprofilepage.dart';
import 'package:flutter/material.dart';
import '../../../services/search_service.dart';
import '../../../styles/route_animation.dart';

class RatesWidget extends StatefulWidget {
  const RatesWidget({super.key});

  @override
  State<RatesWidget> createState() => _RatesWidgetState();
}

class _RatesWidgetState extends State<RatesWidget> {
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

          //sort by rate descending
          babysitters.sort((a, b) => (b['rate'] ?? 0).compareTo(a['rate'] ?? 0));

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: babysitters.length,
            itemBuilder: (context, index) {
              final babysitter = babysitters[index];
              final rate = babysitter['rate'] ?? 0;

              //determine the number of stars based on the rate
              int starCount = 0;
              if (rate > 500) {
                starCount = 5;
              } else if (rate > 200) {
                starCount = 4;
              } else if (rate > 100) {
                starCount = 3;
              } else if (rate > 50) {
                starCount = 2;
              } else if (rate > 20) {
                starCount = 1;
              } else if (rate > 5) {
                starCount = 0;
              }

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8.0),
                  onTap: () {
                    Navigator.push(
                      context,
                      RouteAnimate(
                        0.0,
                        -1.0,
                        page: BabysitterProfilePage(
                            babysitterID: babysitter['id']),
                      ),
                    );
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
                                  //display stars based on starCount
                                  Row(
                                    children: List.generate(5, (index) {
                                      if (rate == 0) {
                                        return const Icon(
                                          Icons.star_border,
                                          color: Colors.purple,
                                          size: 20,
                                        );
                                      } else if (index < starCount) {
                                        return const Icon(
                                          Icons.star,
                                          color: Colors.purple,
                                          size: 20,
                                        );
                                      } else {
                                        return const Icon(
                                          Icons.star_border,
                                          color: Colors.purple,
                                          size: 20,
                                        );
                                      }
                                    }),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '$rate rates',
                                    style: const TextStyle(
                                      color: Colors.purple,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
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
}
