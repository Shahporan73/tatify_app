// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/res/app_images/App_images.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/view/user/user_profile/controller/my_profile_controller.dart';
import 'package:tatify_app/view/vendor/vendor_profile/controller/my_restaurant_controller.dart';

import '../../vendor_profile/controller/vendor_profile_controller.dart';

class VHomeHeaderWidget extends StatelessWidget {
  final String userName;
  final String restaurantName;
  const VHomeHeaderWidget({super.key, required this.userName, required this.restaurantName});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: Get.width,
      height: height / 4.8,
      padding: EdgeInsets.only(left: 16, right: 16, top: 26, bottom: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          gradient: LinearGradient(colors: [
            Color(0xffFF4F00B2).withOpacity(0.7),
            Color(0xffF04B6C),
          ])),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            AppImages.splashLogo,
            width: Get.width / 8,
            height: Get.height / 12,
          ),
          CustomText(
              title: 'Hi, $userName',
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500
          ),
          CustomText(
              title: 'Welcome to Taste Point ',
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500),
          heightBox5,
          Row(
            children: [
              Icon(
                Icons.restaurant_menu,
                color: Colors.white,
                size: 18,
              ),
              widthBox5,
              CustomText(
                title: restaurantName,
                fontSize: 14,
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
