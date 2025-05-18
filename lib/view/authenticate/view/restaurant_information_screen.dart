// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatify_app/data/service/location_service.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/common_widget/RoundTextField.dart';
import 'package:tatify_app/res/common_widget/custom_button.dart';
import 'package:tatify_app/res/common_widget/custom_dotted_widget.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/common_widget/main_app_bar.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/res/custom_style/custom_style.dart';
import 'package:tatify_app/view/authenticate/controller/restaurant_controller.dart';
import '../../../data/service/get_current_postion.dart';
import '../../vendor/vendor_profile/widget/opening_hour_widget.dart';

class RestaurantInformationScreen extends StatefulWidget {
  const RestaurantInformationScreen({super.key});

  @override
  State<RestaurantInformationScreen> createState() =>
      _RestaurantInformationScreenState();
}

class _RestaurantInformationScreenState extends State<RestaurantInformationScreen> {
  final RestaurantController controller = Get.put(RestaurantController());

  // Helper function to convert TimeOfDay to 24-hour format
  String formatTo24Hour(TimeOfDay time) {
    final hour = time.hour;
    final minute = time.minute;
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  Future<void> _pickTime(BuildContext context, String day, bool isOpeningTime) async {
    if (controller.closedDays.contains(day)) return;

    TimeOfDay initial = isOpeningTime
        ? (controller.openingTimes[day] ?? TimeOfDay(hour: 0, minute: 0))
        : (controller.closingTimes[day] ?? TimeOfDay(hour: 0, minute: 0));

    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initial,
    );

    if (pickedTime != null) {
      setState(() {
        if (isOpeningTime) {
          controller.openingTimes[day] = pickedTime;
        } else {
          controller.closingTimes[day] = pickedTime;
        }
      });
    }
  }

  void _toggleClosedDay(String day) {
    setState(() {
      if (controller.closedDays.contains(day)) {
        controller.closedDays.remove(day);
      } else {
        controller.closedDays.add(day);
      }
    });
  }

  // Function to validate inputs before continuing
  bool _validateInputs() {
    if (controller.restaurantNameController.text.trim().isEmpty) {
      Get.rawSnackbar(message: 'Restaurant name is required');
      return false;
    }
    if (controller.addressController.text.trim().isEmpty) {
      Get.rawSnackbar(message: 'Restaurant address is required');
      return false;
    }
    if (controller.cityController.text.trim().isEmpty) {
      Get.rawSnackbar(message: 'City is required');
      return false;
    }
    // Validate opening and closing times
    for (var day in controller.openingTimes.keys) {
      if (!controller.closedDays.contains(day)) {
        var openingTime = controller.openingTimes[day];
        var closingTime = controller.closingTimes[day];
        if (openingTime == null || closingTime == null) {
          Get.rawSnackbar(message: 'Opening and Closing times must be set for $day');
          return false;
        }
      }
    }
    return true;
  }


  double? latitude;
  double? longitude;

  @override
  void initState() {
    super.initState();
    _getLocationData();
  }

  Future<void> _getLocationData() async {
    try {
      var location = await LocationServiceWithAddress.getCurrentLocationWithAddress();
      print('Latitude: ${location['latitude']}');
      print('Longitude: ${location['longitude']}');
      print('Address: ${location['address']}');

      setState(() {
        latitude = location['latitude'];
        longitude = location['longitude'];
      });

      controller.addressController.text = location['address'];
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: const MainAppBar(title: 'Restaurant Information'),
      body: SingleChildScrollView(
        padding: bodyPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => controller.pickedImage.value != null
                ? GestureDetector(
              onTap: controller.pickImage,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  controller.pickedImage.value!,
                  height: height / 4,
                  width: Get.width,
                  fit: BoxFit.cover,
                ),
              ),
            )
                : CustomDottedWidget(
              containerHeight: height / 4,
              centerWidget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_upload_outlined, color: AppColors.primaryColor),
                  widthBox5,
                  CustomText(
                    title: 'Upload restaurant photo',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondaryColor,
                  ),
                ],
              ),
              onTap: controller.pickImage,
            )),
            heightBox10,
            Text('Kitchen Style', style: customLabelStyle),
            heightBox10,
            Obx(() => Container(
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      );
                    }).toList(),
                  ),
                  TextField(
                    controller: controller.kitchenStyleController,
                    decoration: InputDecoration(
                      hintText: 'Enter style and press Enter',
                      border: InputBorder.none,
                      hintStyle: GoogleFonts.urbanist(
                        color: Color(0xff595959),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    onSubmitted: controller.addTag,
                  ),
                ],
              ),
            )),
            heightBox10,
            Text('Restaurant Name', style: customLabelStyle),
            heightBox10,
            RoundTextField(
              hint: 'Enter your restaurant name',
              controller: controller.restaurantNameController,
            ),
            heightBox10,
            Text('Restaurant Address', style: customLabelStyle),
            heightBox10,
            RoundTextField(
              hint: 'Enter your restaurant address',
              controller: controller.addressController,
              prefixIcon: Icon(Icons.location_on_outlined),
              readOnly: false,
            ),
            heightBox10,
            Text('City', style: customLabelStyle),
            heightBox10,
            RoundTextField(
              hint: 'Enter your city name',
              controller: controller.cityController,
              prefixIcon: Icon(Icons.location_on_outlined),
            ),
            heightBox20,
            Row(
              children: [
                Text("Opening Hours", style: customLabelStyle),
                SizedBox(width: 8),
                Icon(Icons.access_time, size: 18),
              ],
            ),
            SizedBox(height: 10),
            ListView(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              children: controller.openingTimes.keys.map((day) {
                return OpeningTimeTile(
                  day: day,
                  isClosed: controller.closedDays.contains(day),
                  openingTime: controller.openingTimes[day] ?? TimeOfDay(hour: 0, minute: 0),
                  closingTime: controller.closingTimes[day] ?? TimeOfDay(hour: 0, minute: 0),
                  onClosedToggle: (_) => _toggleClosedDay(day),
                  onPickOpeningTime: () => _pickTime(context, day, true),
                  onPickClosingTime: () => _pickTime(context, day, false),
                );
              }).toList(),
            ),
            heightBox20,
            Obx(
                  () => CustomButton(
                title: 'Continue',
                isLoading: controller.isLoading.value,
                onTap: () {
                  if (_validateInputs()) {
                    controller.createRestaurant(longitude: longitude ?? 0.0, latitude: latitude ?? 0.0);
                  }
                },
              ),
            ),
            heightBox20,
          ],
        ),
      ),
    );
  }
}
