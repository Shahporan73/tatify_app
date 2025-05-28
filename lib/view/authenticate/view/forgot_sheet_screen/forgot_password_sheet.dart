// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatify_app/res/common_widget/RoundTextField.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';

import '../../../../res/app_colors/App_Colors.dart';
import '../../../../res/common_widget/custom_button.dart';
import '../../../../res/custom_style/custom_size.dart';
import '../../controller/forgot_sheet_controller.dart';
import 'otp_verify_sheet.dart';

class ForgotPasswordSheet extends StatefulWidget {
  @override
  _ForgotPasswordSheetState createState() => _ForgotPasswordSheetState();
}

class _ForgotPasswordSheetState extends State<ForgotPasswordSheet> {
  final ForgotSheetController controller = Get.put(ForgotSheetController());
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
                    title: 'forgot_password'.tr,
                    style: GoogleFonts.rubik(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blackColor,
                    ),
                  ),
                  heightBox20,
                  CustomText(
                    title: 'enter_email_for_verification_process'.tr,
                    style: GoogleFonts.rubik(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blackColor,
                    ),
                  ),
                  heightBox20,
                  RoundTextField(
                    controller: controller.emailController,
                    hint: 'enter_your_email'.tr,
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  heightBox20,
                  Obx(
                        () => CustomButton(
                      title: 'send'.tr,
                      isLoading: controller.isLoading.value,
                      onTap: () {
                        if (controller.emailController.text.isEmpty) {
                          Get.rawSnackbar(message: 'please_enter_email'.tr);
                        } else if (controller.emailController.text.contains('@') ==
                            false) {
                          Get.rawSnackbar(message: 'please_enter_valid_email'.tr);
                        } else {
                          controller.forgotPassword(context: context);
                        }
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
