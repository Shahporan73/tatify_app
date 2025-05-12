
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/view/user/user_home/view/search_restaurant_view.dart';

import '../../../../res/app_colors/App_Colors.dart';
import '../../../../res/app_images/App_images.dart';
import '../../../../res/common_widget/RoundTextField.dart';
import '../../../../res/common_widget/custom_text.dart';
import '../../../../res/custom_style/custom_size.dart';
import '../view/notification_screen.dart';
import 'filter_dialog.dart';

class CustomSliverAppbar extends StatelessWidget {
  CustomSliverAppbar({super.key});
  final TextEditingController searchController = TextEditingController();
  final TextEditingController distanceController = TextEditingController();
  final TextEditingController limitController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: Get.height / 4.5,
      backgroundColor: Color(0xff3B9A54),
      pinned: true,
      floating: true,
      snap: false,
      automaticallyImplyLeading: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title: 'Current Location',
            color: Colors.white,
            fontSize: 15,
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
                  padding: EdgeInsets.all(5),
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
        ],
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          alignment: Alignment.bottomLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              CustomText(
                  title: 'Hello,',
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500
              ),
              CustomText(
                  title: 'What you want eat today?',
                  color: Colors.white,
                  fontSize: 14,
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
                      isBorder: true,
                      borderWidth: 0,
                      readOnly: true,
                      onTap: () => Get.to(()=> SearchRestaurantView(), transition: Transition.downToUp),
                      borderColor: Colors.transparent,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      borderRadius: 8,
                      focusBorderRadius: 8,
                    ),
                  ),
                  widthBox5,
                  InkWell(
                    onTap: () {
                      openFilterDialog(
                        context,
                        distanceController,
                        limitController, (distance, limit) {
                          // Handle filtered result
                          print('Distance: $distance, Limit: $limit');
                        },
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(AppImages.filterIcon, scale: 4,),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
