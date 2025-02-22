// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/common_widget/custom_button.dart';
import 'package:tatify_app/res/common_widget/custom_network_image_widget.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/view/user/user_home/view/home_dashboard.dart';

class BookingDealConfirmScreen extends StatelessWidget {
  BookingDealConfirmScreen({super.key});

  final String image =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4w0WN2S2AvpOni7XzkweG2j2-UHgZmmV7TPkXeWO42ZWgDU5ezdM9QJHLkfRMcLyc7RI&usqp=CAU';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomNetworkImage(
              imageUrl: image,
              height: Get.height / 3.5,
              width: double.infinity,
            ),
          ),
          Positioned(
            top: Get.height / 4.5,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(
                  left: 16, right: 16, top: Get.height / 14, bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: 'Chicken Berlicious',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: AppColors.secondaryColor,
                  ),
                  CustomText(
                    title: '🌟€1 Bowl 🌟',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: AppColors.blackColor,
                  ),
                  heightBox20,
                  Center(
                    child: CustomText(
                      title: 'How is your exprience?',
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: AppColors.blackColor,
                    ),
                  ),
                  Divider(
                    height: 10,
                    color: Colors.grey,
                  ),
                  heightBox20,
                  buildRatingRow("Service:", 5, "Exceptional"),
                  buildRatingRow(
                      "Food:", 4.5, "Delicious but with minor flaws"),
                  buildRatingRow("Ambience:", 3, "Okay but not impressive"),
                  buildRatingRow("Cleanliness:", 5, "Perfect"),
                  heightBox10,
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          "Your overall rating",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        RatingBar.builder(
                          initialRating: 4.2,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 24,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.green,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                          ignoreGestures: true,
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "Very good",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          title: 'Cancel',
                          buttonColor: Colors.white,
                          titleColor: AppColors.primaryColor,
                          border: Border.all(color: AppColors.primaryColor),
                          onTap: () {
                            Get.offAll(()=> HomeDashboard());
                          },
                        ),
                      ),
                      widthBox10,
                      Expanded(
                        child: CustomButton(
                          title: 'Submit',
                          buttonColor: AppColors.secondaryColor,
                          titleColor: AppColors.whiteColor,
                          onTap: () {
                            Get.rawSnackbar(message: "Review submitted");
                            Get.offAll(()=> HomeDashboard());
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRatingRow(String title, double rating, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 5),
          RatingBar.builder(
            initialRating: rating,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 20,
            itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {},
            ignoreGestures: true,
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              description,
              style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
