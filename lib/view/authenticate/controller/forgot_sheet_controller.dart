// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/data/utils/const_value.dart';

import '../../../data/api_client/bace_client.dart';
import '../../../data/api_client/end_point.dart';
import '../../../data/local_database/local_data_base.dart';
import '../view/forgot_sheet_screen/otp_verify_sheet.dart';

class ForgotSheetController extends GetxController{
  var isLoading = false.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }


  Future<void> forgotPassword({required BuildContext context}) async {
    isLoading.value = true;
    try {

      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      Map<String, String> body = {
        'email': emailController.text,
      };

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.postRequest(
          api: EndPoint.forgotPasswordURL,
          body: body,
          headers: headers
        ),
      );

      if(responseBody['success'] == true){
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
          builder: (_) => OtpVerifySheet(),
        );
        Get.snackbar('Message', responseBody['message'],snackPosition: SnackPosition.TOP);
      }

    }catch(e){
      print('forgot password error $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resetPassword({required BuildContext context}) async {
    isLoading.value = true;
    try {

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': LocalStorage.getData(key: forgotPasswordToken),
      };

      Map<String, String> body = {
        'newPassword': newPasswordController.text,
        'confirmPassword': confirmPasswordController.text
      };

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.patchRequest(
          api: EndPoint.resetPasswordURL,
          body: body,
          headers: headers
        ),
      );

      if(responseBody['success'] == true){
        Navigator.pop(context);
        Get.snackbar('Message', responseBody['message'],snackPosition: SnackPosition.TOP);
      }

    }catch(e){
      print('forgot password error $e');
    } finally {
      isLoading.value = false;
    }
  }



}