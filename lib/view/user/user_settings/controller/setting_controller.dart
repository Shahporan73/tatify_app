import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/api_client/bace_client.dart';
import '../../../../data/api_client/end_point.dart';
import '../../../../data/local_database/local_data_base.dart';
import '../../../../data/utils/const_value.dart';
import '../../../authenticate/view/sign_in_screen.dart';

class SettingController extends GetxController{
  var isLoading = false.obs;
  TextEditingController oldPasswordC = TextEditingController();
  TextEditingController newPasswordC = TextEditingController();
  TextEditingController confirmPasswordC = TextEditingController();

  // Rx variables to store validation errors
  var oldPasswordError = Rxn<String>();
  var newPasswordError = Rxn<String>();
  var confirmPasswordError = Rxn<String>();

  // Validation logic
  void validateFields() {
    // Reset errors before validating
    oldPasswordError.value = null;
    newPasswordError.value = null;
    confirmPasswordError.value = null;

    // Old password validation
    if (oldPasswordC.text.isEmpty) {
      oldPasswordError.value = 'Please enter your old password';
    }

    // New password validation
    if (newPasswordC.text.isEmpty) {
      newPasswordError.value = 'Please enter your new password';
    } else if (newPasswordC.text.length < 6) {
      newPasswordError.value = 'Password must be at least 6 characters';
    }

    // Confirm password validation
    if (confirmPasswordC.text.isEmpty) {
      confirmPasswordError.value = 'Please confirm your new password';
    } else if (confirmPasswordC.text != newPasswordC.text) {
      confirmPasswordError.value = 'Passwords do not match';
    }
  }

  Future<void> changePassword(context) async {
    isLoading.value = true;
    try {
      Map<String, String> body = {
        'oldPassword': oldPasswordC.text,
        'newPassword': newPasswordC.text,
      };
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': await LocalStorage.getData(key: accessToken),
      };
      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.putRequest(
          api: EndPoint.changePasswordURL,
          body: body,
          headers: headers,
        ),
      );

      if(responseBody != null && responseBody['success'] == true){
        Get.snackbar('Success', 'Password successfully updated');
        Navigator.of(context).pop();
      }
    }catch(e){
      print('Change password error $e');
    }finally{
      isLoading.value = false;
    }
  }

  Future<void> deleteAccount(context) async {
    isLoading.value = true;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': await LocalStorage.getData(key: accessToken),
      };
      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.deleteRequest(
          api: EndPoint.deleteAccountURL,
          headers: headers,
        ),
      );

      if(responseBody != null && responseBody['success'] == true){
        Get.snackbar('Success', 'Account successfully deleted');
        Navigator.of(context).pop();
        LocalStorage.removeAllData();
        Get.offAll(()=> SignInScreen());
      }
    }catch(e){
      print('Delete account error $e');
    }finally{
      isLoading.value = false;
    }
  }


  @override
  void onClose() {
    // Dispose controllers when the controller is disposed
    oldPasswordC.dispose();
    newPasswordC.dispose();
    confirmPasswordC.dispose();
    super.onClose();
  }


}