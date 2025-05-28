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
      appBar: MainAppBar(title: 'change_password'.tr),
      body: SingleChildScrollView(
        padding: bodyPadding,
        child: Obx(
              () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: height / 15,
              ),
              CustomPasswordField(
                hintText: 'enter_old_password'.tr,
                controller: controller.oldPasswordC,
                showObscure: true,
                borderColor: Colors.black,
                errorText: controller.oldPasswordError.value,
              ),
              heightBox10,
              CustomPasswordField(
                hintText: 'enter_new_password'.tr,
                controller: controller.newPasswordC,
                showObscure: true,
                borderColor: Colors.black,
                errorText: controller.newPasswordError.value,
              ),
              heightBox10,
              CustomPasswordField(
                hintText: 'enter_confirm_password'.tr,
                controller: controller.confirmPasswordC,
                errorText: controller.confirmPasswordError.value,
                showObscure: true,
                borderColor: Colors.black,
              ),
              heightBox10,
              // Confirm button
              CustomButton(
                title: "update".tr,
                borderRadius: 8,
                isLoading: controller.isLoading.value,
                onTap: () {
                  controller.validateFields();

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
