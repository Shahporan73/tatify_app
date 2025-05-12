// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tatify_app/data/utils/custom_loader.dart';
import 'package:tatify_app/view/user/user_favorite/controller/favorite_controller.dart';

import '../../../../res/app_colors/App_Colors.dart';
import '../../../../res/common_widget/custom_text.dart';

class RestaurantDetailsHeaderWidget extends StatelessWidget {
  final String restaurantId;
  const RestaurantDetailsHeaderWidget({super.key, required this.restaurantId});

  final String image = 'https://t4.ftcdn.net/jpg/02/74/99/01/360_F_274990113_ffVRBygLkLCZAATF9lWymzE6bItMVuH1.jpg';
  @override
  Widget build(BuildContext context) {
    final FavoriteController favoriteController = Get.put(FavoriteController());
    return Container(
      height: Get.height / 3,
      width: Get.width,
      child: Stack(
        children: [
          // Header image
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: Get.height / 2.5,
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
                        return child;
                      }
                      return SizedBox.shrink();
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
                InkWell(
                  onTap: () {
                    favoriteController.createFavorite(restaurantId: restaurantId);
                  },
                  child: Obx(
                    ()=> Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Color(0xffEBEBEB), width: 1),
                      ),
                      child: favoriteController.isLoading.value?
                      CustomLoader(size: 26,):
                      Center(child: Icon(Icons.favorite_outline, color: AppColors.secondaryColor,),)
                    ),
                  ),
                ),

              ],
            ),
          ),

          // details header
          Positioned(
            top: Get.height / 5,
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
