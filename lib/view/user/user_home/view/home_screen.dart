// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tatify_app/res/app_images/App_images.dart';
import 'package:tatify_app/res/common_widget/RoundTextField.dart';
import 'package:tatify_app/res/common_widget/custom_network_image_widget.dart';
import 'package:tatify_app/res/common_widget/custom_row_widget.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/common_widget/main_app_bar.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/view/user/user_home/view/user_restaurant_details_screen.dart';
import 'package:tatify_app/view/user/user_home/widget/home_list_widget.dart';

import '../../../../res/app_colors/App_Colors.dart';
import 'notification_screen.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
        //   header
          Container(
            width: width * double.infinity,
            height: height / 3,
            padding: EdgeInsets.only(left: 16, right: 16, top: 40, bottom: 8),
            decoration: BoxDecoration(
              color: Color(0xff3B9A54),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: 'Current Location',
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: AppColors.primaryColor,
                            size: 16,
                          ),
                          widthBox5,
                          CustomText(
                            title: 'JL. Kampung Melon No. 32',
                            color: AppColors.primaryColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      )
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: (){
                        Get.to(() => NotificationScreen());
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.primaryColor)
                        ),
                        child: Image.asset(AppImages.notificationIcon, scale: 4,),
                      ),
                    )
                  ],
                ),
                CustomText(
                    title: 'Hello,',
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w500
                ),
                CustomText(
                    title: 'What you want eat today?',
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                ),

                heightBox10,
                Row(
                  children: [
                    Expanded(
                        child: RoundTextField(
                            hint: 'Search',
                            fillColor: Colors.white,
                            hintColor: Colors.grey,
                            filled: true,
                            isBorder: false,
                            borderColor: Colors.transparent,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            borderRadius: 20,
                          focusBorderRadius: 20,
                        ),
                    ),
                    widthBox5,
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(AppImages.filterIcon, scale: 4,),
                    )
                  ],
                ),


              ],
            ),
          ),

          Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 0),
          child: CustomRowWidget(
              title: CustomText(title: 'Nearby Restaurant',
                color: AppColors.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              value: CustomText(title: 'See all', color: Colors.green,)
           ),
          ),

          // body
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(()=>UserRestaurantDetailsScreen());
                    },
                    child: HomeListWidget(
                      imagePath: 'https://t4.ftcdn.net/jpg/02/74/99/01/360_F_274990113_ffVRBygLkLCZAATF9lWymzE6bItMVuH1.jpg',
                      title:  'SPICETRAILS Altstadt',
                      discountPrice: '6.99€',
                      price: '9.99€',
                      distance: '2 km',
                      reviewsAndRating: '4.3(17)',
                      on2for1Click: () {},
                      onFreeSoftClick: () {},
                    ),
                  ),
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}
