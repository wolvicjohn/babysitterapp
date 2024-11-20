import 'package:babysitterapp/components/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../services/search_service.dart';
import '../../styles/colors.dart';
import '../../styles/route_animation.dart';
import '../../styles/size.dart';
import '../profile/babysitterprofilepage.dart';

class UserViewLocation extends StatefulWidget {
  const UserViewLocation({super.key});

  @override
  State<UserViewLocation> createState() => _UserViewLocationState();
}

class _UserViewLocationState extends State<UserViewLocation> {
  // Show info container
  bool showContainer = false;

  // Selected babysitter details
  Map<String, dynamic>? selectedBabysitter;

  // Services
  final SearchService searchService = SearchService();

  // Locations
  final LatLng center = const LatLng(7.306836, 125.680799);

  // Babysitter data
  List<Map<String, dynamic>> babysitters = [];

  // styles widgets
  var textStyle = const TextStyle(fontSize: 12);
  var textOverflow = TextOverflow.ellipsis;

  @override
  void initState() {
    super.initState();
    _fetchBabysitters();
  }

  // Fetch babysitters from Firestore
  Future<void> _fetchBabysitters() async {
    final fetchedBabysitters = await searchService.fetchBabysitters();
    setState(() {
      babysitters = fetchedBabysitters;
    });
  }

  // Show/hide info container
  void _showContainer(Map<String, dynamic> babysitter) {
    setState(() {
      selectedBabysitter = babysitter;
      showContainer = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: sizeConfig.heightSize(context),
        child: Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                initialCenter: center,
                initialZoom: 14,
                minZoom: 14,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                _buildCircleLayer(),
                _buildMarkers(),
              ],
            ),
            _buildInformation(),
          ],
        ),
      ),
    );
  }

  // CircleLayer to show user's radius
  Widget _buildCircleLayer() {
    return CircleLayer(
      circles: [
        CircleMarker(
          point: center,
          color: Colors.blue.withOpacity(0.3),
          borderColor: Colors.blue,
          borderStrokeWidth: 2,
          radius: 200,
        ),
      ],
    );
  }

  // Map markers
  Widget _buildMarkers() {
    return MarkerLayer(
      markers: babysitters.map((babysitter) {
        final location = babysitter['location'];
        if (location == null) {
          return Marker(point: const LatLng(0, 0), child: Container());
        }
        return Marker(
          point: LatLng(location.latitude, location.longitude),
          width: 100,
          height: 80,
          child: GestureDetector(
            onTap: () => _showContainer(babysitter),
            child: _buildBabysitterCard(babysitter),
          ),
        );
      }).toList(),
    );
  }

  // Babysitter card widget for marker
  Widget _buildBabysitterCard(Map<String, dynamic> babysitter) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6, spreadRadius: 1),
        ],
      ),
      width: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: Image.asset(
              babysitter['img'],
              width: 30,
              height: 30,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            babysitter['name'],
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, size: 10, color: Colors.amber),
              SizedBox(width: 2),
              Text(
                "5.0",
                style: TextStyle(fontSize: 8),
              ),
            ],
          ),
          Text(
            "P${babysitter['rate']}/hour",
            style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildInformation() {
    if (selectedBabysitter == null) return const SizedBox.shrink();

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
      bottom: showContainer ? 25 : -200,
      left: 0,
      right: 0,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: showContainer ? 1.0 : 0.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            width: sizeConfig.widthSize(context),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 20.0,
                  spreadRadius: 5.0,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag indicator
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          // Profile Image Section
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: tertiaryColor,
                                width: 2,
                              ),
                            ),
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 40,
                              backgroundImage: AssetImage(
                                selectedBabysitter!['img'] ?? '',
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Information Section
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        selectedBabysitter!['name'] ?? '',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade50,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.verified,
                                            size: 14,
                                            color: Colors.green.shade700,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            'Verified',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.green.shade700,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      size: 16,
                                      color: Colors.grey.shade600,
                                    ),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        selectedBabysitter!['address'] ?? '',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade600,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    _buildInfoChip(
                                      icon: Icons.star_rounded,
                                      label: "5.0 (90+)",
                                      iconColor: Colors.amber,
                                    ),
                                    const SizedBox(width: 8),
                                    _buildInfoChip(
                                      icon: Icons.cases_outlined,
                                      label: "3 yrs exp",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Bottom Section with Rate and Button
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Rate per hour',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'P${selectedBabysitter!['rate']}/hr',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                                height: 46,
                                child: AppButton(
                                  text: "Book Now",
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        RouteAnimate(0.0, 1.0,
                                            page: BabysitterProfilePage(
                                                babysitterID:
                                                    selectedBabysitter![
                                                        'id'])));
                                  },
                                )),
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
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    Color? iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: iconColor ?? Colors.grey.shade700,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
