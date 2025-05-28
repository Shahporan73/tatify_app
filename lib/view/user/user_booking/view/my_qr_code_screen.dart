import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tatify_app/res/common_widget/main_app_bar.dart';

class MyQrCodeScreen extends StatelessWidget {
  final String foodId;
  const MyQrCodeScreen({super.key, required this.foodId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppBar(title: 'qr_code'.tr),
      body: Center(
        child: QrImageView(
          data: foodId,
          version: QrVersions.auto,
          size: 300.0,
          gapless: false,
        ),
      ),
    );
  }
}
