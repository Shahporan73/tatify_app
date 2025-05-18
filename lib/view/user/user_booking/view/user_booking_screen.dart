// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/res/common_widget/empty_restaurant_view.dart';
import 'package:tatify_app/res/common_widget/main_app_bar.dart';
import 'package:tatify_app/res/custom_style/custom_style.dart';
import 'package:tatify_app/view/user/user_booking/controller/booking_controller.dart';
import 'package:tatify_app/view/user/user_booking/view/user_redeem_deal_screen.dart';
import 'package:tatify_app/view/user/user_booking/widget/booking_card_widget.dart';
import 'package:tatify_app/view/vendor/vendor_redeem/views/redeem_deal_screen.dart';

import '../../../../data/utils/custom_loader.dart';

class UserBookingScreen extends StatelessWidget {
  const UserBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BookingController controller = Get.put(BookingController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppBar(
        title: 'Booking',
        leading: SizedBox(),
        backgroundColor: Colors.white,
      ),
      body: Obx(
        () {
          print('getBookRedeemList ${controller.getBookRedeemList.length}');
          return SingleChildScrollView(
            padding: bodyPadding,
            child: controller.isLoading.value ? CustomLoader() :
            controller.getBookRedeemList.isEmpty && !controller.isLoading.value ? EmptyRestaurantView(
              title: 'No Booking Found',
            ) : ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: controller.getBookRedeemList.length,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                var data = controller.getBookRedeemList[index];
                return GestureDetector(
                  onTap: () {
                    if (data.userRedeem?.redeemStatus == 'pending') {
                      Get.to(() => UserRedeemDealScreen(redeemId: data.id ?? '',));
                    }else{
                      Get.rawSnackbar(message: 'Already Redeemed');
                    }
                  },
                  child: BookingCardWidget(
                    title: data.food?.itemName ?? 'Not Available',
                    price: data.cash?.payableAmount?.toStringAsFixed(0) ?? '00',
                    description: data.food?.description ?? 'Not Available',
                    location: data.restaurant?.address ?? 'Not Available',
                    isRedeem: data.userRedeem?.redeemStatus == 'pending' ? false : true,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
