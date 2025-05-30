// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/data/utils/custom_loader.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/app_images/App_images.dart';
import 'package:tatify_app/res/common_widget/custom_button.dart';
import 'package:tatify_app/res/common_widget/custom_otp_widget.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/common_widget/main_app_bar.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/view/authenticate/controller/otp_controller.dart';
import 'package:tatify_app/view/authenticate/view/restaurant_information_screen.dart';
import 'package:tatify_app/view/authenticate/view/sign_in_screen.dart';

class EmailVerificationScreen extends StatelessWidget {
  final bool? isVendor;
  final String email;
  const EmailVerificationScreen({super.key, this.isVendor = false, required this.email});

  @override
  Widget build(BuildContext context) {
    final OtpController controller = Get.put(OtpController());
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: MainAppBar(
        title: 'email_verification'.tr,
        backgroundColor: AppColors.bgColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
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
                title: '${'please_enter_the_6_digit_code_that_was_sent'.tr} $email',
                color: AppColors.primaryColor,
                fontSize: 18,
                textAlign: TextAlign.center,
              ),

              SizedBox(
                height: Get.height / 10,
              ),
              CustomOtpWidget(
                numberOfFields: 4,
                borderColor: Colors.grey,
                controllers: controller.otpControllers,
              ),

              heightBox20,
              Obx(() => controller.secondsRemaining.value == 0
                  ? Center(
                child: InkWell(
                  onTap: () => controller.resendOtp(email),
                  child: CustomText(
                    title: 'resend_code'.tr,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondaryColor,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.secondaryColor,
                  ),
                ),
              )
                  : Center(
                child: CustomText(
                  title: '${'resend_otp_in_seconds'.tr} ${controller.secondsRemaining.value}',
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                  fontSize: 14,
                ),
              )),

              heightBox50,
              Obx(() => CustomButton(
                title: 'verify_otp'.tr,
                isLoading: controller.isLoading.value,
                onTap: () {
                  controller.otpSubmitted(email, isVendor ?? false);
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
