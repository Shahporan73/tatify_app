// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/app_images/App_images.dart';
import 'package:tatify_app/res/common_widget/custom_button.dart';
import 'package:tatify_app/res/common_widget/custom_otp_widget.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/common_widget/main_app_bar.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/view/authenticate/view/restaurant_information_screen.dart';
import 'package:tatify_app/view/authenticate/view/sign_in_screen.dart';

class EmailVerificationScreen extends StatelessWidget {
  final bool? isVendor;
  const EmailVerificationScreen({super.key, this.isVendor=false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: MainAppBar(
        title: 'Email Verification',
        backgroundColor: AppColors.bgColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            heightBox50,
            Center(
              child: Image.asset(
                AppImages.emailVerificationLogo,
                scale: 4,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CustomText(
                title:'Please enter the 6 digit code that was sent toxyz@gmail.com ',
                color: AppColors.primaryColor,
                fontSize: 18,
              textAlign: TextAlign.center,
            ),

            heightBox50,

            CustomOtpWidget(pinColor: Colors.black,),

            heightBox20,
            Center(
              child: CustomText(
                title: 'Resend code',
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryColor,
                fontSize: 10,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.secondaryColor,
              ),
            ),

            heightBox50,
            CustomButton(
                title: 'Verify OTP',
                onTap: () {
                  if(isVendor==true){
                    Get.to(()=>RestaurantInformationScreen());
                  }else if(isVendor==false){
                    Get.to(()=>SignInScreen());
                  }
                },
            ),


          ],
        ),
      ),
    );
  }
}
