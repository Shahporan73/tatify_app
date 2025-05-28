// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatify_app/res/common_widget/RoundTextField.dart';
import 'package:tatify_app/res/common_widget/custom_otp_widget.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/view/authenticate/controller/forgot_sheet_controller.dart';

import '../../../../res/app_colors/App_Colors.dart';
import '../../../../res/common_widget/custom_button.dart';
import '../../../../res/custom_style/custom_size.dart';

class ResetPasswordSheet extends StatelessWidget {
  ResetPasswordSheet({super.key});
  final ForgotSheetController controller = Get.put(ForgotSheetController());

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BottomSheet(
      onClosing: () {},
      builder: (context) {
        return Obx(() => Container(
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
            child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
              heightBox10,
              CustomText(
                title: 'reset_password'.tr,
                style: GoogleFonts.rubik(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackColor,
                ),
              ),
              heightBox20,
              CustomText(
                title: 'set_new_password_for_account'.tr,
                style: GoogleFonts.rubik(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.blackColor,
                ),
              ),
              heightBox20,
              RoundTextField(
                hint: 'new_password'.tr,
                prefixIcon: Icon(Icons.lock_outline),
                controller: controller.newPasswordController,
                obscureText: controller.isPasswordVisible.value,
                suffixIcon: IconButton(
                  icon: Icon(controller.isPasswordVisible.value ? Icons.visibility_off : Icons.visibility),
                  color: AppColors.blackColor,
                  onPressed: controller.togglePasswordVisibility,
                ),
              ),
              heightBox20,
              RoundTextField(
                hint: 'confirm_password'.tr,
                prefixIcon: Icon(Icons.lock_outline),
                controller: controller.confirmPasswordController,
                obscureText: controller.isConfirmPasswordVisible.value,
                suffixIcon: IconButton(
                  icon: Icon(controller.isConfirmPasswordVisible.value ? Icons.visibility_off : Icons.visibility),
                  color: AppColors.blackColor,
                  onPressed: controller.toggleConfirmPasswordVisibility,
                ),
              ),
              heightBox20,
              Obx(() => CustomButton(
                title: 'verify_otp'.tr,
                isLoading: controller.isLoading.value,
                onTap: () {
                  controller.resetPassword(context: context);
                },
              )),
            ]),
          ),
        ));
      },
    );
  }
}
