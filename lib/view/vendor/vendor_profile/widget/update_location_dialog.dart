import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';

import '../../../../res/app_colors/App_Colors.dart';
import '../../../../res/common_controller/map_controller.dart';
import '../../../../res/common_widget/custom_text.dart';

class UpdateLocationDialog extends StatefulWidget {
  final double initialLatitude;
  final double initialLongitude;

  const UpdateLocationDialog({
    Key? key,
    required this.initialLatitude,
    required this.initialLongitude,
  }) : super(key: key);

  @override
  _UpdateLocationDialogState createState() => _UpdateLocationDialogState();
}

class _UpdateLocationDialogState extends State<UpdateLocationDialog> {
  final AddressSearchController controller = Get.put(AddressSearchController());
  final TextEditingController searchController = TextEditingController();

  late GoogleMapController mapController;
  late LatLng pickedLocation;
  Marker? marker;
  String? addressName;

  @override
  void initState() {
    super.initState();
    pickedLocation = LatLng(widget.initialLatitude, widget.initialLongitude);
    _updateAddressName(pickedLocation);
    marker = Marker(
      markerId: MarkerId('picked_location'),
      position: pickedLocation,
      draggable: true,
      onDragEnd: (newPos) {
        setState(() {
          pickedLocation = newPos;
        });
        _updateAddressName(newPos);
      },
    );
  }

  Future<void> _updateAddressName(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        setState(() {
          addressName =
          "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
        });
      }
    } catch (e) {
      setState(() {
        addressName = "Unknown location";
      });
    }
  }

  Future<void> _searchAndMoveCamera(String query) async {
    try {
      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        final loc = locations.first;
        final newPosition = LatLng(loc.latitude, loc.longitude);

        setState(() {
          pickedLocation = newPosition;
          marker = Marker(
            markerId: MarkerId('picked_location'),
            position: newPosition,
            draggable: true,
            onDragEnd: (newPos) {
              setState(() {
                pickedLocation = newPos;
              });
              _updateAddressName(newPos);
            },
          );
        });

        mapController.animateCamera(
          CameraUpdate.newLatLngZoom(newPosition, 15),
        );

        await _updateAddressName(newPosition);
      } else {
        Get.snackbar('Error', 'No location found for "$query"');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to search location');
    }
  }

  void _onConfirm() {
    controller.selectedLocation.value = Position(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
      timestamp: DateTime.now(),
      accuracy: 0.0,
      altitude: 0.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0,
      altitudeAccuracy: 0.0,
      headingAccuracy: 0.0,
    );

    Get.back(result: {
      'latLng': pickedLocation,
      'address': addressName ?? '',
    });
  }

  @override
  Widget build(BuildContext context) {
    final initialCameraPosition = CameraPosition(target: pickedLocation, zoom: 15);

    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        width: double.maxFinite,
        height: Get.height / 1.2,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search location',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            _searchAndMoveCamera(searchController.text);
                          },
                        ),
                      ),
                      onSubmitted: _searchAndMoveCamera,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Get.back(),
                  )
                ],
              ),
            ),
            Expanded(
              child: GoogleMap(
                initialCameraPosition: initialCameraPosition,
                markers: marker != null ? {marker!} : {},
                onMapCreated: (controller) {
                  mapController = controller;
                },
                onTap: (pos) {
                  setState(() {
                    pickedLocation = pos;
                    marker = Marker(
                      markerId: MarkerId('picked_location'),
                      position: pos,
                      draggable: true,
                      onDragEnd: (newPos) {
                        setState(() {
                          pickedLocation = newPos;
                        });
                        _updateAddressName(newPos);
                      },
                    );
                  });
                  _updateAddressName(pos);
                },
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Address: ${addressName ?? "Loading..."}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  // SizedBox(height: 4),
                  // Text(
                  //   'Latitude: ${pickedLocation.latitude.toStringAsFixed(6)}, Longitude: ${pickedLocation.longitude.toStringAsFixed(6)}',
                  // ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor
                ),
                onPressed: _onConfirm,
                child: CustomText(title: 'Update Location', color: Colors.white,),
              ),
            )
          ],
        ),
      ),
    );
  }
}
