// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tatify_app/res/common_widget/custom_button.dart';

import '../../../../res/app_colors/App_Colors.dart';
import '../../../../res/app_images/App_images.dart';
import '../../../../res/common_widget/custom_network_image_widget.dart';
import '../../../../res/common_widget/custom_text.dart';
import '../../../../res/custom_style/custom_size.dart';

class FavoriteWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String distance;
  final String reviewsAndRating;
  final VoidCallback on2for1Click;
  final VoidCallback onFreeSoftClick;
  FavoriteWidget({super.key, required this.imagePath, required this.title, required this.distance, required this.reviewsAndRating, required this.on2for1Click, required this.onFreeSoftClick});
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ]
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CustomNetworkImage(
                imageUrl: imagePath,
                height: height / 8,
                width: width / 3
            ),
          ),
          widthBox10,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                title: title,
                color: AppColors.blackColor,
                fontSize: 14, fontWeight: FontWeight.w600,
              ),

              heightBox8,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16,),
                      widthBox5,
                      CustomText(
                        title: reviewsAndRating,
                        color: AppColors.black100,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  widthBox5,
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle
                        ),
                      ),
                      widthBox5,
                      CustomText(
                        title: distance,
                        color: AppColors.black100,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ],
              ),
              /*heightBox8,
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      title: '2for1 Burger',
                      padding_vertical: 4,
                      fontSize: 11,
                      onTap: on2for1Click,
                    ),
                  ),
                  widthBox10,
                  Expanded(
                    child: CustomButton(
                      title: 'Free soft drink',
                      fontSize: 11,
                      padding_vertical: 4,
                      onTap: onFreeSoftClick,
                    ),
                  ),
                ],
              )*/
            ],
          ),),
        ],
      ),

    );
  }
}
