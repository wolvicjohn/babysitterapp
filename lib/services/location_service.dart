import 'dart:convert';
import 'package:geolocator/geolocator.dart';

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
// import 'package:latlong2/latlong.dart';

class LocationService {
  // allow location permissions and get users current location
  Future<Position> determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return position;
  }

  // get address from longitude and latitude via nominatim api of openstreetmap
  Future<String> getAddressFromCoordinates(LatLng? location) async {
    if (location == null) return 'Unknown Location';
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/reverse?lat=${location.latitude}&lon=${location.longitude}&format=json&addressdetails=1',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final address = data['address'];

        final street = address['road'] ?? '';
        final barangay = address['suburb'] ?? address['village'] ?? '';
        final city =
            address['city'] ?? address['town'] ?? address['municipality'] ?? '';

        return '${street.isNotEmpty ? street + ', ' : ''}'
            '${barangay.isNotEmpty ? 'Brgy. $barangay, ' : ''}'
            '$city City';
      } else {
        return 'Error: ${response.statusCode}';
      }
    } catch (e) {
      return 'Unknown Location';
    }
  }
}
