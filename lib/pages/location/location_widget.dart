import 'package:babysitterapp/components/button.dart';
import 'package:babysitterapp/models/location.dart';
import 'package:babysitterapp/styles/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  double latitude = 0;
  double longitude = 0;

  @override
  Widget build(BuildContext context) {
    // transparent appbar style
    var appBarStyle = AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      // back button
      leading: IconButton(
        color: Colors.deepPurple,
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: appBarStyle,
        body: SizedBox(
          // fill the whole screen
          height: sizeConfig.heightSize(context),
          // call the map
          child: FlutterMap(
            // state of map when called
            options: const MapOptions(
              initialCenter: LatLng(7.30215, 125.68145),
              initialZoom: 14,
            ),
            children: [
              // display of the map
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(markers: [
                // marker to show user's location when use location button is clickec
                Marker(
                  point: LatLng(latitude, longitude),
                  width: 100,
                  height: 100,
                  // tooltip when marker is clicked
                  child: Tooltip(
                    // tap to trigger tooltip
                    triggerMode: TooltipTriggerMode.tap,
                    message: "You are here!",
                    verticalOffset: 20,
                    preferBelow: false,
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    // decoration of tooltip
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    // image of marker pin
                    child: Image.asset('assets/images/location.png'),
                  ),
                )
              ]),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // button to get user's location when clicked
                  AppButton(
                    text: "Use Location",
                    onPressed: () async {
                      // show location prompt to access user's location
                      determinePosition();

                      final pos = await determinePosition();

                      // set the latitude and longitude of user after getting it's location
                      setState(() {
                        latitude = pos.latitude;
                        longitude = pos.longitude;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              )
            ],
          ),
        ));
  }
}
