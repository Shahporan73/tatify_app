// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/app_images/App_images.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';

class HomeMenuWidget extends StatelessWidget {
  final bool? isEdit;
  final String foodName;
  final String foodPrice;
  final String discountPrice;
  final String offerDay;
  final String description;
  const HomeMenuWidget(
      {super.key,
      this.isEdit = false,
      required this.foodName,
      required this.foodPrice,
      required this.discountPrice,
      required this.offerDay,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: BoxDecoration(
          color: AppColors.bgColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title: foodName,
            fontWeight: FontWeight.w700,
            color: AppColors.blackColor,
            fontSize: 18,
          ),
          heightBox5,
          Row(
            children: [
              Expanded(
                flex: 14,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImages.parchentageIcon,
                        scale: 4,
                      ),
                      widthBox5,
                      Text.rich(TextSpan(children: [
                        TextSpan(
                          text: '$foodPrice€',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                            color: AppColors.whiteColor,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: ' $discountPrice€',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                            color: Color(0xff00FF00),
                          ),
                        ),
                      ]))
                    ],
                  ),
                ),
              ),
              widthBox10,
              Expanded(
                flex: 10,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImages.refreshIcon,
                        scale: 4,
                      ),
                      widthBox5,
                      CustomText(
                        title: offerDay,
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
              widthBox10,
              Expanded(
                flex: 10,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.white,
                        size: 18,
                      ),
                      widthBox5,
                      CustomText(
                        title: 'On-site',
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          heightBox5,
          CustomText(
            title: description,
            fontWeight: FontWeight.w400,
            color: Color(0xff677294),
            fontSize: 12,
          ),
        ],
      ),
    );
  }
}
