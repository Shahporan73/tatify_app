import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';

class ShowReviewsWidget extends StatelessWidget {
  const ShowReviewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.primaryColor,
                backgroundImage: NetworkImage('https://photosbulk.com/wp-content/uploads/2024/08/hijab-girl-pic_108.webp'),
              ),
              widthBox10,
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(title: 'Dontae Henton', fontSize: 12, fontWeight: FontWeight.w600,),
                    heightBox5,
                    Row(
                      children: [
                        RatingBarIndicator(
                          itemCount: 5,
                          itemSize: 14,
                          rating: 5.0,
                          itemBuilder: (context, index) {
                            return Icon(Icons.star, color: Colors.amber, size: 14,);
                          },
                        ),
                        widthBox8,
                        CustomText(title: '5.0', fontSize: 12, fontWeight: FontWeight.w600,),
                      ],
                    ),
                  ]
              ),
              Spacer(),
              CustomText(title: 'June 5, 2024')
            ],
          ),
          heightBox5,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: CustomText(title: 'Very good', fontWeight: FontWeight.w400, color: AppColors.blackColor, fontSize: 14,),
          ),
        ],
      ),
    );
  }
}
