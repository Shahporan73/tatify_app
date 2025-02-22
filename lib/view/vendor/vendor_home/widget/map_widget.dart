import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tatify_app/res/app_images/App_images.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late GoogleMapController mapController;
  BitmapDescriptor? _customIcon;

  final LatLng restaurantLocation = LatLng(23.7678, 90.4125);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _loadCustomMarker();
  }

  Future<void> _loadCustomMarker() async {
    final ByteData byteData = await rootBundle.load(AppImages.customMarkerIcon);
    final Uint8List bytes = byteData.buffer.asUint8List();
    setState(() {
      _customIcon = BitmapDescriptor.fromBytes(bytes);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: restaurantLocation,
        zoom: 15.0,
      ),
      markers: {
        Marker(
          markerId: const MarkerId("restaurant"),
          position: restaurantLocation,
          infoWindow: const InfoWindow(title: "My Restaurant"),
          icon: _customIcon ?? BitmapDescriptor.defaultMarker, // Apply custom icon
        ),
      },
    );
  }
}
