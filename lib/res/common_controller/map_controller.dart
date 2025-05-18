import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:tatify_app/data/api_client/end_point.dart';

class AddressSearchController extends GetxController {
  var isLoading = false.obs;
  var searchResults = <Map<String, dynamic>>[].obs;
  var currentLocation = Rx<Position?>(null);

  final Dio _dio = Dio();

  // Get current location
  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('Error', 'Location services are disabled.');
      return;
    }

    // Check location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        Get.snackbar('Error', 'Location permissions are denied');
        return;
      }
    }

    // Get current position
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Update currentLocation with the retrieved Position
      currentLocation.value = position;

      // You can access the position data
      print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
    } catch (e) {
      Get.snackbar('Error', 'Failed to get current location');
    }
  }

  // Search places
  Future<void> searchPlaces(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    isLoading.value = true;

    try {
      await getCurrentLocation();
      final response = await _dio.get(
        'https://maps.googleapis.com/maps/api/place/textsearch/json',
        queryParameters: {
          'query': query,
          'location': '${currentLocation.value?.latitude},${currentLocation.value?.longitude}',
          'radius': '10000', // Adjust radius as needed
          'key': EndPoint.MAP_KEY,
        },
      );

      if (response.statusCode == 200) {
        final results = response.data['results'];
        searchResults.value = List<Map<String, dynamic>>.from(results);
      } else {
        Get.snackbar('Error', 'Failed to fetch places');
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', 'Failed to fetch places');
    } finally {
      isLoading.value = false;
    }
  }

}
