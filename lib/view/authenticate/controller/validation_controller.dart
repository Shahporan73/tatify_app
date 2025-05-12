import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ValidationController extends GetxController{


  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();


  final otpController = TextEditingController();

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();


  final bankNameController = TextEditingController();
  final holderNameController = TextEditingController();
  final ibanNumberController = TextEditingController();




  String? validateCreateUserAccount() {
    // Check if all fields are filled
    if (nameController.text.isEmpty) {
      return "Name is required";
    }

    if (phoneController.text.isEmpty) {
      return "Phone number is required";
    }
    // else if (phoneController.text.length < 10) {
    //   return "Enter a valid phone number";
    // }
    if (addressController.text.isEmpty) {
      return "Address is required";
    }

    if (emailController.text.isEmpty) {
      return "Email is required";
    } else if (!GetUtils.isEmail(emailController.text)) {
      return "Enter a valid email address";
    }

    if (passwordController.text.isEmpty) {
      return "Password is required";
    } else if (passwordController.text.length < 6) {
      return "Password should be at least 6 characters long";
    }

    if (confirmPasswordController.text.isEmpty) {
      return "Confirm password is required";
    } else if (passwordController.text != confirmPasswordController.text) {
      return "Passwords do not match";
    }
    // All validations passed
    return null;
  }

  String? validateCreateVendorAccount() {
    // Check if all fields are filled
    if (nameController.text.isEmpty) {
      return "Name is required";
    }

    if (bankNameController.text.isEmpty) {
      return "Bank name is required";
    }
    if (holderNameController.text.isEmpty) {
      return "Holder name is required";
    }
    if (ibanNumberController.text.isEmpty) {
      return "IBAN number is required";
    }
    if(ibanNumberController.text.trim().length < 15 || ibanNumberController.text.trim().length > 34){
      return "IBAN length must be between 15 and 34 characters";
    }

    if (phoneController.text.isEmpty) {
      return "Phone number is required";
    }
    // else if (phoneController.text.length < 10) {
    //   return "Enter a valid phone number";
    // }

    if (emailController.text.isEmpty) {
      return "Email is required";
    } else if (!GetUtils.isEmail(emailController.text)) {
      return "Enter a valid email address";
    }

    if (passwordController.text.isEmpty) {
      return "Password is required";
    } else if (passwordController.text.length < 6) {
      return "Password should be at least 6 characters long";
    }

    if (confirmPasswordController.text.isEmpty) {
      return "Confirm password is required";
    } else if (passwordController.text != confirmPasswordController.text) {
      return "Passwords do not match";
    }
    // All validations passed
    return null;
  }

}