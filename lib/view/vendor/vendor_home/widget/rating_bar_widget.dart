// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';

class RatingBarWidget extends StatelessWidget {
  final int starCount;
  final double fillPercent;
  final int rating;
  const RatingBarWidget({super.key, required this.starCount, required this.fillPercent, required this.rating,});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: Get.width / 4.5,
          child: Align(
            alignment: Alignment.centerRight,
            child: RatingBarIndicator(
              itemCount: starCount,
              rating: 5.0,
              itemSize: 16,
              itemBuilder: (context, index) {
                return Icon(Icons.star, color: AppColors.secondaryColor,);
              },
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 8,
                decoration: BoxDecoration(
                  // color: Colors.grey[300],
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              FractionallySizedBox(
                widthFactor: fillPercent,
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ],
          ),
        ),
        CustomText(title: rating.toString(), fontSize: 12, fontWeight: FontWeight.w400,)
      ],
    );
  }
}
