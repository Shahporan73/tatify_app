// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:get/get.dart';
import 'package:tatify_app/data/api_client/end_point.dart';
import 'package:tatify_app/data/utils/const_value.dart';

import '../../../data/api_client/bace_client.dart';
import '../../../data/local_database/local_data_base.dart';
import '../view/email_verification_screen.dart';

class SignUpController extends GetxController {
  // Controller to handle checkbox state using GetX
  var isChecked = false.obs;
  var selectedRole = 'User'.obs;
  var isLoading = false.obs;
  // Visibility state for password fields
  RxBool isPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;
  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void changeRole(String role) {
    selectedRole.value = role;
  }

  /// sign up
  Future<void> createUserAccount(
      {required String fullName,
      required String phoneNumber,
      required String address,
      required String email,
      required double latitude,
      required double longitude,
      required String password,
      }) async {
    isLoading.value = true;
    try {
      Map<String, dynamic> body = {
        'name': fullName,
        'phoneNumber': phoneNumber,
        'address': address,
        'email': email,
        'location': {
          'coordinates': [longitude, latitude],
        },
        'password': password,
      };

      print('body $body');

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.postRequest(
          api: EndPoint.createUserURL,
          body: body,
        ),
      );

      if (responseBody != null) {
        if (responseBody['success'] == true) {
          print('responseBody $responseBody');
          String otp = responseBody['data']['emailVerifyToken'];
          print('otp $otp');
          LocalStorage.saveData(key: otpToken, data: otp);
          Get.to(() => EmailVerificationScreen(isVendor: false, email: email));
          Get.rawSnackbar(message: responseBody['message']);
        }
      }
    } catch (e) {
      print('sign up error $e');
    } finally {
      isLoading.value = false;
    }
  }


  /// sign up for vendor account
  Future<void> createVendorAccount(
      {required String fullName,
        required String phoneNumber,
        required String email,
        required bankName,
        required holderName,
        required ibanNumber,
        required String password,
      }) async {
    isLoading.value = true;
    try {
      Map<String, dynamic> body = {
        'name': fullName,
        'bank_name': bankName,
        'holder_name': holderName,
        'IBAN': ibanNumber,
        'phoneNumber': phoneNumber,
        'email': email,
        'password': password,
      };

      print('body $body');

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.postRequest(
          api: EndPoint.createVendorURL,
          body: body,
        ),
      );

      if (responseBody != null) {
        if (responseBody['success'] == true) {
          String otp = responseBody['data']['emailVerifyToken'];
          String venId = responseBody['data']['vendor']['user'];

          print('otp $otp');
          print('Vendor id $venId');

          LocalStorage.saveData(key: otpToken, data: otp);
          LocalStorage.saveData(key: vendorId, data: venId);

          Get.to(() => EmailVerificationScreen(isVendor: true, email: email));
          Get.rawSnackbar(message: responseBody['message']);
        }
      }
    } catch (e) {
      print('sign up error $e');
    } finally {
      isLoading.value = false;
    }
  }
}
