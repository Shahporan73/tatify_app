import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/res/common_widget/main_app_bar.dart';
import 'package:tatify_app/res/custom_style/custom_style.dart';
import 'package:tatify_app/view/vendor/vendor_redeem/views/redeem_deal_screen.dart';
import 'package:tatify_app/view/vendor/vendor_redeem/widget/request_redeem_widget.dart';

class VendorRedeemScreen extends StatelessWidget {
  const VendorRedeemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: 'Request'),
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
                Get.to(()=>RedeemDealScreen());
              },
              child: RequestRedeemWidget(),
            );
          },
        ),
      ),
    );
  }
}
