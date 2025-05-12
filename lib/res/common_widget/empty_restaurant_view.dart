// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/res/app_images/App_images.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/common_widget/lottie_loader_widget.dart';

class EmptyRestaurantView extends StatelessWidget {
  final String? title;
  const EmptyRestaurantView({super.key,this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LottieLoaderWidget(
            lottieAssetPath: AppImages.emptyAnim,
          width: Get.width / 2,
          height: Get.height / 4,
        ),
        SizedBox(height: 20),
        CustomText(
          title: 'Your favorites list is empty',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey
        ),
      ],
    );
  }
}
