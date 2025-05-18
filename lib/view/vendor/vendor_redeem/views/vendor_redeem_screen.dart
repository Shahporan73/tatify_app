// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/res/app_const/app_const.dart';
import 'package:tatify_app/res/common_widget/empty_restaurant_view.dart';
import 'package:tatify_app/res/common_widget/main_app_bar.dart';
import 'package:tatify_app/res/custom_style/custom_style.dart';
import 'package:tatify_app/view/user/user_booking/controller/booking_controller.dart';
import 'package:tatify_app/view/vendor/vendor_redeem/views/redeem_deal_screen.dart';
import 'package:tatify_app/view/vendor/vendor_redeem/widget/request_redeem_widget.dart';

import '../../../user/user_booking/widget/booking_card_widget.dart';

class VendorRedeemScreen extends StatelessWidget {
  const VendorRedeemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BookingController bookingController = Get.put(BookingController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppBar(title: 'Request'),
      body: Obx(() {
        return  SingleChildScrollView(
          padding: bodyPadding,
          child: bookingController.isLoading.value ? Center(child: CircularProgressIndicator(),) :
              bookingController.getBookRedeemList.isEmpty ? EmptyRestaurantView(title: 'No Request Found',) :
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: bookingController.getBookRedeemList.length,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              var data = bookingController.getBookRedeemList[index];
              return GestureDetector(
                onTap: () {
                  Get.to(()=>RedeemDealScreen(redeemId: data.id ?? '',));
                  if (data.userRedeem?.redeemStatus == 'pending') {
                    Get.to(()=>RedeemDealScreen(redeemId: data.id ?? '',));
                  }else{
                    Get.rawSnackbar(message: 'Already Redeemed');
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(1),
                  child: RequestRedeemWidget(
                    title: data.food?.itemName ?? 'Not Available',
                    price: data.cash?.payableAmount?.toStringAsFixed(0) ?? '00',
                    description: data.food?.description ?? 'Not Available',
                    location: data.restaurant?.address ?? 'Not Available',
                    isRedeem: data.vendorRedeem?.redeemStatus == 'pending' ? false : true,
                    userImage: data.user?.profileImage ?? placeholderImage,
                    userEmail: data.user?.email ?? '',
                    userName: data.user?.name ?? '',
                    userPhone: data.user?.phoneNumber ?? '',
                  ),
                ),
              );
            },
          ),
        );
      },)
    );
  }
}
