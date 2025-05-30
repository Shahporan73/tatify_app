// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatify_app/data/utils/get_relative_time.dart';
import 'package:tatify_app/res/common_widget/custom_button.dart';

import '../../../../res/app_colors/App_Colors.dart';
import '../../../../res/app_images/App_images.dart';
import '../../../../res/common_widget/custom_network_image_widget.dart';
import '../../../../res/common_widget/custom_text.dart';
import '../../../../res/custom_style/custom_size.dart';

class HomeListWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String discountPrice;
  final String price;
  final String distance;
  final String kitchenStyle;
  final String reviewsAndRating;
  final VoidCallback on2for1Click;
  final VoidCallback onFreeSoftClick;
  HomeListWidget({super.key, required this.imagePath, required this.title, required this.discountPrice, required this.price, required this.distance, required this.reviewsAndRating, required this.on2for1Click, required this.onFreeSoftClick, required this.kitchenStyle});
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
                maxLines: 1,
                color: AppColors.blackColor,
                fontSize: 14, fontWeight: FontWeight.w600,
              ),
              heightBox5,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 10,
                      child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle
                        ),
                      ),
                      SizedBox(width: 3,),
                      CustomText(
                        title: distance,
                        color: AppColors.black100,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  )),
                  Expanded(flex: 9,
                      child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle
                        ),
                      ),
                      SizedBox(width: 3,),
                      CustomText(
                        title: getLimitedWord(kitchenStyle, 5),
                        color: AppColors.black100,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  )),
                  Expanded(flex: 9,
                      child: Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16,),
                      CustomText(
                        title: reviewsAndRating,
                        color: AppColors.black100,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  )),
                ],
              ),

              /*heightBox5,
              Row(
                children: [
                  Expanded(
                    flex: 2,
                      child: CustomButton(
                          title: '2for1 Burger',
                          titleColor: Colors.green,
                        padding_vertical: 4,
                        fontSize: 12,
                        widget: Text.rich(TextSpan(
                          children: [
                            TextSpan(text: 'Doner ',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            TextSpan(text: price, style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.white,
                              decorationThickness: 2
                            ),
                            ),
                            TextSpan(text: ' $discountPrice', style: GoogleFonts.poppins(
                                color: Color(0xff00FF00),
                                fontSize: 10,
                                fontWeight: FontWeight.w600
                            ),
                            ),
                          ])),
                        buttonColor: AppColors.primaryColor,
                        onTap: on2for1Click,
                      ),
                  ),
                  widthBox10,
                  Expanded(
                    flex: 1,
                    child: CustomButton(
                      title: 'Pommes',
                      fontSize: 10,
                      titleColor: Colors.white,
                      padding_vertical: 4,
                      buttonColor: AppColors.primaryColor,
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
