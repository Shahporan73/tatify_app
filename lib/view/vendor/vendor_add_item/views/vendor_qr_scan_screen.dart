import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:get/get.dart';
import 'package:tatify_app/res/custom_style/custom_style.dart';
import '../../../user/user_booking/controller/booking_controller.dart';

class VendorQrScanScreen extends StatefulWidget {
  const VendorQrScanScreen({super.key});

  @override
  State<VendorQrScanScreen> createState() => _VendorQrScanScreenState();
}

class _VendorQrScanScreenState extends State<VendorQrScanScreen>
    with TickerProviderStateMixin {
  String? qrCode;
  final BookingController bookingController = Get.put(BookingController());

  bool _isProcessing = false;

  // Animation controller for fade-in effect on scanned text
  late final AnimationController _fadeAnimationController;
  late final Animation<double> _opacityAnimation;

  // Animation controller for scanning line
  late final AnimationController _scanLineController;
  late final Animation<double> _scanLineAnimation;

  @override
  void initState() {
    super.initState();

    _fadeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _opacityAnimation =
        Tween<double>(begin: 0, end: 1).animate(_fadeAnimationController);

    // Scanner line animation controller (infinite up/down)
    _scanLineController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _scanLineAnimation =
        Tween<double>(begin: 0, end: 1).animate(_scanLineController);
  }

  @override
  void dispose() {
    _fadeAnimationController.dispose();
    _scanLineController.dispose();
    super.dispose();
  }

  Future<void> _handleScan(String code) async {
    setState(() {
      qrCode = code;
      _isProcessing = true;
    });

    _fadeAnimationController.reset();
    _fadeAnimationController.forward();

    bool success = await bookingController.vendorRedeem(redeemId: code);

    if (!success) {
      Get.rawSnackbar(message: 'Redeem failed for code: $code');
    }

    setState(() {
      _isProcessing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Fixed scanner box size
    final double scanBoxSize = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      appBar: AppBar(title: Text('qr_scanner'.tr)),
      body: Padding(
        padding: bodyPadding,
        child: Stack(
          children: [
            Column(
              children: [
                // Center scanner in a fixed square box
                Expanded(
                  flex: 4,
                  child: Center(
                    child: SizedBox(
                      width: scanBoxSize,
                      height: scanBoxSize,
                      child: Stack(
                        children: [
                          MobileScanner(
                            fit: BoxFit.cover,
                            onDetect: (barcodeCapture) async {
                              if (_isProcessing) return;

                              final List<Barcode> barcodes = barcodeCapture.barcodes;
                              if (barcodes.isNotEmpty) {
                                final String? code = barcodes.first.rawValue;
                                if (code != null && code != qrCode) {
                                  await _handleScan(code);
                                }
                              }
                            },
                          ),

                          // Scanning line animation
                          AnimatedBuilder(
                            animation: _scanLineAnimation,
                            builder: (context, child) {
                              return Positioned(
                                top: scanBoxSize * _scanLineAnimation.value,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.red.withOpacity(0.6),
                                        blurRadius: 8,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                /*Expanded(
                  flex: 1,
                  child: Center(
                    child: FadeTransition(
                      opacity: _opacityAnimation,
                      child: Text(
                        qrCode == null ? 'Scan a QR code' : 'Scanned: $qrCode',
                        style: const TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),*/
              ],
            ),

            if (_isProcessing)
              Container(
                color: Colors.black54,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
