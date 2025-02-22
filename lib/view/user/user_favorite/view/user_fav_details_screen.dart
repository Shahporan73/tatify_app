// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tatify_app/res/common_widget/custom_button.dart';
import 'package:tatify_app/res/common_widget/custom_row_widget.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/view/user/user_home/widget/user_details_item_widget.dart';
import 'package:tatify_app/view/user/user_home/widget/user_reviews_widget.dart';
import 'package:tatify_app/view/vendor/vendor_home/widget/map_widget.dart';
import 'package:tatify_app/view/vendor/vendor_home/widget/time_schedule_widget.dart';

import '../../../../res/app_colors/App_Colors.dart';
import '../../../../res/app_images/App_images.dart';
import '../../../../res/common_widget/custom_network_image_widget.dart';
import '../../../../res/common_widget/custom_text.dart';

class UserFavDetailsScreen extends StatefulWidget {
  const UserFavDetailsScreen({super.key});

  @override
  State<UserFavDetailsScreen> createState() => _UserFavDetailsScreenState();
}

class _UserFavDetailsScreenState extends State<UserFavDetailsScreen> {
  late GoogleMapController mapController;

  final LatLng restaurantLocation = LatLng(23.7678, 90.4125); // Replace with your latitude & longitude

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  String image = 'https://t4.ftcdn.net/jpg/02/74/99/01/360_F_274990113_ffVRBygLkLCZAATF9lWymzE6bItMVuH1.jpg';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Stack(
        children: [


          // Header image
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: height / 2.5,
              child: Stack(
                children: [
                  // Shimmer effect as the placeholder while loading
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      color: Colors.grey,
                      height: 200,
                    ),
                  ),
                  // Network image with loading and error handling
                  Image.network(
                    image,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child; // Image loaded successfully
                      }
                      return SizedBox.shrink(); // Keep showing shimmer while loading
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.broken_image,
                          color: Colors.grey[600],
                          size: 48,
                        ), // Error image placeholder
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // appbar
          Positioned(
            top: 32,
            right: 16,
            left: 16,
            child: Row(
              children: [
                // Back Button
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xffEBEBEB), width: 1),
                  ),
                  child: Icon(Icons.favorite_outline, color: AppColors.secondaryColor,),
                ),

              ],
            ),
          ),

          // details
          Positioned(
            top: height / 3.5,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xffFFFAFB),
                      const Color(0xFFFFD7C599),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height / 18),
                  ListView.builder(
                    itemCount: 2,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return UserDetailsItemWidget();
                    },
                  ),

                    //   reviews section
                    heightBox20,
                    CustomText(title: 'Ratings & reviews', fontSize: 20, fontWeight: FontWeight.w500,),
                    heightBox10,
                    Row(
                      children: [
                        CustomText(title: '4.9', color: AppColors.blackColor, fontWeight: FontWeight.w600, fontSize: 14,),
                        RatingBarIndicator(
                          itemCount: 5,
                          itemSize: 18,
                          rating: 4.9,
                          itemBuilder: (context, index) {
                            return Icon(Icons.star, color: AppColors.secondaryColor, size: 14,);
                          },)
                      ],
                    ),
                    heightBox5,
                    CustomText(title: '146 reviews', color: AppColors.black100, fontWeight: FontWeight.w500, fontSize: 12,),
                    Divider(
                      color: AppColors.secondaryColor,
                    ),
                    ListView.builder(
                      itemCount: 5,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        return UserReviewsWidget();
                      },
                    ),
                    heightBox20,
                    CustomButton(
                        title: 'All reviews (146)',
                        buttonColor: AppColors.secondaryColor,
                        borderRadius: 25,
                        padding_vertical: 8,
                        onTap: (){}
                    ),
                    heightBox20,
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, color: AppColors.secondaryColor, size: 24,),
                        CustomText(title: 'Location', fontSize: 18,)
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(left: 25),
                      child: CustomText(title: 'Rampura, Dhaka'),),

                    // Map
                    heightBox10,
                    SizedBox(
                      width: double.infinity,
                      height: height / 3.5,
                      child: MapWidget(),
                    ),

                    heightBox20,
                    TimeScheduleWidget(),

                    heightBox50,
                  ],
                ),
              ),
            ),
          ),

          // details header
          Positioned(
            top: height / 5,
            left: 24,
            right: 24,
            child: Center(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
                decoration: BoxDecoration(
                    color: AppColors.bgColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 1),
                      ),
                    ]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        CustomText(title: 'Shinsei Restaurant',
                          fontWeight: FontWeight.w600, color: AppColors.secondaryColor, fontSize: 18,
                        ),
                        Spacer(),
                        Row(
                          children: [
                            CustomText(title: '4.9', color: AppColors.primaryColor, fontWeight: FontWeight.w400, fontSize: 14,),
                            Icon(Icons.star, color: Colors.amber, size: 18,)
                          ],
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        CustomText(title: 'Burgers, Meat',
                          fontWeight: FontWeight.w600, color: AppColors.blackColor, fontSize: 14,
                        ),
                        Spacer(),
                        Row(
                          children: [
                            CustomText(title: 'Open time 10:00 AM ',
                              color: AppColors.black100, fontWeight: FontWeight.w400, fontSize: 8,
                            ),
                          ],
                        ),
                      ],
                    ),
                    /*heightBox5,
                    Row(
                      children: [
                        *//*Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(16),

                          ),
                          child: Row(
                            children: [
                              Icon(Icons.menu, size: 18, color: Colors.white,),
                              widthBox5,
                              CustomText(title: 'Menu', fontWeight: FontWeight.w600, color: Colors.white,fontSize: 14,)
                            ],
                          ),
                        ),*//*
                        Spacer(),

                      ],
                    ),*/

                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}


TextStyle titleStyle = GoogleFonts.poppins(
fontSize: 12,
  fontWeight: FontWeight.w400,
  color: Color(0xff5C5C5C)
);