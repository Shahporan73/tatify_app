// ignore_for_file: empty_catches, avoid_print, prefer_const_constructors, unnecessary_null_comparison

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/data/api_client/end_point.dart';
import 'package:tatify_app/data/utils/const_value.dart';
import 'package:tatify_app/view/authenticate/view/restaurant_information_screen.dart';

import '../../../data/api_client/bace_client.dart';
import '../../../data/local_database/local_data_base.dart';
import '../view/forgot_sheet_screen/reset_password_sheet.dart';
import '../view/sign_in_screen.dart';

class OtpController extends GetxController {
  final otpControllers = List.generate(4, (index) => TextEditingController());
  final verifyOtpControllers = List.generate(4, (index) => TextEditingController());
  var isLoading = false.obs;

  var secondsRemaining = 120.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--; // Update remaining time
      } else {
        timer.cancel();
      }
    });
  }

  void resetTimer() {
    secondsRemaining.value = 120; // Reset to 2 minutes
    startTimer();
  }

  void otpSubmitted(String email, bool isVendor) async {
    String otp = otpControllers.map((controller) => controller.text).join('');
    isLoading(true);

    String? token = LocalStorage.getData(key: otpToken);

    if (token == null) {
      print("Token not found");
      throw "Token not found";
    }

    // Check if OTP is not empty
    if (otp.trim().isNotEmpty) {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': token,
      };

      Map<String, String> body = {
        'email': email,
        'otp': otp.trim(),
      };

      try {
        dynamic responseBody = await BaseClient.handleResponse(
          await BaseClient.putRequest(
            api: EndPoint.verifyEmailByOtpURL,
            body: body,
            headers: headers,
          ),
        );
        if (responseBody != null && responseBody['success'] == true) {
          Get.snackbar('Message', responseBody['message'],
              snackPosition: SnackPosition.TOP);
          if (isVendor==true) {
            Get.offAll(() => RestaurantInformationScreen());
          }else{
            Get.offAll(() => SignInScreen());
          }

          otpControllers.clear();
          _timer?.cancel();
          isLoading(false);
        } else {
          throw "Invalid response: Missing token";
        }
      } catch (e) {
        debugPrint("Catch Error: " + e.toString());
        Get.rawSnackbar(message: e.toString());
      } finally {
        isLoading(false);
      }
    } else {
      // Show an error if the OTP field is empty
      Get.snackbar("Error", "Please enter the OTP",
          snackPosition: SnackPosition.TOP);
      isLoading(false);
    }
  }


  void verifyOtpForgotMail({required BuildContext context}) async {
    String otp = verifyOtpControllers.map((controller) => controller.text).join('').trim();

    isLoading(true);

    String? token = LocalStorage.getData(key: forgotPasswordToken);

    if (token == null) {
      throw "Token not found";
    }

    if (otp.isNotEmpty) {
      Map<String, String> headers = {
        'content-type': 'application/json',
        'Authorization': token,
      };

      Map<String, String> body = {
        'otp': otp,
      };

      try {
        dynamic responseBody = await BaseClient.handleResponse(
          await BaseClient.patchRequest(
            api: EndPoint.otpVerifyURL,
            body: body,
            headers: headers,
          ),
        );

        if (responseBody != null && responseBody is Map) {
          if (responseBody['success'] == true) {
            Get.snackbar('Message', responseBody['message'], snackPosition: SnackPosition.TOP);

            String token = responseBody['data']['resetToken'];
            LocalStorage.saveData(key: forgotPasswordToken, data: token);

            Navigator.pop(context);
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              isDismissible: false,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (_) => ResetPasswordSheet(),
            );
            verifyOtpControllers.clear();
            _timer?.cancel();
          } else {
            Get.snackbar("Error", responseBody['message'] ?? "Unknown error", snackPosition: SnackPosition.TOP);
          }
        } else {
          Get.snackbar("Error", "Invalid response format", snackPosition: SnackPosition.TOP);
        }
      } catch (e) {
        debugPrint("Catch Error: " + e.toString());
        Get.rawSnackbar(message: e.toString());
      } finally {
        isLoading(false);
      }
    } else {
      Get.snackbar("Error", "Please enter the OTP", snackPosition: SnackPosition.TOP);
      isLoading(false);
    }
  }


  void resendOtp(String email) async {
    isLoading(true);
    /// Logic to resend OTP
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };


    try {
      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.putRequest(
          api: EndPoint.resendOtpUrl(email: email),
          headers: headers,
          body: {},
        ),
      );
      print("Signup URL: ${EndPoint.resendOtpUrl(email: email)}");
      print("response body ======> $responseBody");

      if (responseBody != null) {
        if (secondsRemaining.value == 0) {
          resetTimer();
        }
        otpControllers.clear();
        print("======otp send success");

        String token = responseBody['data']['emailVerifyToken'];

        print("otp-token ===> $token");

        LocalStorage.saveData(key: otpToken, data: token);
        Get.snackbar("Success", "OTP sent successfully");
      } else {
        throw "Time expired";
      }
    } catch (e) {
      debugPrint("Catch Error:::::: " + e.toString());
      Get.rawSnackbar(message: e.toString());
    }finally {
      isLoading(false);
    }
  }

  void ResendOtpForForgot(String email, context) async {
    try {

      Map<String, String> body = {
        'email': email,
      };

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.postRequest(
          api: EndPoint.forgotPasswordURL,
          body: body,
        ),
      );

      if(responseBody['success'] == true){
        if (secondsRemaining.value == 0) {
          resetTimer();
        }
        otpControllers.clear();
        print("======otp send success");
        String token = responseBody['data']['resetToken'];
        LocalStorage.saveData(key: forgotPasswordToken, data: token);
        Get.snackbar('Message', responseBody['message'],snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      debugPrint("Catch Error:::::: " + e.toString());
      Get.rawSnackbar(message: e.toString());
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }


}
