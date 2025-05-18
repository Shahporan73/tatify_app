// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/app_images/App_images.dart';
import 'package:tatify_app/res/common_widget/custom_button.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/view/user/user_home/widget/confirm_booking_sheet_widget.dart';

class UserDetailsItemWidget extends StatelessWidget {
  final String foodName;
  final String standardPrice;
  final String discountPrice;
  final String offerDays;
  final String description;
  final String foodId;
  const UserDetailsItemWidget({
    super.key,
    required this.foodName,
    required this.standardPrice,
    required this.discountPrice,
    required this.offerDays,
    required this.description,
    required this.foodId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10.0),
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
                flex: 13,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        AppImages.parchentageIcon,
                        scale: 4,
                      ),
                      widthBox5,
                      Text.rich(TextSpan(children: [
                        TextSpan(
                          text: '$standardPrice€',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 10.68,
                            color: AppColors.whiteColor,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: ' $discountPrice€',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 10.68,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        AppImages.refreshIcon,
                        scale: 4,
                      ),
                      widthBox5,
                      CustomText(
                        title: offerDays,
                        fontSize: 10.68,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.white,
                        size: 18,
                      ),
                      widthBox5,
                      CustomText(
                        title: 'On-site',
                        fontSize: 10.68,
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
          heightBox8,
          CustomButton(
              title: 'Book deal',
              buttonColor: AppColors.secondaryColor,
              titleColor: Colors.white,
              borderRadius: 25,
              padding_vertical: 8,
              onTap: () {
                Get.bottomSheet(
                  Container(
                    height: Get.height / 3,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: ConfirmBookingSheetWidget(
                        foodName: foodName,
                        foodPrice: discountPrice,
                        foodDesc: description,
                        foodId: foodId
                    ),
                  ),
                  isScrollControlled: true, // Allows full height modal
                );
              }),
        ],
      ),
    );
  }
}
