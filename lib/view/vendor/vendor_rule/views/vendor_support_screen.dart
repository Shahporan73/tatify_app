// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/common_widget/main_app_bar.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/res/custom_style/custom_style.dart';

class VendorSupportScreen extends StatelessWidget {
  const VendorSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: MainAppBar(title: 'Support'),
      body: SingleChildScrollView(
        padding: bodyPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            CustomText(
              title:
              '1-Lorem ipsum dolor sit amet consectetur. '
                  'Imperdiet iaculis convallis bibendum massa id '
                  'elementum consectetur neque mauris.',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.black100,
            ),
            heightBox20,
            CustomText(
              title:
              '2-Lorem ipsum dolor sit amet consectetur. '
                  'Imperdiet iaculis convallis bibendum massa id '
                  'elementum consectetur neque mauris.',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.black100,
            ),
            heightBox20,
            CustomText(
              title:
              '3-Lorem ipsum dolor sit amet consectetur. '
                  'Imperdiet iaculis convallis bibendum massa id '
                  'elementum consectetur neque mauris.',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.black100,
            ),
            heightBox20,
            CustomText(
              title:
              '4-Lorem ipsum dolor sit amet consectetur. '
                  'Imperdiet iaculis convallis bibendum massa id '
                  'elementum consectetur neque mauris.',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.black100,
            ),
            heightBox20,
            CustomText(
              title:
              '5-Lorem ipsum dolor sit amet consectetur. '
                  'Imperdiet iaculis convallis bibendum massa id '
                  'elementum consectetur neque mauris.',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.black100,
            ),
          ],
        ),
      ),
    );
  }
}