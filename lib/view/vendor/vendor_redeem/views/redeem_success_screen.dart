// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/app_images/App_images.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/common_widget/lottie_loader_widget.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/view/user/user_home/view/home_dashboard.dart';
import 'package:tatify_app/view/vendor/vendor_home/views/vendor_home_dashboard.dart';

class RedeemSuccessScreen extends StatelessWidget {
  final bool? isUser;
  const RedeemSuccessScreen({super.key, this.isUser});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(seconds: 3),
          () {
        if (isUser == true) {
          Get.offAll(HomeDashboard());
        } else {
          Get.offAll(VendorHomeDashboard());
        }
      },
    );
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LottieLoaderWidget(
            repeat: false,
            lottieAssetPath: AppImages.successAnim,
          ),
          CustomText(
            title: 'deal_redeemed'.tr,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
          heightBox10,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: CustomText(
              title: 'redeem_success_message'.tr,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
