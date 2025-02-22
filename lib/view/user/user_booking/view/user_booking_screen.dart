// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/res/common_widget/main_app_bar.dart';
import 'package:tatify_app/res/custom_style/custom_style.dart';
import 'package:tatify_app/view/user/user_booking/view/user_redeem_deal_screen.dart';
import 'package:tatify_app/view/user/user_booking/widget/booking_card_widget.dart';
import 'package:tatify_app/view/vendor/vendor_redeem/views/redeem_deal_screen.dart';

class UserBookingScreen extends StatelessWidget {
  const UserBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppBar(title: 'Booking', leading: SizedBox(), backgroundColor: Colors.white,),
      body: SingleChildScrollView(
        padding: bodyPadding,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: 5,
          physics: ScrollPhysics(),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(()=>UserRedeemDealScreen());
              },
              child: BookingCardWidget(),
            );
          },
        ),
      ),
    );
  }
}
