// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatify_app/res/common_widget/RoundTextField.dart';
import 'package:tatify_app/res/common_widget/custom_otp_widget.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/view/authenticate/controller/otp_controller.dart';
import 'package:tatify_app/view/authenticate/view/forgot_sheet_screen/reset_password_sheet.dart';

import '../../../../res/app_colors/App_Colors.dart';
import '../../../../res/common_widget/custom_button.dart';
import '../../../../res/custom_style/custom_size.dart';
import '../../controller/forgot_sheet_controller.dart';

class OtpVerifySheet extends StatelessWidget {
  OtpVerifySheet({super.key});

  final OtpController otpController = Get.put(OtpController());
  final ForgotSheetController forgotSheetController =
  Get.put(ForgotSheetController());

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BottomSheet(
      onClosing: () {},
      builder: (context) {
        return Container(
          width: double.infinity,
          height: Get.height / 1.3,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heightBox10,
                  CustomText(
                    title: 'enter_4_digits_code'.tr,
                    style: GoogleFonts.rubik(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blackColor,
                    ),
                  ),
                  heightBox20,
                  CustomText(
                    title: 'enter_4_digits_code_received_email'.tr,
                    style: GoogleFonts.rubik(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blackColor,
                    ),
                  ),
                  heightBox20,
                  CustomOtpWidget(
                    borderColor: Colors.grey,
                    numberOfFields: 4,
                    controllers: otpController.verifyOtpControllers,
                  ),
                  heightBox20,
                  Obx(
                        () => otpController.secondsRemaining.value == 0
                        ? Center(
                      child: InkWell(
                        onTap: () => otpController.ResendOtpForForgot(
                          forgotSheetController.emailController.text,
                          context,
                        ),
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
                          title:
                          '${'resend_otp_in_seconds'.tr} ${otpController.secondsRemaining.value}',
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                          fontSize: 14),
                    ),
                  ),
                  heightBox20,
                  Obx(
                        () => CustomButton(
                      title: 'verify_otp'.tr,
                      isLoading: otpController.isLoading.value,
                      onTap: () {
                        otpController.verifyOtpForgotMail(context: context);
                      },
                    ),
                  ),
                ]),
          ),
        );
      },
    );
  }
}
