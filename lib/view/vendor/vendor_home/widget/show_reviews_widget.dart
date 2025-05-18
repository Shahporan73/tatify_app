// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';

import '../../../../res/common_widget/custom_network_image_widget.dart';

class ShowReviewsWidget extends StatelessWidget {
  final String userName;
  final String userImage;
  final double rating;
  final String review;
  final String createdTime;
  const ShowReviewsWidget(
      {super.key,
        required this.userName,
        required this.userImage,
        required this.rating,
        required this.review,
        required this.createdTime});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipOval(
                child: CustomNetworkImage(
                    imageUrl: userImage,
                    height: Get.height / 12,
                    width: Get.width / 6
                ),
              ),
              widthBox10,
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                CustomText(
                  title: userName,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                heightBox5,
                Row(
                  children: [
                    CustomText(
                      title: rating.toString(),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    widthBox8,
                    RatingBarIndicator(
                      itemCount: 5,
                      itemSize: 14,
                      rating: rating,
                      itemBuilder: (context, index) {
                        return Icon(
                          Icons.star,
                          color: AppColors.secondaryColor,
                          size: 14,
                        );
                      },
                    ),
                  ],
                ),
              ]),
              Spacer(),
              CustomText(title: createdTime, color: AppColors.secondaryColor,)
            ],
          ),
        ),
        heightBox5,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 0),
          child: CustomText(
            title: review,
            fontWeight: FontWeight.w400,
            color: AppColors.secondaryColor,
            fontSize: 14,
          ),
        ),
        Divider(
          color: AppColors.secondaryColor,
        )
      ],
    );
  }
}
