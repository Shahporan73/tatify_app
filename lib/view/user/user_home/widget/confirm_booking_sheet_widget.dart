// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/common_widget/custom_button.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/view/user/user_home/view/book_deal_success_screen.dart';

class ConfirmBookingSheetWidget extends StatelessWidget {
  const ConfirmBookingSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 32, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title: 'Chicken Berlicious',
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.black,
          ),
          heightBox5,
          CustomText(
            title: '🌟€1 Bowl 🌟',
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.black,
          ),
          heightBox10,
          CustomText(
            title:
                'Build your own bowl of size M with your choice and pay only €1.',
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: Colors.black,
          ),
          Spacer(),
          CustomButton(
            title: 'Book Deal',
            onTap: () {
              Get.back();
              Get.offAll(()=>BookDealSuccessScreen());
            },
            buttonColor: AppColors.secondaryColor,
          ),
        ],
      ),
    );
  }
}
