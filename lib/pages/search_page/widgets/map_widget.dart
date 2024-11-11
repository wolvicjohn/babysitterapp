import 'package:babysitterapp/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:babysitterapp/models/search_result.dart';

class MapWidget extends StatefulWidget {
  final LatLng userLocation;
  final List<SearchResult> babysitters;

  const MapWidget({
    super.key,
    required this.userLocation,
    required this.babysitters,
  });

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  SearchResult? selectedBabysitter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: widget.userLocation,
              initialZoom: 14,
              minZoom: 10,
              maxZoom: 18,
            ),
            children: [
              //tile layer for the map
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),

              //marker layer for user and babysitter locations
              MarkerLayer(
                markers: [
                  //user's location
                  Marker(
                    point: widget.userLocation,
                    width: 50,
                    height: 50,
                    child: Image.asset('assets/images/location2.png'),
                  ),

                  //markers for all babysitter locations
                  ...widget.babysitters.map((babysitter) {
                    final googleLatLng = LatLng(
                      babysitter.geocode.latitude,
                      babysitter.geocode.longitude,
                    );
                    return Marker(
                      point: googleLatLng,
                      width: 100,
                      height: 80,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedBabysitter = babysitter; //update the selected babysitter
                          });
                        },
                        child: _buildBabysitterCard(babysitter),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ],
          ),

          //display the card at the bottom if a babysitter is selected
          if (selectedBabysitter != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildSelectedBabysitterCard(selectedBabysitter!),
            ),
        ],
      ),
    );
  }

  //widget for displaying the card when a babysitter is selected
  Widget _buildSelectedBabysitterCard(SearchResult babysitter) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                setState(() {
                  selectedBabysitter = null;
                });
              },
            ),
          ),


          //display profile image and name
          Row(
            children: [
              ClipOval(
                child: Image.asset(
                  babysitter.profileImage,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(width: 16),
              Text(
                babysitter.name,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),

          Row(
            children: [
              const Icon(Icons.star, color: primaryColor, size: 18),
              const SizedBox(width: 4),
              Text('${babysitter.rating} (${babysitter.reviewsCount} reviews)'),
            ],
          ),

          const SizedBox(height: 8),
          Text('Distance: ${babysitter.distance} km'),
          const SizedBox(height: 8),
          Text('Bio: ${babysitter.bio}'),
          const SizedBox(height: 8),
          Text('Skills: ${babysitter.skills.join(', ')}'),
          const SizedBox(height: 8),
          Text('Experience: ${babysitter.experience}'),
          const SizedBox(height: 16),

          //contact and book now buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //       builder: (context) => const UserDe()),
                  // );
                },
                child: Text('Contact'),
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
              ),
              ElevatedButton(
                onPressed: () {
                },
                child: Text('Book Now'),
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //widget for displaying the babysitter card in the marker
  Widget _buildBabysitterCard(SearchResult babysitter) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6, spreadRadius: 1)],
      ),
      width: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: Image.asset(
              babysitter.profileImage,
              width: 30,
              height: 30,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            babysitter.name,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 1,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Icon(Icons.star, size: 10, color: primaryColor),
              const SizedBox(width: 2),
              Text(
                babysitter.rating.toString(),
                style: const TextStyle(fontSize: 8),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
