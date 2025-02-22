import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tatify_app/view/user/user_home/view/home_dashboard.dart';
import 'package:tatify_app/view/vendor/vendor_home/views/vendor_home_dashboard.dart';

class SignInController extends GetxController{
  // Controller to handle checkbox state using GetX
  var isSelected = false.obs;
  // Visibility state for password fields
  RxBool isPasswordVisible = false.obs;
  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  final TextEditingController emailC = TextEditingController();
  final TextEditingController passC = TextEditingController();

  String? validateField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

/*
  TextFormField(
  decoration: InputDecoration(
  labelText: 'Enter text',
  errorText: validateField(yourTextController.text),
  ),
  controller: yourTextController,
  )
*/




  void checkUser(){
    if(emailC.text.isEmpty && passC.text.isEmpty){
      Get.rawSnackbar(message: "Please enter email and password");
    }else if(emailC.text.contains('@') == false){
      Get.rawSnackbar(message: "Please enter valid email");
    }else if(passC.text.length < 6){
      Get.rawSnackbar(message: "Password must be at least 6 characters");
    }else if(emailC.text == 'user@gmail.com' && passC.text == '123456'){
      Get.to(()=>HomeDashboard());
    }else if(emailC.text == 'vendor@gmail.com' && passC.text == '123456'){
      Get.to(()=>VendorHomeDashboard());
    }
  }

}