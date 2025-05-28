// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/app_const/app_const.dart';
import 'package:tatify_app/res/common_widget/empty_restaurant_view.dart';
import 'package:tatify_app/res/common_widget/main_app_bar.dart';
import 'package:tatify_app/res/custom_style/custom_style.dart';
import 'package:tatify_app/view/user/user_booking/controller/booking_controller.dart';
import 'package:tatify_app/view/user/user_booking/view/my_qr_code_screen.dart';
import 'package:tatify_app/view/user/user_booking/view/user_redeem_deal_screen.dart';
import 'package:tatify_app/view/user/user_booking/widget/booking_card_widget.dart';
import 'package:tatify_app/view/vendor/vendor_redeem/views/redeem_deal_screen.dart';

import '../../../../data/utils/custom_loader.dart';
import 'booking_deal_confirm_screen.dart';

class UserBookingScreen extends StatelessWidget {
  final BookingController controller = Get.put(BookingController());

  UserBookingScreen({super.key}) {
    controller.getBookRedeem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppBar(
        title: 'booking_title'.tr,   // key for "Booking"
        leading: SizedBox(),
        backgroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        color: AppColors.primaryColor,
        onRefresh: () async {
          await controller.getBookRedeem();
        },
        child: Obx(
              () {
            return SingleChildScrollView(
              padding: bodyPadding,
              child: controller.isLoading.value
                  ? CustomLoader()
                  : controller.getBookRedeemList.isEmpty &&
                  !controller.isLoading.value
                  ? EmptyRestaurantView(
                title: 'no_booking_found'.tr,  // key for "No Booking Found"
              )
                  : ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: controller.getBookRedeemList.length,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  var data = controller.getBookRedeemList[index];
                  return GestureDetector(
                    onTap: () {
                      if (data.vendorRedeem?.redeemStatus == 'pending') {
                        Get.to(() => MyQrCodeScreen(
                          foodId: data.id ?? '',
                        ));
                      } else {
                        Get.to(
                              () => BookingDealConfirmScreen(
                            restaurantImageUrl:
                            data.restaurant?.featureImage ?? placeholderImage,
                            itemName: data.food?.itemName ?? 'not_available'.tr, // key for "Not Available"
                            itemPrice:
                            data.cash?.payableAmount?.toStringAsFixed(0) ?? '00',
                            foodId: data.food?.id ?? '',
                          ),
                        );
                      }
                    },
                    child: BookingCardWidget(
                      title: data.food?.itemName ?? 'not_available'.tr,
                      price: data.cash?.payableAmount?.toStringAsFixed(0) ?? '00',
                      description: data.food?.description ?? 'not_available'.tr,
                      location: data.restaurant?.address ?? 'not_available'.tr,
                      isRedeem: data.vendorRedeem?.redeemStatus == 'pending' ? false : true,
                      restaurantName: data.restaurant?.name ?? 'not_available'.tr,
                      restaurantImage: data.restaurant?.featureImage ?? placeholderImage,
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

