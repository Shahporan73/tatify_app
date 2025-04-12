// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/common_widget/RoundTextField.dart';
import 'package:tatify_app/res/common_widget/custom_button.dart';
import 'package:tatify_app/res/common_widget/custom_dotted_widget.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/common_widget/main_app_bar.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/res/custom_style/custom_style.dart';
import 'package:tatify_app/view/authenticate/view/sign_in_screen.dart';
import 'package:tatify_app/view/authenticate/widget/build_time_button_widget.dart';
import 'package:tatify_app/view/vendor/vendor_home/views/vendor_home_dashboard.dart';

class RestaurantInformationScreen extends StatefulWidget {
  const RestaurantInformationScreen({super.key});

  @override
  State<RestaurantInformationScreen> createState() => _RestaurantInformationScreenState();
}

class _RestaurantInformationScreenState extends State<RestaurantInformationScreen> {

  final Map<String, TimeOfDay> _openingTimes = {
    "Monday": TimeOfDay(hour: 10, minute: 0),
    "Tuesday": TimeOfDay(hour: 10, minute: 0),
    "Wednesday": TimeOfDay(hour: 10, minute: 0),
    "Thursday": TimeOfDay(hour: 10, minute: 0),
    "Friday": TimeOfDay(hour: 10, minute: 0),
    "Saturday": TimeOfDay(hour: 10, minute: 0),
    "Sunday": TimeOfDay(hour: 10, minute: 0),
  };

  final Map<String, TimeOfDay> _closingTimes = {
    "Monday": TimeOfDay(hour: 23, minute: 0),
    "Tuesday": TimeOfDay(hour: 23, minute: 0),
    "Wednesday": TimeOfDay(hour: 23, minute: 0),
    "Thursday": TimeOfDay(hour: 23, minute: 0),
    "Friday": TimeOfDay(hour: 23, minute: 0),
    "Saturday": TimeOfDay(hour: 23, minute: 0),
    "Sunday": TimeOfDay(hour: 23, minute: 0),
  };

  Future<void> _pickTime(BuildContext context, String day, bool isOpeningTime) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: isOpeningTime ? _openingTimes[day]! : _closingTimes[day]!,
    );

    if (pickedTime != null) {
      setState(() {
        if (isOpeningTime) {
          _openingTimes[day] = pickedTime;
        } else {
          _closingTimes[day] = pickedTime;
        }
      });
    }
  }


  final TextEditingController _controller = TextEditingController();
  final List<String> _tags = ['Burger', 'meat'];

  void _addTag(String tag) {
    if (tag.isNotEmpty && !_tags.contains(tag)) {
      setState(() {
        _tags.add(tag);
      });
    }
    _controller.clear();
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: MainAppBar(title: 'Restaurant Information'),
      body: SingleChildScrollView(
        padding: bodyPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            CustomDottedWidget(
              containerHeight: height / 7,
              centerWidget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_upload_outlined, color: AppColors.primaryColor,),
                  widthBox5,
                  CustomText(title: 'Upload restaurant photo', fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.secondaryColor,)
                ],
              ),
            ),

            heightBox10,
            Text('Kitchen Style', style: customLabelStyle,),
            heightBox10,
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
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
                    children: _tags.map((tag) {
                      return Chip(
                        label: Text(tag, style: TextStyle(color: Colors.grey[700])),
                        backgroundColor: Colors.green[50],
                        deleteIcon: Icon(Icons.close, size: 16, color: Colors.red),
                        onDeleted: () => _removeTag(tag),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      );
                    }).toList(),
                  ),
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Enter style and press Enter',
                      border: InputBorder.none,
                      hintStyle: GoogleFonts.urbanist(
                          color: Color(0xff595959),
                          fontWeight: FontWeight.w400,
                          fontSize: 14
                      ),
                    ),
                    onSubmitted: _addTag,
                  ),
                ],
              ),
            ),

            heightBox10,
            Text('Restaurant Name', style: customLabelStyle,),
            heightBox10,
            RoundTextField(
                hint: 'Enter your restaurant name',
            ),

            heightBox10,
            Text('Restaurant Address', style: customLabelStyle,),
            heightBox10,
            RoundTextField(
                hint: 'Enter your restaurant address',
              prefixIcon: Icon(Icons.location_on_outlined),
            ),

            heightBox10,
            Text('City', style: customLabelStyle,),
            heightBox10,
            RoundTextField(
              hint: 'Enter your city name',
              prefixIcon: Icon(Icons.location_on_outlined),
            ),




            heightBox20,
            // opening time and close time
            Row(
              children: [
                Text("Opening Hours", style: customLabelStyle,),
                SizedBox(width: 8),
                Icon(Icons.access_time, size: 18),
              ],
            ),
            SizedBox(height: 10),
            ListView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              children: _openingTimes.keys.map((day) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(day, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                      Row(
                        children: [
                          BuildTimeButtonWidget(
                            day: day,
                            isOpeningTime: true,
                            time: _openingTimes[day]!,
                            onTap: () => _pickTime(context, day, true),
                          ),

                          SizedBox(width: 10),

                          BuildTimeButtonWidget(
                            day: day,
                            isOpeningTime: false,
                            time: _closingTimes[day]!,
                            onTap: () => _pickTime(context, day, false),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            heightBox20,
            CustomButton(
                title: 'Continue',
                onTap: (){
                  Get.to(()=> SignInScreen());
                }
            ),

            heightBox20,

          ],
        ),
      ),
    );
  }
}

