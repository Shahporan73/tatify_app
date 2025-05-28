// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/data/utils/custom_loader.dart';
import 'package:tatify_app/data/utils/html_view.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/common_widget/custom_app_bar.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/common_widget/main_app_bar.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/res/custom_style/custom_style.dart';
import 'package:tatify_app/view/user/user_rule_view/controller/rule_controller.dart';

class UserPrivacyPolicyScreen extends StatelessWidget {
  const UserPrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final RuleController controller = Get.put(RuleController());
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: MainAppBar(title: 'privacy_policy'.tr),
      body: Obx(
        ()=> SingleChildScrollView(
          padding: bodyPadding,
          child: controller.isLoading.value ? CustomLoader(size: 28,): HTMLView(htmlData: controller.privacyPolicy.value),
        ),
      ),
    );
  }
}
