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
import 'package:tatify_app/view/user/user_home/widget/restaurant_details_header_widget.dart';
import 'package:tatify_app/view/user/user_home/widget/user_details_item_widget.dart';
import 'package:tatify_app/view/user/user_home/widget/user_reviews_widget.dart';
import 'package:tatify_app/view/vendor/vendor_home/widget/map_widget.dart';
import 'package:tatify_app/view/vendor/vendor_home/widget/time_schedule_widget.dart';

import '../../../../res/app_colors/App_Colors.dart';
import '../../../../res/app_images/App_images.dart';
import '../../../../res/common_widget/custom_network_image_widget.dart';
import '../../../../res/common_widget/custom_text.dart';

class UserRestaurantDetailsScreen extends StatefulWidget {
  final String? restaurantId;
  const UserRestaurantDetailsScreen({super.key, this.restaurantId});

  @override
  State<UserRestaurantDetailsScreen> createState() => _UserRestaurantDetailsScreenState();
}

class _UserRestaurantDetailsScreenState extends State<UserRestaurantDetailsScreen> {
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
      body: Column(
        children: [
          RestaurantDetailsHeaderWidget(restaurantId: widget.restaurantId.toString(),),

          Expanded(
            child: Container(
              width: Get.width,
              height: Get.height,
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                
                
                    // map
                    heightBox10,
                    SizedBox(
                      width: double.infinity,
                      height: height / 3.5,
                      child: MapWidget(),
                    ),
                
                
                    // Time schedule
                    heightBox20,
                    TimeScheduleWidget(),
                
                    heightBox50,
                  ],
                ),
              ),
            ),
          )
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