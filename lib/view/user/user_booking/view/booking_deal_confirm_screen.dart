// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:tatify_app/data/utils/custom_loader.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/common_widget/custom_button.dart';
import 'package:tatify_app/res/common_widget/custom_network_image_widget.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/view/user/user_home/view/home_dashboard.dart';

import '../../../../res/utils/review_format.dart';
import '../controller/user_rating_controller.dart';

class BookingDealConfirmScreen extends StatefulWidget {
  final String restaurantImageUrl;
  final String itemName;
  final String itemPrice;
  final String foodId;
  BookingDealConfirmScreen({
    super.key,
    required this.restaurantImageUrl,
    required this.itemName,
    required this.itemPrice,
    required this.foodId,
  });

  @override
  State<BookingDealConfirmScreen> createState() =>
      _BookingDealConfirmScreenState();
}

class _BookingDealConfirmScreenState extends State<BookingDealConfirmScreen> {
  // User ratings stored here
  double serviceRating = 5.0;
  double foodRating = 5.0;
  double ambienceRating = 5.0;
  double cleanlinessRating = 5.0;

  double get overallRating {
    final total =
        serviceRating + foodRating + ambienceRating + cleanlinessRating;
    return total / 4;
  }

  Widget buildRatingRow(String title, double rating, String description,
      Function(double) onRatingUpdate) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          CustomText(title: title, fontSize: 16, fontWeight: FontWeight.w500),
          const SizedBox(width: 5),
          RatingBar.builder(
            initialRating: rating,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 24,
            itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: onRatingUpdate,
          ),
          const SizedBox(width: 5),
          Expanded(
            child: CustomText(
              title: description,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final UserRatingController controller = Get.put(UserRatingController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomNetworkImage(
              imageUrl: widget.restaurantImageUrl,
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
                left: 16,
                right: 16,
                top: Get.height / 14,
                bottom: 16,
              ),
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
                    title: widget.itemName,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: AppColors.secondaryColor,
                  ),
                  CustomText(
                    title: '🌟€${widget.itemPrice} 🌟',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: AppColors.blackColor,
                  ),
                  heightBox20,
                  Center(
                    child: CustomText(
                      title: 'How is your experience?',
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
                  buildRatingRow(
                      "Service:", serviceRating, reviewFormat(serviceRating),
                      (rating) {
                    setState(() {
                      serviceRating = rating;
                    });
                  }),
                  buildRatingRow("Food:", foodRating, reviewFormat(foodRating),
                      (rating) {
                    setState(() {
                      foodRating = rating;
                    });
                  }),
                  buildRatingRow(
                      "Ambience:", ambienceRating, reviewFormat(ambienceRating),
                      (rating) {
                    setState(() {
                      ambienceRating = rating;
                    });
                  }),
                  buildRatingRow("Cleanliness:", cleanlinessRating,
                      reviewFormat(cleanlinessRating), (rating) {
                    setState(() {
                      cleanlinessRating = rating;
                    });
                  }),
                  heightBox10,
                  Center(
                    child: Column(
                      children: [
                        CustomText(
                            title: "Your overall rating",
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        const SizedBox(height: 5),
                        RatingBar.builder(
                          initialRating: overallRating,
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
                          onRatingUpdate: (_) {},
                          ignoreGestures: true,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          reviewFormat(overallRating),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: overallRating >= 4.5
                                ? Colors.green
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Obx(
                    () => controller.isLoading.value
                        ? Center(child: CustomLoader())
                        : Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  title: 'Cancel',
                                  buttonColor: Colors.white,
                                  titleColor: AppColors.primaryColor,
                                  border:
                                      Border.all(color: AppColors.primaryColor),
                                  onTap: () {
                                    Navigator.pop(context);
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
                                    controller.submitRating(
                                        foodId: widget.foodId,
                                        service: serviceRating,
                                        food: foodRating,
                                        ambience: ambienceRating,
                                        cleanliness: cleanlinessRating,
                                        context: context);
                                  },
                                ),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
