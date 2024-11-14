import 'package:babysitterapp/controller/userdata.dart';
import 'package:babysitterapp/styles/colors.dart';
import 'package:babysitterapp/styles/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../services/location_service.dart';

class BabysitterViewLocation extends StatefulWidget {
  const BabysitterViewLocation({super.key});

  @override
  State<BabysitterViewLocation> createState() => _BabysitterViewLocationState();
}

class _BabysitterViewLocationState extends State<BabysitterViewLocation> {
  LocationService locationService = LocationService();
  UserData clientData = UserData();

  // directions
  final List<LatLng> routePoints = [];
  final LatLng start = const LatLng(7.306836, 125.680799);
  final LatLng end = const LatLng(7.300404, 125.668729);

  @override
  void initState() {
    super.initState();
    loadRoute();
  }

  // text style widget
  var textStyle = const TextStyle(fontSize: 12);
  var textOverflow = TextOverflow.ellipsis;

  @override
  Widget build(BuildContext context) {
    // appBar design
    const double appBarTitleSize = 18.0;
    const double leadingButtonPadding = 10.0;

    var appBarTitle = const Text("Client Destination",
        style: TextStyle(
            color: textColor,
            fontSize: appBarTitleSize,
            fontWeight: FontWeight.w500));

    var appBar = AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: appBarTitle,
      leading: Padding(
        padding: const EdgeInsets.only(left: leadingButtonPadding),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.purple.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.deepPurple,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      body: SizedBox(
        height: sizeConfig.heightSize(context),
        child: routePoints.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  FlutterMap(
                    options: MapOptions(
                        initialCenter: end, initialZoom: 14, minZoom: 14),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                        subdomains: const ['a', 'b', 'c'],
                      ),
                      // markers(start and end)
                      _directionsMarker(),
                      // polyline for directions
                      _drawPolyline()
                    ],
                  ),
                  // info container
                  _info()
                ],
              ),
      ),
    );
  }

  Widget _positionMarker({required IconData icon, double widthHeight = 35}) {
    return Stack(
      children: [
        Positioned(
            bottom: 35,
            left: 0,
            right: 0,
            child: Icon(
              icon,
              size: widthHeight,
            )),
      ],
    );
  }

  // markers for directions
  Widget _directionsMarker() {
    const double widthHeight = 70;
    return MarkerLayer(
      markers: [
        Marker(
            point: start,
            width: widthHeight,
            height: widthHeight,
            child: _positionMarker(icon: Icons.person)),
        Marker(
          point: end,
          width: widthHeight,
          height: widthHeight,
          child: _positionMarker(icon: Icons.home),
        ),
      ],
    );
  }

  // draw polyline layer
  Widget _drawPolyline() {
    return PolylineLayer(
      polylines: [
        Polyline(
          points: routePoints,
          strokeWidth: 4.0,
          color: Colors.purple,
        ),
      ],
    );
  }

  // info container
  Widget _info() {
    return Positioned(
      bottom: 25,
      left: 0,
      right: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              width: sizeConfig.widthSize(context),
              height: sizeConfig.heightSize(context) / 8,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 6.0,
                    spreadRadius: 1.0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 40,
                      backgroundImage: NetworkImage(
                          "https://franchisematch.com/wp-content/uploads/2015/02/john-doe.jpg"),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Client Information:",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 12),
                          ),
                          Text(
                            clientData.currentUser.name,
                            style: textStyle,
                            overflow: textOverflow,
                          ),
                          Text(
                            clientData.currentUser.email,
                            overflow: textOverflow,
                            style: textStyle,
                          ),
                          // FutureBuilder(
                          //   future: locationService
                          //       .getAddressFromCoordinates(
                          //     const LatLng(7.30215, 125.68145),
                          //   ),
                          //   builder: (context, snapshot) {
                          //     if (snapshot.connectionState ==
                          //         ConnectionState.waiting) {
                          //       return Text(
                          //         'Loading...',
                          //         style: textStyle,
                          //         overflow: textOverflow,
                          //         maxLines: 1,
                          //       );
                          //     }
                          //     return Text(
                          //       snapshot.data.toString(),
                          //       overflow: textOverflow,
                          //       style: textStyle,
                          //     );
                          //   },
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // load route to display in map
  Future<void> loadRoute() async {
    try {
      final routePoints = await locationService.fetchRoute(
          '${start.longitude},${start.latitude}',
          '${end.longitude},${end.latitude}');
      setState(() {
        this.routePoints.clear();
        this.routePoints.addAll(routePoints);
      });
    } catch (e) {
      print('Error fetching route: $e');
    }
  }
}
