// ignore_for_file: use_full_hex_values_for_flutter_colors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/res/app_images/App_images.dart';
import 'package:tatify_app/res/common_widget/custom_button.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/view/authenticate/view/sign_in_screen.dart';
import 'package:tatify_app/view/authenticate/view/sign_up_screen.dart';

import '../../../res/app_colors/App_Colors.dart';
import '../../../res/common_widget/custom_text.dart';
import 'onboarding_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        width: width * double.infinity,
        height: height * double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xffFFFAFB),
              const Color(0xFFFFD7C599),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.splashLogo,
              height: height / 4,
              width: width / 4,
              fit: BoxFit.contain,
            ),
            CustomText(
              title: 'Let’s get started!',
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: AppColors.blackColor,
            ),
            heightBox5,
            CustomText(
              title: 'Login to Stay healthy and fit',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColors.blackColor,
            ),
            heightBox20,
            CustomButton(
                title: 'Log In',
                onTap: () {
                  Get.to(
                        () => SignInScreen(),
                  );
                }
            ),
            heightBox10,
            CustomButton(
                title: 'Sign Up',
                buttonColor: Colors.transparent,
                titleColor: AppColors.secondaryColor,
                border: Border.all(color: AppColors.secondaryColor),
                onTap: () {
                  Get.to(
                    () => SignUpScreen(),
                  );
                }
            ),
          ],
        ),
      ),
    );
  }
}
