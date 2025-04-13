import 'package:flutter/material.dart';
import 'package:tatify_app/res/app_images/App_images.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';

class VHomeHeaderWidget extends StatelessWidget {
  const VHomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width * double.infinity,
      height: height / 3.2,
      padding: EdgeInsets.only(left: 16, right: 16, top: 30, bottom: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          gradient: LinearGradient(
              colors: [
                Color(0xffFF4F00B2).withOpacity(0.7),
                Color(0xffF04B6C),
              ]
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(AppImages.splashLogo, width: 70,),
          CustomText(
              title: 'Hi, Istiak',
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500
          ),
          CustomText(
              title: 'Welcome to Taste Point ',
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500
          ),

          heightBox10,
          Row(
            children: [
              Icon(Icons.restaurant_menu, color: Colors.white, size: 18,),
              widthBox5,
              CustomText(title: 'Restaurant Name', fontSize: 14, color: Colors.white,),
            ],
          ),

        ],
      ),
    );
  }
}
