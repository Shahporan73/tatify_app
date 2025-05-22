// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tatify_app/data/utils/custom_loader.dart';
import 'package:tatify_app/res/app_const/app_const.dart';
import 'package:tatify_app/res/app_images/App_images.dart';
import 'package:tatify_app/res/common_widget/custom_button.dart';
import 'package:tatify_app/res/common_widget/custom_network_image_widget.dart';
import 'package:tatify_app/view/user/user_discover/view/user_filter_bottom_sheet.dart';
import 'package:tatify_app/view/user/user_discover/view/user_select_city_screen.dart';
import 'package:tatify_app/view/user/user_home/controller/home_controller.dart';
import 'package:tatify_app/view/user/user_home/controller/single_restaurant_controller.dart';
import 'package:tatify_app/view/user/user_home/view/user_restaurant_details_screen.dart';

class UserDiscoverScreen extends StatefulWidget {
  @override
  _UserDiscoverScreenState createState() => _UserDiscoverScreenState();
}

class _UserDiscoverScreenState extends State<UserDiscoverScreen> {
  final HomeController restaurantController = Get.put(HomeController());
  final SingleRestaurantController singleRestaurantController = Get.put(SingleRestaurantController());
  GoogleMapController? mapController;
  LatLng? _initialPosition;
  BitmapDescriptor? _customIcon;

  @override
  void initState() {
    super.initState();
    _determinePosition();
    _loadCustomMarker();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('Location Disabled', 'Please enable location services');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        Get.snackbar('Permission Denied', 'Location permission denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar('Permission Denied', 'Location permissions are permanently denied');
      return;
    }

    final position = await Geolocator.getCurrentPosition();

    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
    });

    if (mapController != null) {
      mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: _initialPosition!, zoom: 15),
        ),
      );
    }
  }

  Future<void> _loadCustomMarker() async {
    final ByteData byteData = await rootBundle.load(AppImages.customMarkerIcon);
    final Uint8List bytes = byteData.buffer.asUint8List();
    _customIcon = BitmapDescriptor.fromBytes(bytes);
    setState(() {}); // Update UI after loading icon
  }

  Set<Marker> getMarkers() {
    if (_customIcon == null) return {};

    final List<Marker> markers = [];

    for (var i = 0; i < restaurantController.nearbyRestaurantList.length; i++) {
      final restaurant = restaurantController.nearbyRestaurantList[i];

      if (restaurant.location == null ||
          restaurant.location!.coordinates.length < 2) continue;

      final longitude = restaurant.location!.coordinates[0];
      final latitude = restaurant.location!.coordinates[1];

      markers.add(
        Marker(
          markerId: MarkerId(restaurant.id ?? 'marker_$i'),
          position: LatLng(latitude, longitude),
          icon: _customIcon!,
          onTap: () => showBottomSheet(
              restaurantImageUrl: restaurant.featureImage ?? '',
              restaurantName: restaurant.name ?? '',
              reviews: restaurant.review?.total?.toStringAsFixed(0) ?? '0',
              rating: restaurant.review?.star?.toStringAsFixed(1) ?? '0.0',
              distance: restaurant.distance?.toStringAsFixed(0) ?? '',
            onTap: () {
              singleRestaurantController.getSingleRestaurant(restaurantId: restaurant.id ?? '').then((value) {
                Get.to(()=> UserRestaurantDetailsScreen(restaurantId: restaurant.id ?? '',));
              },);
            },
          ),
          infoWindow: InfoWindow(title: restaurant.name),
        ),
      );
    }
    return markers.toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (restaurantController.isLoading.value ||
              _initialPosition == null ||
              _customIcon == null) {
            return Center(child: CustomLoader());
          }
          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: _initialPosition!, zoom: 15),
                markers: getMarkers(),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                onMapCreated: (controller) {
                  mapController = controller;
                  if (_initialPosition != null) {
                    mapController!.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(target: _initialPosition!, zoom: 15),
                      ),
                    );
                  }
                },
              ),
              Positioned(
                bottom: 16,
                left: Get.width / 6,
                right: Get.width / 6,
                child: Container(
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
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                              ),
                              builder: (context) => const UserFilterBottomSheet(),
                            );
                          },
                        ),
                      ),
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
                            Get.to(() => UserSelectCityScreen());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  void showBottomSheet({
    required String restaurantImageUrl,
    required String restaurantName,
    required String reviews,
    required String rating,
    required String distance,
    required VoidCallback onTap
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return InkWell(
          onTap: onTap,
          child: Container(
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
                    child: CustomNetworkImage(
                      imageUrl: restaurantImageUrl.isNotEmpty
                          ? restaurantImageUrl
                          : placeholderImage,
                      fit: BoxFit.cover,
                      width: 60,
                      height: 60,
                    ),
                  ),
                  title: Text(restaurantName,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange, size: 18),
                      SizedBox(width: 4),
                      Text("$rating ($reviews)"),
                      SizedBox(width: 8),
                      Icon(Icons.location_on, color: Colors.red, size: 18),
                      SizedBox(width: 4),
                      Text("$distance km"),
                    ],
                  ),
                ),
                /* Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "\$10 Discount",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "Free soft drink",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),*/
              ],
            ),
          ),
        );
      },
    );
  }
}
