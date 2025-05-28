// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tatify_app/res/common_widget/custom_network_image_widget.dart';
import 'package:tatify_app/view/vendor/vendor_profile/controller/my_restaurant_controller.dart';

import '../../../../res/app_colors/App_Colors.dart';
import '../../../../res/common_widget/custom_button.dart';
import '../../../../res/common_widget/custom_text.dart';
import '../../../../res/custom_style/custom_size.dart';
import '../views/add_item_screen.dart';

class AddedAllItemHeader extends StatelessWidget {
  const AddedAllItemHeader({super.key});
  @override
  Widget build(BuildContext context) {
    final MyRestaurantController controller = Get.put(MyRestaurantController());
    return Obx(
      ()=> SizedBox(
        width: Get.width,
        height: Get.height / 2.9,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: CustomNetworkImage(
                  imageUrl: controller.myRestaurantsModel.value.data?.featureImage ?? '',
                  height: Get.height / 3.8,
                  width: Get.width,
              )
            ),
            Positioned(
              top: Get.height / 6,
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
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          CustomText(
                            title:
                                controller.myRestaurantsModel.value.data?.name ??
                                    '',
                            fontWeight: FontWeight.w600,
                            color: AppColors.secondaryColor,
                            fontSize: 16,
                          ),
                          Spacer(),
                          Row(
                            children: [
                              CustomText(
                                title: controller.myRestaurantsModel.value.data?.review?.star.toString() ?? '',
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
                          Expanded(
                            child: CustomText(
                              title: controller.myRestaurantsModel.value.data?.kitchenStyle.join(', ') ?? '',
                              fontWeight: FontWeight.w400,
                              color: AppColors.blackColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      heightBox5,
                      CustomButton(
                        title: 'add_a_menu'.tr,
                        buttonColor: AppColors.secondaryColor,
                        padding_vertical: 8,
                        onTap: () {
                          Get.to(() => AddItemScreen());
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
