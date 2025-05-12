// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/common_widget/custom_app_bar.dart';
import 'package:tatify_app/res/common_widget/custom_button.dart';
import 'package:tatify_app/res/common_widget/custom_password_field.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/common_widget/main_app_bar.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/res/custom_style/custom_style.dart';
import 'package:tatify_app/view/user/user_settings/controller/setting_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final SettingController controller = Get.put(SettingController());
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: MainAppBar(title: 'Change password'),
      body:  SingleChildScrollView(
        padding: bodyPadding,
        child: Obx(
          ()=> Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: height / 15,
              ),
              CustomPasswordField(
                  hintText: 'Enter old password',
                  controller: controller.oldPasswordC,
                  showObscure: true,
                borderColor: Colors.black,
                errorText: controller.oldPasswordError.value,
              ),
              heightBox10,
              CustomPasswordField(
                  hintText: 'Enter new password',
                  controller: controller.newPasswordC,
                  showObscure: true,
                borderColor: Colors.black,
                errorText: controller.newPasswordError.value,
              ),
              heightBox10,
              CustomPasswordField(
                  hintText: 'Enter confirm password',
                  controller: controller.confirmPasswordC,
                  errorText: controller.confirmPasswordError.value,
                  showObscure: true,
                borderColor: Colors.black,
              ),
              heightBox10,
              // Confirm button
              CustomButton(
                title: "Update",
                borderRadius: 8,
                onTap: () {
                  controller.validateFields();

                  // If no errors, perform the password change logic
                  if (controller.oldPasswordError.value == null &&
                      controller.newPasswordError.value == null &&
                      controller.confirmPasswordError.value == null) {
                   controller.changePassword(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
