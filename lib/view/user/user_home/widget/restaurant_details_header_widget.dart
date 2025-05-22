// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tatify_app/data/utils/custom_loader.dart';
import 'package:tatify_app/res/common_widget/custom_network_image_widget.dart';
import 'package:tatify_app/view/user/user_favorite/controller/favorite_controller.dart';

import '../../../../res/app_colors/App_Colors.dart';
import '../../../../res/common_widget/custom_text.dart';

class RestaurantDetailsHeaderWidget extends StatelessWidget {
  final String restaurantImage;
  final String restaurantName;
  final String rating;
  final String restaurantId;
  final String kitchenType;
  const RestaurantDetailsHeaderWidget(
      {super.key,
      required this.restaurantId,
      required this.restaurantImage,
      required this.restaurantName,
      required this.rating,
      required this.kitchenType});
  @override
  Widget build(BuildContext context) {
    final FavoriteController favoriteController = Get.put(FavoriteController());

    return Obx(
      () {
        bool isFavorite = favoriteController.isFavorite(restaurantId);
        print('isFavorite $isFavorite');

        return Container(
          height: Get.height / 3,
          width: Get.width,
          child: Stack(
            children: [
              // Header image (no change)
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Container(
                  height: Get.height / 3.8,
                  child: CustomNetworkImage(
                      imageUrl: restaurantImage,
                      height: Get.height,
                      width: Get.width),
                ),
              ),

              // appbar with favorite icon
              Positioned(
                top: 8,
                right: 16,
                left: 16,
                child: Row(
                  children: [
                    // Back Button
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        favoriteController.createFavorite(
                            restaurantId: restaurantId
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: Color(0xffEBEBEB), width: 1),
                        ),
                        child: favoriteController.isLoading.value
                            ? CustomLoader(
                                size: 26,
                              )
                            : Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                color: isFavorite
                                    ? Colors.red
                                    : AppColors.secondaryColor,
                              ),
                      ),
                    ),
                  ],
                ),
              ),

              // details header (no change)
              Positioned(
                top: Get.height / 5,
                left: 24,
                right: 24,
                child: Center(
                  child: Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
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
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            CustomText(
                              title: restaurantName,
                              fontWeight: FontWeight.w600,
                              color: AppColors.secondaryColor,
                              fontSize: 18,
                            ),
                            Spacer(),
                            Row(
                              children: [
                                CustomText(
                                  title: rating,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 18,
                                )
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CustomText(
                              title: kitchenType,
                              fontWeight: FontWeight.w600,
                              color: AppColors.blackColor,
                              fontSize: 14,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
