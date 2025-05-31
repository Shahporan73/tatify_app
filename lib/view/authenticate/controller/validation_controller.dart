import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ValidationController extends GetxController {
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
    if (nameController.text.isEmpty) {
      return "name_is_required".tr;
    }

    if (phoneController.text.isEmpty) {
      return "phone_number_is_required".tr;
    }

    // if (addressController.text.isEmpty) {
    //   return "address_is_required".tr;
    // }

    if (emailController.text.isEmpty) {
      return "email_is_required".tr;
    } else if (!GetUtils.isEmail(emailController.text)) {
      return "enter_valid_email_address".tr;
    }

    if (passwordController.text.isEmpty) {
      return "password_is_required".tr;
    } else if (passwordController.text.length < 6) {
      return "password_minimum_6_chars".tr;
    }

    if (confirmPasswordController.text.isEmpty) {
      return "confirm_password_is_required".tr;
    } else if (passwordController.text != confirmPasswordController.text) {
      return "passwords_do_not_match".tr;
    }

    return null;
  }

  String? validateCreateVendorAccount() {
    if (nameController.text.isEmpty) {
      return "name_is_required".tr;
    }

    if (bankNameController.text.isEmpty) {
      return "bank_name_is_required".tr;
    }
    if (holderNameController.text.isEmpty) {
      return "holder_name_is_required".tr;
    }
    if (ibanNumberController.text.isEmpty) {
      return "iban_number_is_required".tr;
    }
    if (ibanNumberController.text.trim().length < 15 || ibanNumberController.text.trim().length > 34) {
      return "iban_length_between_15_34".tr;
    }

    if (phoneController.text.isEmpty) {
      return "phone_number_is_required".tr;
    }

    if (emailController.text.isEmpty) {
      return "email_is_required".tr;
    } else if (!GetUtils.isEmail(emailController.text)) {
      return "enter_valid_email_address".tr;
    }

    if (passwordController.text.isEmpty) {
      return "password_is_required".tr;
    } else if (passwordController.text.length < 6) {
      return "password_minimum_6_chars".tr;
    }

    if (confirmPasswordController.text.isEmpty) {
      return "confirm_password_is_required".tr;
    } else if (passwordController.text != confirmPasswordController.text) {
      return "passwords_do_not_match".tr;
    }

    return null;
  }
}
