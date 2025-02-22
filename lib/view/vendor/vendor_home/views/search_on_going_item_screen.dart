// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/common_widget/RoundTextField.dart';
import 'package:tatify_app/res/common_widget/main_app_bar.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/view/vendor/vendor_home/widget/home_menu_widget.dart';

import 'vendor_restaurant_details_screen.dart';

class SearchOnGoingItemScreen extends StatelessWidget {
  const SearchOnGoingItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: MainAppBar(title: 'Search', backgroundColor: AppColors.bgColor,),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: RoundTextField(
              hint: 'Search',
              prefixIcon: Icon(
                Icons.search_outlined,
                color: Colors.grey,
              ),
            ),
          ),
          heightBox20,
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: 18,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => VendorRestaurantDetailsScreen());
                    },
                    child: HomeMenuWidget(),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
