// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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

  Future<void> _getLocationData() async {
    try {
      var location = await LocationServiceWithAddress.getCurrentLocationWithAddress();
      print('Latitude: ${location['latitude']}');
      print('Longitude: ${location['longitude']}');
      print('Address: ${location['address']}');

      setState(() {
        controller.latitude.value = location['latitude'];
        controller.longitude.value = location['longitude'];
      });
      controller.addressController.text = location['address'];
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: MainAppBar(title: 'Restaurant Information'),
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
              Text('Kitchen Style', style: customLabelStyle),
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
                      controller: TextEditingController(),
                      decoration: InputDecoration(
                        hintText: 'Enter style and press Enter',
                        border: InputBorder.none,
                        hintStyle: GoogleFonts.urbanist(
                          color: Color(0xff595959),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      onSubmitted: (tag) {
                        controller.addTag(tag);
                      },
                    ),
                  ],
                ),
              ),
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
                readOnly: true,
                onTap: () {
                  CustomAlertDialog().customAlert(
                      context: context,
                      title: 'Warning',
                      message: 'Are you sure you want to update your address?',
                      NegativebuttonText: "No",
                      PositivvebuttonText: "Yes",
                      onNegativeButtonPressed: () {
                        print('No');
                        Navigator.pop(context);
                      },
                      onPositiveButtonPressed: () {
                        _getLocationData();
                        Navigator.pop(context);
                      }
                  );
                  // showSearchDialog(context);
                },
              ),
              heightBox10,
              Text('City', style: customLabelStyle),
              heightBox10,
              RoundTextField(
                hint: 'Enter your city name',
                controller: controller.cityController,
                prefixIcon: Icon(Icons.location_on_outlined),
              ),
              heightBox10,
              Text('Opening Hours', style: customLabelStyle),
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
                title: 'Update',
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
