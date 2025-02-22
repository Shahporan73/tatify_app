// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/res/common_widget/custom_app_bar.dart';
import 'package:tatify_app/res/common_widget/custom_button.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/view/user/user_profile/view/user_profile_edit_screen.dart';
import 'package:tatify_app/view/user/user_profile/widget/profile_item_widget.dart';
import '../../../../res/app_colors/App_Colors.dart';

class UserPersonalInformationScreen extends StatelessWidget {
  const UserPersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Stack(
        children: [
          // Header image
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
                  CustomAppBar(appBarName: 'Profile', titleColor: Colors.white, widget: SizedBox(),),
                  heightBox20,
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: AppColors.primaryColor,
                    backgroundImage: NetworkImage('https://static.vecteezy.com/system/resources/thumbnails/003/337/584/small/default-avatar-photo-placeholder-profile-icon-vector.jpg'),
                  ),
                  heightBox10,
                  CustomText(title: 'Istiak Ahmed', fontWeight: FontWeight.w600, color: Colors.white,fontSize: 18,)


                ],
              ),
            ),
          ),

          // details
          Positioned(
            top: height / 2.8,
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
                        title: 'Istiak Ahmed',
                        onTap: (){}
                    ),
                    ProfileItemWidget(
                        icon: Icons.calendar_month_outlined,
                        title: '23-16-2002',
                        onTap: (){}
                    ),

                    ProfileItemWidget(
                        icon: Icons.male_outlined,
                        title: 'Male',
                        onTap: (){}
                    ),
                    ProfileItemWidget(
                        icon: Icons.phone_outlined,
                        title: '+880 1234567890',
                        onTap: (){}
                    ),
                    ProfileItemWidget(
                        icon: Icons.email_outlined,
                        title: 'istaik@gmail.com',
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
                  Get.to(()=>UserProfileEditScreen());
                },
            ),

          ),
        ],
      ),
    );
  }
}
