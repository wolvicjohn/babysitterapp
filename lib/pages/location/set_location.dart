import 'package:babysitterapp/components/button.dart';
import 'package:babysitterapp/styles/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../services/location_service.dart';

class SetLocation extends StatefulWidget {
  const SetLocation({super.key});

  @override
  State<SetLocation> createState() => _SetLocationState();
}

class _SetLocationState extends State<SetLocation> {
  LocationService locationService = LocationService();

  double latitude = 0;
  double longitude = 0;

  final double initialCenterLat = 7.30215;
  final double initialCenterLon = 125.68145;

  late MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.deepPurple),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SizedBox(
        height: sizeConfig.heightSize(context),
        child: Stack(
          children: [
            FlutterMap(
              mapController: mapController,
              options: MapOptions(
                  initialCenter: LatLng(initialCenterLat, initialCenterLon),
                  initialZoom: 14,
                  minZoom: 14),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(
                  markers: [
                    // use location marker
                    Marker(
                      point: LatLng(latitude, longitude),
                      width: 125,
                      height: 125,
                      child: Tooltip(
                        message: "You are here!",
                        triggerMode: TooltipTriggerMode.tap,
                        verticalOffset: 20,
                        preferBelow: false,
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.asset('assets/images/location.png'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: sizeConfig.widthSize(context),
                  height: 50,
                  child: FutureBuilder(
                    future: locationService
                        .getAddressFromCoordinates(LatLng(latitude, longitude)),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text('Loading...');
                      }
                      return Text(snapshot.data.toString());
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppButton(
                    text: "Use Location",
                    onPressed: _getUserLocation,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // tag users location
  Future<void> _getUserLocation() async {
    final pos = await locationService.determinePosition();
    setState(() {
      latitude = pos.latitude;
      longitude = pos.longitude;
      mapController.move(LatLng(latitude, longitude), 14);
    });
    _showSuccessDialog();
  }

  // show dialog after tagging location
  Future<void> _showSuccessDialog() async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          "Success!",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        content: const Text(
          "Your location has been set!",
          style: TextStyle(fontSize: 15, height: 1.5),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Done',
            ),
          ),
        ],
      ),
    );
  }
}
