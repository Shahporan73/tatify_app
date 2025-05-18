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

import '../../../user/user_profile/controller/my_profile_controller.dart';
import '../controller/vendor_profile_controller.dart';

class VendorProfileEditScreen extends StatelessWidget {
  final String profileImage;
  final String fullName;
  final String phoneNumber;
  final String gander;
  final String dateOfBirth;
  final String email;
  final String id;
  VendorProfileEditScreen(
      {super.key,
      required this.profileImage,
      required this.fullName,
      required this.phoneNumber,
      required this.gander,
      required this.dateOfBirth,
      required this.email,
      required this.id});


  final UserProfileController userProfileController = Get.put(UserProfileController());
  final VendorProfileController myProfileController = Get.put(VendorProfileController());


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    userProfileController.nameController.text = fullName;
    userProfileController.phoneController.text = phoneNumber;
    userProfileController.emailController.text = email;
    userProfileController.dobController.text = dateOfBirth;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: MainAppBar(title: 'Edit profile'),
      body: SingleChildScrollView(
        padding: bodyPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Obx(() {
                // Use the reactive `imagePath` from the controller
                String? image = myProfileController.imagePath.value;

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
                                : NetworkImage(
                              profileImage.isNotEmpty
                                  ? profileImage
                                  : placeholderImage,
                            ) as ImageProvider,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: GestureDetector(
                          onTap: myProfileController.pickImage, // Trigger image picking
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
              controller: userProfileController.nameController,
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
              controller: userProfileController.phoneController,
              prefixIcon: Icon(
                Icons.phone,
                color: Colors.grey,
              ),
            ),

            heightBox10,
            Text(
              'Gender',
              style: customLabelStyle,
            ),
            heightBox5,
            Obx(() => CustomDropDownWidget(
              selectedValue: myProfileController.gender.value.isNotEmpty
                  ? myProfileController.gender.value
                  : null,
              items: ['male', "female", 'other'],
              onChanged: (value) {
                myProfileController.gender.value = value ?? '';
              },
              hintText: "gander",
            )),

            heightBox10,
            Text(
              'Date of birth',
              style: customLabelStyle,
            ),
            heightBox5,
            RoundTextField(
              onTap: () {
                userProfileController.pickDate(context); // Trigger date picker
              },
              controller: userProfileController.dobController,
              hint: 'Select your date of birth',
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
              controller: userProfileController.emailController,
              readOnly: true,
              prefixIcon: Icon(
                Icons.email,
                color: Colors.grey,
              ),
            ),

            heightBox20,
            Obx(
                  () => CustomButton(
                title: "Update",
                isLoading: myProfileController.isLoading.value,
                onTap: () {
                  print('id $id');
                  myProfileController.updateProfile(
                      fullName: userProfileController.nameController.text,
                      dateOfBirth: userProfileController.dobController.text,
                      gender: myProfileController.gender.value,
                      phoneNumber: userProfileController.phoneController.text,
                      email: userProfileController.emailController.text,
                      id: id,
                      context: context
                  );
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
