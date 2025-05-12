// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/common_widget/main_app_bar.dart';
import 'package:tatify_app/view/user/user_home/view/user_restaurant_details_screen.dart';
import 'package:tatify_app/view/user/user_home/widget/home_list_widget.dart';
import 'package:tatify_app/view/vendor/vendor_home/widget/home_menu_widget.dart';

class FilteredResultScreen extends StatelessWidget {
  FilteredResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: MainAppBar(title: "Results"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
            itemCount: 20,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.to(()=>UserRestaurantDetailsScreen(restaurantId: '',));
                },
                child: HomeListWidget(
                  imagePath: 'https://t4.ftcdn.net/jpg/02/74/99/01/360_F_274990113_ffVRBygLkLCZAATF9lWymzE6bItMVuH1.jpg',
                  title:  'SPICETRAILS Altstadt',
                  discountPrice: '6.99€',
                  price: '9.99€',
                  distance: '2 km',
                  kitchenStyle: 'kabab',
                  reviewsAndRating: '4.3(17)',
                  on2for1Click: () {},
                  onFreeSoftClick: () {},
                ),
              );
            }
        ),
      ),
    );
  }
}
