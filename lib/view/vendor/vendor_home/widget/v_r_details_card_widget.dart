// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/app_images/App_images.dart';
import 'package:tatify_app/res/common_widget/custom_button.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';

class VRDetailsCardWidget extends StatelessWidget {
  const VRDetailsCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10),
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
          ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(title: 'Pommes',
            fontWeight: FontWeight.w700, color: AppColors.blackColor, fontSize: 18,
          ),
          heightBox5,
          Row(
            children: [
              Expanded(
                flex: 12,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(16),

                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(AppImages.parchentageIcon, scale: 4,),
                      widthBox5,
                      Text.rich(TextSpan(
                          children: [
                            TextSpan(
                              text: '12.50€ ',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 10.68, color: AppColors.whiteColor,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: '8.49€',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 10.68, color: AppColors.secondaryColor,
                              ),
                            ),
                          ]
                      ))
                    ],
                  ),
                ),),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(AppImages.refreshIcon, scale: 4,),
                      widthBox5,
                      CustomText(title: '6 days', fontSize: 10.68, color: Colors.white,)
                    ],
                  ),
                ),),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on_outlined, color: Colors.white, size: 18,),
                      widthBox5,
                      CustomText(title: 'On-site', fontSize: 10.68, color: Colors.white,)
                    ],
                  ),
                ),)
            ],
          ),
          heightBox5,
          CustomText(title: 'You order 2 Turkish Moccas, the cheaper/equally priced one will not be charged.',
            fontWeight: FontWeight.w400, color: Color(0xff677294), fontSize: 12,
          ),

        ],
      ),
    );
  }
}
