import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';

class VMenuDetailsReviewWidget extends StatelessWidget {
  const VMenuDetailsReviewWidget({super.key});

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
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.green,
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
                            return Icon(Icons.star, color: AppColors.secondaryColor, size: 14,);
                          },
                        ),
                        widthBox8,
                        CustomText(title: '5.0', fontSize: 12, fontWeight: FontWeight.w600,),
                        widthBox5,
                        CustomText(title: 'Excellent', fontSize: 12, fontWeight: FontWeight.w600,),
                      ],
                    ),
                  ]
              ),
              Spacer(),
              CustomText(title: '2 months ago')
            ],
          ),
        ),
        heightBox5,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 0),
          child: CustomText(title: 'Very good', fontWeight: FontWeight.w400, color: AppColors.secondaryColor, fontSize: 14,),
        ),
        Divider(color: AppColors.secondaryColor,)
      ],
    );
  }
}
