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
import 'package:tatify_app/view/authenticate/widget/build_time_button_widget.dart';

import '../widget/opening_hour_widget.dart';

class ShowRestaurantInformationScreen extends StatefulWidget {
  const ShowRestaurantInformationScreen({super.key});

  @override
  State<ShowRestaurantInformationScreen> createState() => _ShowRestaurantInformationScreenState();
}

class _ShowRestaurantInformationScreenState extends State<ShowRestaurantInformationScreen> {
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

  final Set<String> _closedDays = {}; // Store closed days

  Future<void> _pickTime(BuildContext context, String day, bool isOpeningTime) async {
    if (_closedDays.contains(day)) return;

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

  void _toggleClosedDay(String day) {
    setState(() {
      if (_closedDays.contains(day)) {
        _closedDays.remove(day);
      } else {
        _closedDays.add(day);
      }
    });
  }

  final TextEditingController _controller = TextEditingController();
  final List<String> _tags = ['Burger', 'Meat'];

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
                    children: _tags.map((tag) {
                      return Chip(
                        label: Text(tag, style: TextStyle(color: Colors.grey[700])),
                        backgroundColor: Colors.green[50],
                        deleteIcon: Icon(Icons.close, size: 16, color: Colors.red),
                        onDeleted: () => _removeTag(tag),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                        fontSize: 14,
                      ),
                    ),
                    onSubmitted: _addTag,
                  ),
                ],
              ),
            ),
            heightBox10,
            Text('Opening Hours', style: customLabelStyle),
            SizedBox(height: 10),
            ListView(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              children: _openingTimes.keys.map((day) {
                return OpeningTimeTile(
                  day: day,
                  isClosed: _closedDays.contains(day),
                  openingTime: _openingTimes[day]!,
                  closingTime: _closingTimes[day]!,
                  onClosedToggle: (value) => _toggleClosedDay(day),
                  onPickOpeningTime: () => _pickTime(context, day, true),
                  onPickClosingTime: () => _pickTime(context, day, false),
                );
              }).toList(),
            ),


            heightBox20,
            CustomButton(
              title: 'Update',
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            heightBox20,
          ],
        ),
      ),
    );
  }
}
