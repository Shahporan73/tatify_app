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
import 'package:tatify_app/res/common_widget/custom_button.dart';
import 'package:tatify_app/res/common_widget/custom_drop_down_widget.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/common_widget/main_app_bar.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/res/custom_style/custom_style.dart';
import 'package:tatify_app/view/user/user_profile/controller/profile_controller.dart';

import '../../../user/user_profile/controller/my_profile_controller.dart';
import '../controller/vendor_profile_controller.dart';

class VendorProfileEditScreen extends StatelessWidget {
  final String profileImage;
  final String fullName;
  final String phoneNumber;
  final String gander;
  final String dateOfBirth;
  final String address;
  final String email;
  final String id;
  VendorProfileEditScreen({
    super.key,
    required this.profileImage,
    required this.fullName,
    required this.phoneNumber,
    required this.gander,
    required this.dateOfBirth,
    required this.email,
    required this.id,
    required this.address,
  });

  final UserProfileController userProfileController = Get.put(UserProfileController());
  final VendorProfileController myProfileController = Get.put(VendorProfileController());

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    // Initialize fields with passed data on each build (consider better initialization in real app)
    userProfileController.nameController.text = fullName;
    userProfileController.phoneController.text = phoneNumber;
    userProfileController.emailController.text = email;
    userProfileController.dobController.text = dateOfBirth;
    userProfileController.addressController.text = address;
    myProfileController.gender.value = gander;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: MainAppBar(title: 'edit_profile'.tr),
      body: SingleChildScrollView(
        padding: bodyPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Obx(() {
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
                            backgroundImage: image != null && image.isNotEmpty
                                ? FileImage(File(image))
                                : NetworkImage(
                              profileImage.isNotEmpty ? profileImage : placeholderImage,
                            ) as ImageProvider,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: GestureDetector(
                          onTap: myProfileController.pickImage,
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

            heightBox20,
            CustomText(title: 'full_name'.tr, style: customLabelStyle),
            heightBox5,
            RoundTextField(
              hint: 'enter_full_name'.tr,
              controller: userProfileController.nameController,
              prefixIcon: Icon(Icons.person, color: Colors.grey),
            ),

            heightBox10,
            CustomText(title: 'phone_number'.tr, style: customLabelStyle),
            heightBox5,
            RoundTextField(
              hint: 'enter_phone_number'.tr,
              controller: userProfileController.phoneController,
              prefixIcon: Icon(Icons.phone, color: Colors.grey),
            ),

            heightBox10,
            CustomText(title: 'gender'.tr, style: customLabelStyle),
            heightBox5,
            Obx(() => CustomDropDownWidget(
              selectedValue: myProfileController.gender.value.isNotEmpty
                  ? myProfileController.gender.value
                  : null,
              items: ['male', 'female', 'other'],
              onChanged: (value) {
                myProfileController.gender.value = value ?? '';
              },
              hintText: "select_gender".tr,
            )),

            heightBox10,
            CustomText(title: 'date_of_birth'.tr, style: customLabelStyle),
            heightBox5,
            RoundTextField(
              onTap: () => userProfileController.pickDate(context),
              controller: userProfileController.dobController,
              hint: 'select_date_of_birth'.tr,
              prefixIcon: Icon(Icons.calendar_month_outlined),
              readOnly: true,
            ),

            heightBox10,
            Text(
              'address'.tr,
              style: customLabelStyle,
            ),
            heightBox5,
            RoundTextField(
              hint: 'enter_your_address'.tr,
              controller: userProfileController.addressController,
              readOnly: false,
              prefixIcon: Icon(
                Icons.location_on,
                color: Colors.grey,
              ),
            ),

            heightBox10,
            CustomText(title: 'email'.tr, style: customLabelStyle),
            heightBox5,
            RoundTextField(
              hint: 'enter_email'.tr,
              controller: userProfileController.emailController,
              readOnly: true,
              prefixIcon: Icon(Icons.email, color: Colors.grey),
            ),

            heightBox20,
            Obx(() => CustomButton(
              title: "update".tr,
              isLoading: myProfileController.isLoading.value,
              onTap: () {
                if (userProfileController.nameController.text.isEmpty ||
                    userProfileController.phoneController.text.isEmpty ||
                    myProfileController.gender.value.isEmpty ||
                    userProfileController.dobController.text.isEmpty||
                    userProfileController.addressController.text.isEmpty) {
                  Get.rawSnackbar(message: "please_fill_all_the_fields".tr);
                  return;
                }

                myProfileController.updateProfile(
                  fullName: userProfileController.nameController.text,
                  dateOfBirth: userProfileController.dobController.text,
                  gender: myProfileController.gender.value,
                  phoneNumber: userProfileController.phoneController.text,
                  address: userProfileController.addressController.text,
                  id: id,
                  context: context,
                );
              },
            )),
            heightBox20,
          ],
        ),
      ),
    );
  }
}
