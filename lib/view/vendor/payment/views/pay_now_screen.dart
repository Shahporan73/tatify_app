import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tatify_app/data/utils/custom_loader.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/view/vendor/payment/controller/payment_controller.dart';

class PayNowScreen extends StatelessWidget {
  const PayNowScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaymentController paymentController = Get.put(PaymentController());
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFF6F00), Color(0xFFFFA000)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Center(
          child: Container(
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
              children: [
                const Icon(
                  Icons.restaurant,
                  size: 90,
                  color: Color(0xFFFF6F00),
                ),
                const SizedBox(height: 24),
                CustomText(
                  title: 'Activate Your Monthly Membership',
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFFFF6F00),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                CustomText(
                  title:
                      'To access and manage your profile, menu, and other features, '
                      'please complete your monthly membership payment. '
                      'Membership renewal is required every month to maintain uninterrupted access.',
                  fontSize: 14,
                  color: Colors.black87,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 36),
                Obx(
                  ()=> SizedBox(
                    width: double.infinity,
                    child: paymentController.isLoading.value ?
                    CustomLoader() :
                    ElevatedButton(
                      onPressed: () {
                        paymentController.onCheckOutPayment();
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
                          title: 'Pay Now',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
