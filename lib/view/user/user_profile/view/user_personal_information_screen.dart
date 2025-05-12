// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/res/app_const/app_const.dart';
import 'package:tatify_app/res/common_widget/custom_app_bar.dart';
import 'package:tatify_app/res/common_widget/custom_button.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/view/user/user_profile/controller/my_profile_controller.dart';
import 'package:tatify_app/view/user/user_profile/view/user_profile_edit_screen.dart';
import 'package:tatify_app/view/user/user_profile/widget/profile_item_widget.dart';
import '../../../../res/app_colors/App_Colors.dart';

class UserPersonalInformationScreen extends StatelessWidget {
  const UserPersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MyProfileController controller = Get.put(MyProfileController());

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Obx(
        ()=> Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                height: height / 2,
                padding: EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 16),
                decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25)
                    )
                ),
                child: Column(
                  children: [
                    CustomAppBar(appBarName: 'Personal Information', titleColor: Colors.white, leadingColor: Colors.white,),
                    heightBox20,
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: AppColors.primaryColor,
                      backgroundImage: NetworkImage(
                        controller.profileImage.value.isNotEmpty ? controller.profileImage.value :
                        placeholderImage,
                      ),
                    ),

                  ],
                ),
              ),
            ),

            // details
            Positioned(
              top: height / 3,
              left: 16,
              right: 22,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 1)
                      )
                    ]
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ProfileItemWidget(
                          icon: Icons.person_outline,
                          title: controller.fullName.value.isNotEmpty ? controller.fullName.value : 'User name',
                          onTap: (){}
                      ),
                      ProfileItemWidget(
                          icon: Icons.calendar_month_outlined,
                          title: controller.dateOfBirth.value.isNotEmpty ? controller.dateOfBirth.value : 'Not found',
                          onTap: (){}
                      ),

                      ProfileItemWidget(
                          icon: Icons.male_outlined,
                          title: controller.gender.value.isNotEmpty ? controller.gender.value : 'Not found',
                          onTap: (){}
                      ),
                      ProfileItemWidget(
                          icon: Icons.phone_outlined,
                          title: controller.phoneNumber.value.isNotEmpty ? controller.phoneNumber.value : 'Not found',
                          onTap: (){}
                      ),
                      ProfileItemWidget(
                          icon: Icons.email_outlined,
                          title: controller.email.value.isNotEmpty ? controller.email.value : 'Not found',
                          onTap: (){}
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Header image
            Positioned(
              bottom: 16,
              right: 16,
              left: 16,
              child: CustomButton(
                    title: 'Edit',
                    onTap: () {
                      print('edit');
                      Get.to(()=>UserProfileEditScreen(
                          profileImage: controller.profileImage.value,
                          fullName: controller.fullName.value,
                          phoneNumber: controller.phoneNumber.value,
                          gander: controller.gender.value,
                          dateOfBirth: controller.dateOfBirth.value,
                          email: controller.email.value,
                          id: controller.id.value,
                        ),
                      );
                    },
                ),
            ),
          ],
        ),
      ),
    );
  }
}
