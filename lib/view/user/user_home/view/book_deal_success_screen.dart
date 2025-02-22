// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/app_images/App_images.dart';
import 'package:tatify_app/res/common_widget/custom_button.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/common_widget/lottie_loader_widget.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/view/user/user_home/view/home_dashboard.dart';

class BookDealSuccessScreen extends StatelessWidget {
  const BookDealSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Column(
        children: [
          SizedBox(
            height: Get.height / 6,
          ),
          LottieLoaderWidget(
            lottieAssetPath: AppImages.successAnim,
            height: Get.height / 3,
            width: Get.width / 2,
            repeat: true,
            reverse: false,
          ),
          heightBox10,
          CustomText(
            title: 'Deal booked!',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          heightBox20,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: CustomText(
              title: 'Enjoy your meal at Chicken Bericious',
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          heightBox5,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: CustomText(
              textAlign: TextAlign.center,
              title:
                  'Plus, be on time for your table reservation at the restaurant.',
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),

          Spacer(),
          CustomButton(
            width: Get.width / 1.1,
              title: 'Done',
              buttonColor: AppColors.secondaryColor,
              onTap: (){
                Get.offAll(()=> HomeDashboard());
              }
          ),
          heightBox20

        ],
      ),
    );
  }
}
