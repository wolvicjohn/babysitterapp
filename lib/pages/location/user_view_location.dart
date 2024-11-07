import 'package:babysitterapp/components/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../controller/userdata.dart';
import '../../services/location_service.dart';
import '../../styles/colors.dart';
import '../../styles/size.dart';

class UserViewLocation extends StatefulWidget {
  const UserViewLocation({super.key});

  @override
  State<UserViewLocation> createState() => _UserViewLocationState();
}

class _UserViewLocationState extends State<UserViewLocation> {
  // show info container
  bool showContainer = false;
  // call services and model
  LocationService locationService = LocationService();
  UserData clientData = UserData();

  // locations
  final LatLng center = const LatLng(7.306836, 125.680799);
  final LatLng babysitterLoc = const LatLng(7.300404, 125.668729);

  // styles widgets
  var textStyle = const TextStyle(fontSize: 12);
  var textOverflow = TextOverflow.ellipsis;

  @override
  Widget build(BuildContext context) {
    // appBar design
    const double kAppBarTitleSize = 18.0;
    const double kAppBarBorderRadius = 20.0;
    const double kLeadingButtonPadding = 10.0;
    const double kHorizontalPadding = 3.0;

    var appBar = AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Text(
        "Babysitters Nearby",
        style: TextStyle(
          color: textColor,
          fontSize: kAppBarTitleSize,
          fontWeight: FontWeight.w500,
        ),
      ),
      flexibleSpace: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(kAppBarBorderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 6.0,
                spreadRadius: 1.0,
                offset: const Offset(0, 3),
              ),
            ],
          ),
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(left: kLeadingButtonPadding),
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
        child: Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                  initialCenter: center, initialZoom: 14, minZoom: 14),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                // markers(start and end)
                _buildMarkers(),
                // information container
                _buildInformation()
              ],
            ),
          ],
        ),
      ),
    );
  }

  // set state of container to show/hide it
  void _showContainer() {
    setState(() {
      showContainer = !showContainer;
    });
  }

  // map markers
  Widget _buildMarkers() {
    return MarkerLayer(
      markers: [
        Marker(
          point: babysitterLoc,
          child: IconButton(
            onPressed: _showContainer,
            icon: const Icon(
              Icons.baby_changing_station,
            ),
          ),
        ),
        Marker(
          point: center,
          child: IconButton(
            onPressed: _showContainer,
            icon: const Icon(
              Icons.baby_changing_station,
            ),
          ),
        ),
      ],
    );
  }

  // information container
  Widget _buildInformation() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      bottom: showContainer ? 25 : -200,
      left: 0,
      right: 0,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: showContainer ? 1.0 : 0.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            width: sizeConfig.widthSize(context),
            height: sizeConfig.heightSize(context) / 6,
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
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 40,
                    backgroundImage: NetworkImage(
                      "https://franchisematch.com/wp-content/uploads/2015/02/john-doe.jpg",
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Babysitter Information:",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
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
                          ],
                        ),
                        AppButton(
                          text: "Book Now",
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
