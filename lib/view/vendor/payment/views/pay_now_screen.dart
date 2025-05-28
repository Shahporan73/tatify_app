import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/data/utils/const_value.dart';
import 'package:tatify_app/data/utils/custom_loader.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/view/vendor/payment/controller/payment_controller.dart';

import '../../../../data/local_database/local_data_base.dart';
import '../../../../res/common_widget/main_app_bar.dart';

class PayNowScreen extends StatelessWidget {
  const PayNowScreen({Key? key}) : super(key: key);

  Future<bool> _onWillPop() async {
    await LocalStorage.removeData(key: accessToken);
    print('accessToken removed ${LocalStorage.getData(key: accessToken)}');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final PaymentController paymentController = Get.put(PaymentController());

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: MainAppBar(title: 'subscriptions'.tr),
        body: Obx(() {

          if (paymentController.subscriptionList.isEmpty) {
            return Center(
              child: CustomText(
                title: 'no_subscription_data_available'.tr,
                fontSize: 16,
                color: Colors.white,
                textAlign: TextAlign.center,
              ),
            );
          }

          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF6F00), Color(0xFFFFA000)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
            child:paymentController.isLoading.value ?
            Center(child: CustomLoader()):
            paymentController.subscriptionList.isEmpty?
            Center(
              child: CustomText(
                title: 'no_subscription_data_available'.tr,
                fontSize: 16,
                color: Colors.white,
                textAlign: TextAlign.center,
              ),
            ):
            ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: paymentController.subscriptionList.length,
              itemBuilder: (context, index) {
                var data = paymentController.subscriptionList[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: const Icon(
                          Icons.restaurant,
                          size: 90,
                          color: Color(0xFFFF6F00),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: CustomText(
                          title: data.name ?? '',
                          maxLines: 1,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFFFF6F00),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomText(
                        title: data.description ?? '',
                        fontSize: 14,
                        color: Colors.black87,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        child: Obx(() => paymentController.isPayNowLoading.value
                            ? CustomLoader()
                            : ElevatedButton(
                          onPressed: () {
                            paymentController.onCheckOutPayment(subscriptionId: data.id ?? '');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF6F00),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 8,
                            shadowColor: Colors.orangeAccent,
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.1,
                            ),
                          ),
                          child: CustomText(
                              title: '${'pay_now'.tr} ${data.amount?.toStringAsFixed(2) ?? '0.00'}',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
