// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/common_widget/custom_alert_dialog.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/common_widget/main_app_bar.dart';
import 'package:tatify_app/view/user/user_settings/controller/setting_controller.dart';
import 'package:tatify_app/view/user/user_settings/view/user_change_password_screen.dart';
import '../../user_rule_view/user_privacy_policy_screen.dart';

class UserSettingScreen extends StatelessWidget {
  const UserSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final SettingController controller = Get.put(SettingController());
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: MainAppBar(
          title: "Settings",
        centerTitle: true,
        backgroundColor: AppColors.bgColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: CustomText(
                    title: "Change Password",
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.black
                ),
                trailing: Icon(Icons.navigate_next, color: AppColors.blackColor,),
                leading: Icon(Icons.settings_outlined),
                onTap: () {
                  Get.to(
                        () => ChangePasswordScreen(),
                    fullscreenDialog: true,
                    transition: Transition.downToUp,
                  );
                },
              ),

              ListTile(
                title: CustomText(
                    title: "Delete Account",
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.red
                ),
                leading: Icon(Icons.delete_outline, color: Colors.red,),
                onTap: () {
                  CustomAlertDialog().showDeleteAccountDialog(
                      context,
                    () {
                      controller.deleteAccount(context);
                    },
                      controller.isLoading.value
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
