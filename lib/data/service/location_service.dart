import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationServiceWithAddress {

  static Future<Map<String, dynamic>> getCurrentLocationWithAddress() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    // Check location permission status
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Get address from coordinates
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    Placemark place = placemarks.first;

    String fullAddress =
        "${place.name}, ${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}, ${place.postalCode}";

    return {
      'latitude': position.latitude,
      'longitude': position.longitude,
      'address': fullAddress,
    };
  }
}
