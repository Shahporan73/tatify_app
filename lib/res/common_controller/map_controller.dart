import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../data/api_client/end_point.dart';

class AddressSearchController extends GetxController {
  var isLoading = false.obs;
  var searchResults = <Map<String, dynamic>>[].obs;
  var currentLocation = Rx<Position?>(null);
  var selectedLocation = Rx<Position?>(null);

  final Dio _dio = Dio();

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('Error', 'Location services are disabled.');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        Get.snackbar('Error', 'Location permissions are denied');
        return;
      }
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      currentLocation.value = position;
      selectedLocation.value = position; // default selected = current
    } catch (e) {
      Get.snackbar('Error', 'Failed to get current location');
    }
  }

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
          'radius': '10000',
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
      Get.snackbar('Error', 'Failed to fetch places');
    } finally {
      isLoading.value = false;
    }
  }
}
