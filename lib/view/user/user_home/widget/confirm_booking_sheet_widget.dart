// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/common_widget/custom_button.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/view/user/user_booking/controller/booking_controller.dart';
import 'package:tatify_app/view/user/user_home/view/book_deal_success_screen.dart';

class ConfirmBookingSheetWidget extends StatelessWidget {
  final String foodName;
  final String foodPrice;
  final String foodDesc;
  final String foodId;
  const ConfirmBookingSheetWidget(
      {super.key,
      required this.foodName,
      required this.foodPrice,
      required this.foodDesc,
      required this.foodId});

  @override
  Widget build(BuildContext context) {
    final BookingController controller = Get.put(BookingController());
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 32, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title: foodName,
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.black,
          ),
          heightBox5,
          CustomText(
            title: '🌟€$foodPrice 🌟',
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.black,
          ),
          heightBox10,
          CustomText(
            title: foodDesc,
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: Colors.black,
          ),
          Spacer(),
          Obx(
            ()=> CustomButton(
              title: 'Book Deal',
              isLoading: controller.isLoading.value,
              onTap: () {
               controller.createBooking(foodId: foodId, context: context);
              },
              buttonColor: AppColors.secondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
