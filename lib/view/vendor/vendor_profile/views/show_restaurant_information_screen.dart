// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tatify_app/data/utils/custom_loader.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/common_widget/RoundTextField.dart';
import 'package:tatify_app/res/common_widget/custom_button.dart';
import 'package:tatify_app/res/common_widget/main_app_bar.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/res/custom_style/custom_style.dart';
import 'package:tatify_app/view/vendor/vendor_profile/controller/my_restaurant_controller.dart';

import '../../../../data/service/location_service.dart';
import '../../../../res/common_widget/custom_alert_dialog.dart';
import '../widget/opening_hour_widget.dart';
import '../widget/restaurant_image_widget.dart';
import '../widget/show_search_dialog.dart';
import '../widget/update_location_dialog.dart';

class ShowRestaurantInformationScreen extends StatefulWidget {
  const ShowRestaurantInformationScreen({super.key});

  @override
  State<ShowRestaurantInformationScreen> createState() =>
      _ShowRestaurantInformationScreenState();
}

class _ShowRestaurantInformationScreenState
    extends State<ShowRestaurantInformationScreen> {
  final MyRestaurantController controller = Get.put(MyRestaurantController());

  Future<void> _pickTime(BuildContext context, String day, bool isOpeningTime) async {
    if (controller.openingHours[day]?['isClosed'] == true) return; // Prevent time selection if closed

    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: isOpeningTime
          ? TimeOfDay(
          hour: int.parse(controller.openingHours[day]?['openTime']?.split(":")[0] ?? "10"),
          minute: int.parse(controller.openingHours[day]?['openTime']?.split(":")[1] ?? "00"))
          : TimeOfDay(
          hour: int.parse(controller.openingHours[day]?['closeTime']?.split(":")[0] ?? "23"),
          minute: int.parse(controller.openingHours[day]?['closeTime']?.split(":")[1] ?? "00")),
    );

    if (pickedTime != null) {
      String newTime = "${pickedTime.hour}:${pickedTime.minute.toString().padLeft(2, '0')}";
      if (isOpeningTime) {
        controller.updateOpeningHour(day, newTime, controller.openingHours[day]?['closeTime'] ?? "23:00");
      } else {
        controller.updateOpeningHour(day, controller.openingHours[day]?['openTime'] ?? "10:00", newTime);
      }
    }
  }

  // double? latitude;
  // double? longitude;

  // Future<void> _getLocationData() async {
  //   try {
  //     var location = await LocationServiceWithAddress.getCurrentLocationWithAddress();
  //     print('Latitude: ${location['latitude']}');
  //     print('Longitude: ${location['longitude']}');
  //     print('Address: ${location['address']}');
  //
  //     setState(() {
  //       controller.latitude.value = location['latitude'];
  //       controller.longitude.value = location['longitude'];
  //     });
  //     controller.addressController.text = location['address'];
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }



  final TextEditingController kitchenStyleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: MainAppBar(title: 'restaurant_information'.tr),
      body: SingleChildScrollView(
        padding: bodyPadding,
        child: Obx(() {
          if (controller.isLoading.value) {
            return CustomLoader();
          }

          var data = controller.myRestaurantsModel.value.data;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Use the RestaurantImageWidget
              RestaurantImageWidget(
                pickedImage: controller.pickedImage,
                featureImage: data?.featureImage,
                onImagePick: () => controller.selectImage(),
              ),

              heightBox10,
              Text('kitchen_style'.tr, style: customLabelStyle),
              heightBox10,
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: controller.tags.map((tag) {
                        return Chip(
                          label: Text(tag, style: TextStyle(color: Colors.grey[700])),
                          backgroundColor: Colors.green[50],
                          deleteIcon: Icon(Icons.close, size: 16, color: Colors.red),
                          onDeleted: () => controller.removeTag(tag),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        );
                      }).toList(),
                    ),
                    TextField(
                      controller: kitchenStyleController,
                      decoration: InputDecoration(
                        hintText: 'enter_style_and_press_enter'.tr,
                        border: InputBorder.none,
                        hintStyle: GoogleFonts.urbanist(
                          color: Color(0xff595959),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      onSubmitted: (tag) {
                        controller.addTag(tag);
                        kitchenStyleController.clear();
                      },
                    ),
                  ],
                ),
              ),
              heightBox10,
              Text('restaurant_name'.tr, style: customLabelStyle),
              heightBox10,
              RoundTextField(
                hint: 'enter_your_restaurant_name'.tr,
                controller: controller.restaurantNameController,
              ),


              heightBox10,
              Text('restaurant_address'.tr, style: customLabelStyle),
              heightBox10,
              RoundTextField(
                hint: 'enter_restaurant_address'.tr,
                controller: controller.addressController,
                readOnly: false,
                suffixIcon: IconButton(
                  icon: Icon(Icons.my_location, color: AppColors.primaryColor),
                  onPressed: () async {
                    final result = await Get.dialog<Map<String, dynamic>>(
                      UpdateLocationDialog(
                        initialLatitude: controller.latitude.value,
                        initialLongitude: controller.longitude.value,
                      ),
                    );

                    if (result != null) {
                      final LatLng updatedLatLng = result['latLng'];
                      final String updatedAddress = result['address'];

                      controller.addressController.text = updatedAddress;

                      controller.latitude.value = updatedLatLng.latitude;
                      controller.longitude.value = updatedLatLng.longitude;

                      print('Updated Address: $updatedAddress');
                      print('Latitude: ${updatedLatLng.latitude}, Longitude: ${updatedLatLng.longitude}');
                    }
                  },
                  splashRadius: 20,
                ),
              ),




              heightBox10,
              Text('city'.tr, style: customLabelStyle),
              heightBox10,
              RoundTextField(
                hint: 'enter_city_name'.tr,
                controller: controller.cityController,
                prefixIcon: Icon(Icons.location_on_outlined),
              ),
              heightBox10,
              Text('opening_hours'.tr, style: customLabelStyle),
              SizedBox(height: 10),
              ListView(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                children: controller.openingHours.keys.map((day) {
                  var openingTimeParts = controller.openingHours[day]?['openTime']?.split(":");
                  var closingTimeParts = controller.openingHours[day]?['closeTime']?.split(":");

                  TimeOfDay openingTime = TimeOfDay(
                    hour: int.parse(openingTimeParts?[0] ?? '00'),
                    minute: int.parse(openingTimeParts?[1] ?? '00'),
                  );

                  TimeOfDay closingTime = TimeOfDay(
                    hour: int.parse(closingTimeParts?[0] ?? '23'),
                    minute: int.parse(closingTimeParts?[1] ?? '00'),
                  );

                  return OpeningTimeTile(
                    day: day,
                    isClosed: controller.openingHours[day]?['isClosed'] ?? false,
                    openingTime: openingTime,
                    closingTime: closingTime,
                    onClosedToggle: (isClosed) {
                      controller.toggleClosedDay(day);
                    },
                    onPickOpeningTime: () => _pickTime(context, day, true),
                    onPickClosingTime: () => _pickTime(context, day, false),
                  );
                }).toList(),
              ),

              heightBox20,
              CustomButton(
                title: 'update'.tr,
                onTap: () {
                  controller.updateRestaurant(
                      // latitude: latitude ?? 0.0,
                      // longitude: longitude ?? 0.0,
                      context: context
                  );
                },
              ),
              heightBox20,
            ],
          );
        }),
      ),
    );
  }
}
