// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';
import 'package:tatify_app/res/app_images/App_images.dart';
import 'package:tatify_app/res/common_widget/custom_button.dart';
import 'package:tatify_app/view/user/user_discover/view/user_filter_bottom_sheet.dart';
import 'package:tatify_app/view/user/user_discover/view/user_select_city_screen.dart';

class UserDiscoverScreen extends StatefulWidget {
  @override
  _UserDiscoverScreenState createState() => _UserDiscoverScreenState();
}

class _UserDiscoverScreenState extends State<UserDiscoverScreen> {
  late GoogleMapController mapController;
  final LatLng _initialPosition = LatLng(12.9716, 77.5946); // Bangalore
  BitmapDescriptor? _customIcon;

  final List<LatLng> _locations = [
    LatLng(12.9718, 77.5944),
    LatLng(12.9720, 77.5950),
    LatLng(12.9705, 77.5935),
    LatLng(12.9698, 77.5960),
    LatLng(12.9688, 77.5942),
    LatLng(12.9735, 77.5920),
    LatLng(12.9736, 77.5921),
    LatLng(12.9734, 77.5925),
  ];

  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _loadCustomMarker();
  }

  Future<void> _loadCustomMarker() async {
    final ByteData byteData = await rootBundle.load(AppImages.customMarkerIcon);
    final Uint8List bytes = byteData.buffer.asUint8List();
    _customIcon = BitmapDescriptor.fromBytes(bytes);
    _loadMarkers();
  }

  void _loadMarkers() {
    if (_customIcon == null) return;

    for (var i = 0; i < _locations.length; i++) {
      _markers.add(
        Marker(
          markerId: MarkerId('marker_$i'),
          position: _locations[i],
          icon: _customIcon!,
          onTap: _showBottomSheet,
        ),
      );
    }
    setState(() {});
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          margin: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://t4.ftcdn.net/jpg/02/74/99/01/360_F_274990113_ffVRBygLkLCZAATF9lWymzE6bItMVuH1.jpg',
                    fit: BoxFit.cover,
                    width: 60,
                    height: 60,
                  ),
                ),
                title: Text("SPICETRAILS Altstadt",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange, size: 18),
                    SizedBox(width: 4),
                    Text("4.3 (17)"),
                    SizedBox(width: 8),
                    Icon(Icons.location_on, color: Colors.red, size: 18),
                    SizedBox(width: 4),
                    Text("2 km"),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text("\$10 Discount",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(width: 8),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text("Free soft drink",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: _initialPosition, zoom: 15),
              markers: _markers,
              onMapCreated: (controller) => mapController = controller,
            ),

            Positioned(
              bottom: 16,
                left: Get.width / 6,
                right: Get.width / 6,
                child:Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: CustomButton(
                          title: "Filter",
                        buttonColor: Colors.white,
                        borderRadius: 25,
                        widget: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.filter_list),
                            Text("Filter"),
                          ],
                        ),
                        onTap: () {
                          // Navigator.pop(context);
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                            builder: (context) {
                              return UserFilterBottomSheet();
                            },
                          );
                        },
                      ),),
                      Container(
                        width: 1,
                        height: Get.height / 15,
                        color: Colors.grey,
                      ),
                      Expanded(
                        child: CustomButton(
                          title: '',
                          buttonColor: Colors.white,
                          borderRadius: 25,
                        widget: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.list),
                            Text("List"),
                          ],
                        ),
                        onTap: () {
                          Get.to(()=> UserSelectCityScreen());
                        },
                        ),
                      ),
                    ],
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
