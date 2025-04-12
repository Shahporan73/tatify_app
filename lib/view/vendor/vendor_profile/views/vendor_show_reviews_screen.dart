// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatify_app/res/common_widget/RoundTextField.dart';
import 'package:tatify_app/res/common_widget/custom_button.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/common_widget/main_app_bar.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/res/custom_style/custom_style.dart';
import 'package:tatify_app/view/vendor/vendor_home/widget/rating_bar_widget.dart';
import 'package:tatify_app/view/vendor/vendor_home/widget/show_reviews_widget.dart';

import '../../../../res/app_colors/App_Colors.dart';

class VendorShowReviewsScreen extends StatelessWidget {
  const VendorShowReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: MainAppBar(title: 'Rating & Review', backgroundColor: AppColors.whiteColor,),
      body: SingleChildScrollView(
        padding: bodyPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Average Rating & Review count
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Average Rating
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '4.8',
                          style: GoogleFonts.urbanist(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '25\n ratings',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.urbanist(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
                    // Rating Distribution Bars
                    Expanded(
                      child: Column(
                        children: [
                          RatingBarWidget(starCount: 5, fillPercent: 0.8, rating: 12,),
                          RatingBarWidget(starCount: 4, fillPercent: 0.6, rating: 5,),
                          RatingBarWidget(starCount: 3, fillPercent: 0.4, rating: 4,),
                          RatingBarWidget(starCount: 2, fillPercent: 0.2, rating: 2,),
                          RatingBarWidget(starCount: 1, fillPercent: 0.1, rating: 0,),
                        ],
                      ),
                    ),
                  ],
                ),

                heightBox20,
                CustomText(title: '12 reviews', color: AppColors.black100, fontWeight: FontWeight.w500, fontSize: 12,),
                Divider(
                  color: AppColors.secondaryColor,
                ),
                ListView.builder(
                  itemCount: 10,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ShowReviewsWidget();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
