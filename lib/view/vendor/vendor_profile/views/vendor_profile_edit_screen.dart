// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/app_const/app_const.dart';
import 'package:tatify_app/res/app_images/App_images.dart';
import 'package:tatify_app/res/common_widget/RoundTextField.dart';
import 'package:tatify_app/res/common_widget/country_code_picker.dart';
import 'package:tatify_app/res/common_widget/custom_button.dart';
import 'package:tatify_app/res/common_widget/custom_checkbox.dart';
import 'package:tatify_app/res/common_widget/custom_drop_down_widget.dart';
import 'package:tatify_app/res/common_widget/custom_radio_button.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/common_widget/main_app_bar.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/res/custom_style/custom_style.dart';
import 'package:tatify_app/view/authenticate/controller/sign_up_controller.dart';
import 'package:tatify_app/view/authenticate/view/email_verification_screen.dart';
import 'package:tatify_app/view/authenticate/view/sign_in_screen.dart';
import 'package:tatify_app/view/user/user_profile/controller/profile_controller.dart';

class VendorProfileEditScreen extends StatelessWidget {
  VendorProfileEditScreen({super.key});
  final UserProfileController userProfileController = Get.put(UserProfileController());
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: MainAppBar(title: 'Edit profile'),
      body: SingleChildScrollView(
        padding: bodyPadding,
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Center(
              child: Obx(() {
                // Use the reactive `imagePath` from the controller
                String? image = userProfileController.imagePath.value;

                return CircleAvatar(
                  radius: 70,
                  child: Stack(
                    children: [
                      Positioned(
                        child: Center(
                          child: CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.grey,
                            backgroundImage: image != null
                                ? FileImage(File(image)) // Show selected image
                                : NetworkImage(placeholderImage) as ImageProvider,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: GestureDetector(
                          onTap: userProfileController.pickImage, // Trigger image picking
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Icon(Icons.camera_alt_outlined),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),

            Text(
              'Full name',
              style: customLabelStyle,
            ),
            heightBox5,
            RoundTextField(
              hint: 'Enter your full name',
              prefixIcon: Icon(
                Icons.person,
                color: Colors.grey,
              ),
            ),

            heightBox10,
            Text(
              'Number',
              style: customLabelStyle,
            ),
            heightBox5,
            RoundTextField(
              hint: 'Enter your phone number',
              prefixIcon: Icon(
                Icons.phone,
                color: Colors.grey,
              ),
            ),

            heightBox10,
            Text(
              'Gander',
              style: customLabelStyle,
            ),
            heightBox5,
            CustomDropDownWidget(
                selectedValue: 'Male',
                items: ['Male', "Female", 'Others'],
                onChanged: (value) {},
                hintText: "Male"
            ),

            heightBox10,
            Text(
              'Date of birth',
              style: customLabelStyle,
            ),
            heightBox5,
            RoundTextField(
              onTap: () {
                userProfileController.pickDate(context);
              },
              controller: userProfileController.dobController,
              hint: '25/22/2002',
              prefixIcon: Icon(Icons.calendar_month_outlined),
              readOnly: true,
            ),

            heightBox10,
            Text(
              'Email',
              style: customLabelStyle,
            ),
            heightBox5,
            RoundTextField(
              hint: 'Enter your email',
              readOnly: true,
              prefixIcon: Icon(
                Icons.email,
                color: Colors.grey,
              ),
            ),

            heightBox20,
            CustomButton(
                title: "Update",
                onTap: (){
                  Navigator.of(context).pop();
                  Get.rawSnackbar(message: 'Profile updated');
                }
            ),


            heightBox20,
          ],
        ),
      ),
    );
  }
}
