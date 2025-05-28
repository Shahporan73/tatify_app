import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import 'package:tatify_app/data/utils/custom_loader.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/common_widget/main_app_bar.dart';
import 'package:tatify_app/res/custom_style/custom_style.dart';
import 'package:tatify_app/res/utils/created_at.dart';
import 'package:tatify_app/view/vendor/vendor_profile/controller/vendor_booking_controller.dart';
import 'package:tatify_app/view/vendor/vendor_profile/widget/history_widget.dart';

import '../../../../res/common_widget/empty_restaurant_view.dart';

class VendorHistoryScreen extends StatelessWidget {
  VendorHistoryScreen({super.key});

  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context, VendorBookingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.orange,
            colorScheme: ColorScheme.light(primary: Colors.orange),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      await controller.getFilteredBookRedeem(selectedDate!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final VendorBookingController controller = Get.put(VendorBookingController());
    print('Booking complete ${controller.getBookRedeemList.length}');
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: MainAppBar(
        title: 'history'.tr,
        backgroundColor: AppColors.bgColor,
      ),
      body: RefreshIndicator(
        color: AppColors.primaryColor,
        onRefresh: () async{
         await controller.onRefresh();
        },
        child: Obx(
          ()=> Padding(
            padding: bodyPadding,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Row(
                    children: [
                      Spacer(),
                      CustomText(title: 'filter'.tr, fontSize: 16, fontWeight: FontWeight.w600,),
                      IconButton(
                        onPressed: () {
                          _selectDate(context, controller);
                        },
                        icon: Icon(
                          Icons.calendar_month_outlined,
                          color: AppColors.secondaryColor,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: controller.isLoading.value ? CustomLoader() :
                    controller.getBookRedeemList.isEmpty ? EmptyRestaurantView(title: 'no_history_found'.tr,) :
                    ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: controller.getBookRedeemList.length,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var data = controller.getBookRedeemList[index];
                    return HistoryWidget(
                        foodImage: '',
                        foodName: data.food?.itemName ?? '',
                        foodPrice: data.cash?.payableAmount?.toStringAsFixed(0) ?? '',
                        foodDescription: data.food?.description ?? '',
                        redeemDate: createdAt(data.vendorRedeem?.redeemDate.toString()),
                        userName: data.user?.name ?? '',
                        userEmail: data.user?.email ?? '',
                        userPhone: data.user?.phoneNumber ?? '',
                    );
                  },
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
