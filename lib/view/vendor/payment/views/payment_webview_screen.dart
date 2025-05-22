import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../res/app_colors/App_Colors.dart';
import '../../../../res/common_widget/custom_text.dart';
import '../controller/payment_controller.dart';
class PaymentWebView extends StatefulWidget {
  final String paymentUrl;

  const PaymentWebView({super.key, required this.paymentUrl});

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late final WebViewController _controller;
  final PaymentController _paymentController = Get.put(PaymentController());

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            print("Navigating to: $url");
          },
          onPageFinished: (String url) {
            print("Finished Loading: $url");

            _paymentController.paymentResults(finishUrl: url);
            // Detect Payment Success or Failure
            // if (url.contains("success")) {
            //   _paymentController.paymentResults(finishUrl: url);
            //   print("Payment Success");
            // } else if (url.contains("failed") || url.contains("payment-failed")) {
            //   Get.snackbar("Payment Failed", "Please try again.");
            // }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: CustomText(
          title: "Payment",
          fontSize: 15,
          color: Colors.white,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
