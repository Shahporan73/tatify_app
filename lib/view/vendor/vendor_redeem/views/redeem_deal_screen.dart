// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/view/user/user_booking/controller/booking_controller.dart';
import 'package:tatify_app/view/vendor/vendor_redeem/views/redeem_success_screen.dart';


class RedeemDealScreen extends StatefulWidget {
  final String redeemId;
  const RedeemDealScreen({Key? key, required this.redeemId}) : super(key: key);
  @override
  _RedeemDealScreenState createState() => _RedeemDealScreenState();
}

class _RedeemDealScreenState extends State<RedeemDealScreen> {
  // null = idle, true = success, false = failed
  bool? isConfirmed;

  final BookingController controller = Get.put(BookingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.all(24),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, spreadRadius: 2)],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              title: "Redeem deal\nnow",
              textAlign: TextAlign.center,
              color: AppColors.blackColor,
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
            SizedBox(height: 20),
            if (isConfirmed == true) // Success UI
              Container(
                height: 56,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(50)),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Confirmed!", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(width: 8),
                    Icon(Icons.check_circle, color: Colors.white),
                  ],
                ),
              )
            else if (isConfirmed == false) // Failed UI
              GestureDetector(
                onTap: () {
                  Get.back(); // Go back on tap
                },
                child: Container(
                  height: 56,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(50)),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Redeem Failed. Tap to go back",
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(width: 8),
                      Icon(Icons.error, color: Colors.white),
                    ],
                  ),
                ),
              )
            else // Idle UI (slide to redeem)
              SlideAction(
                outerColor: Colors.grey[400]!,
                innerColor: Colors.white,
                text: "Slide To Redeem",
                textStyle: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold),
                onSubmit: () async {
                  bool success = await controller.vendorRedeem(redeemId: widget.redeemId);
                  setState(() {
                    isConfirmed = success;
                  });
                },
              ),
          ],
        ),
      ),
    );
  }
}

