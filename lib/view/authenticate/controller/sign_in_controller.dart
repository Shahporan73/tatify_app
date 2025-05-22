import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/data/local_database/local_data_base.dart';
import 'package:tatify_app/view/user/user_home/view/home_dashboard.dart';
import 'package:tatify_app/view/vendor/payment/views/pay_now_screen.dart';
import 'package:tatify_app/view/vendor/vendor_home/views/vendor_home_dashboard.dart';

import '../../../data/api_client/bace_client.dart';
import '../../../data/api_client/end_point.dart';
import '../../../data/utils/const_value.dart';

class SignInController extends GetxController{
  var isSelected = false.obs;
 var isLoading = false.obs;
  RxBool isPasswordVisible = false.obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _loadRememberedState();
  }


  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }


  final TextEditingController emailC = TextEditingController();
  final TextEditingController passC = TextEditingController();

  // String? validateField(String? value) {
  //   if (value == null || value.trim().isEmpty) {
  //     return 'This field cannot be empty';
  //   }
  //   return null;
  // }

  void checkUser(){
    /*if(emailC.text.isEmpty && passC.text.isEmpty){
      Get.rawSnackbar(message: "Please enter email and password");
    }else if(emailC.text.contains('@') == false){
      Get.rawSnackbar(message: "Please enter valid email");
    }else if(passC.text.length < 6){
      Get.rawSnackbar(message: "Password must be at least 6 characters");
    }else*/

      /*if(emailC.text == 'user@gmail.com' && passC.text == '123456'){
      Get.to(()=>HomeDashboard());
    }else */
      if(emailC.text == 'vendor@gmail.com' && passC.text == '123456'){
      Get.to(()=>VendorHomeDashboard());
    }
  }

  String? validateLogin() {
    if (emailC.text.isEmpty) {
      return "Email is required";
    } else if (!GetUtils.isEmail(emailC.text)) {
      return "Enter a valid email address";
    }

    if (passC.text.isEmpty) {
      return "Password is required";
    } else if (passC.text.length < 6) {
      return "Password should be at least 6 characters long";
    }
    // All validations passed
    return null;
  }


  // Load saved remember me state and other data
  _loadRememberedState() async {
    // Load checkbox state (remember me)
    String? rememberMe = await LocalStorage.getData(key: saveRememberMe);
    if (rememberMe != null && rememberMe == 'true') {
      isSelected.value = true;
      emailC.text = await LocalStorage.getData(key: saveEmail) ?? '';
      passC.text = await LocalStorage.getData(key: savePassword) ?? '';
    }
  }

  // Save email, password, and checkbox state
  isRemembered() async {
    if (isSelected.value) {
      await LocalStorage.saveData(key: saveEmail, data: emailC.text);
      await LocalStorage.saveData(key: savePassword, data: passC.text);
      await LocalStorage.saveData(key: saveRememberMe, data: 'true');
    } else {
      await LocalStorage.removeData(key: saveEmail);
      await LocalStorage.removeData(key: savePassword);
      await LocalStorage.saveData(key: saveRememberMe, data: 'false');
    }
  }

  /// sign up
  Future<void> loginMethod() async {
    isLoading.value = true;

    String fcmToken = await getFcmTokenForLoggedInUser() ?? '';
    if (fcmToken != null) {
      print('FCM Token: $fcmToken');
    }
    try {
      Map<String, String> body = {
        'email': emailC.text,
        'password': passC.text,
        'fcmToken': fcmToken
      };

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.postRequest(
          api: EndPoint.loginURL,
          body: body,
        ),
      );

      if (responseBody != null) {
        if (responseBody['success'] == true) {
          String token = responseBody['data']['accessToken'];
          print('accessToken $token');

          LocalStorage.saveData(key: accessToken, data: token);
          print('accessToken main ${LocalStorage.getData(key: accessToken)}');

          String role = responseBody['data']['user']['role'];

          LocalStorage.saveData(key: userType, data: role);

          if(responseBody['data']['user']['role'] == 'vendor'){
            Get.to(() => PayNowScreen());
          }if(responseBody['data']['user']['role'] == 'user'){
            Get.to(() => HomeDashboard());
          }

          Get.rawSnackbar(message: responseBody['message'],
              backgroundColor: Colors.green,
              snackPosition: SnackPosition.TOP
          );
        }else{
         Get.rawSnackbar(message: responseBody['message'],snackPosition: SnackPosition.TOP);
         print('responseBody ${responseBody['message']}');
        }
      }

    } catch (e) {
      print('sign in error $e');
    } finally {
      // Handle sign up success
      isLoading.value = false;
    }
  }

  Future<String?> getFcmTokenForLoggedInUser() async {
    try {
      await FirebaseMessaging.instance.requestPermission();
      String? token = await FirebaseMessaging.instance.getToken();

      if (token != null) {
        print('FCM Token: $token');
      } else {
        print('Failed to get FCM token');
      }

      return token;
    } catch (e) {
      print('Error getting FCM token: $e');
      return null;
    }
  }

}