// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/app_images/App_images.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/common_widget/lottie_loader_widget.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/view/user/user_booking/view/booking_deal_confirm_screen.dart';

class UserRedeemSuccessScreen extends StatelessWidget {
  const UserRedeemSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(seconds: 3), () {
      // Get.offAll(BookingDealConfirmScreen());
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
