// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/common_widget/RoundTextField.dart';
import 'package:tatify_app/res/common_widget/country_code_picker.dart';
import 'package:tatify_app/res/common_widget/custom_button.dart';
import 'package:tatify_app/res/common_widget/custom_radio_button.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/res/custom_style/custom_style.dart';
import 'package:tatify_app/view/authenticate/controller/sign_up_controller.dart';
import 'package:tatify_app/view/authenticate/controller/validation_controller.dart';
import 'package:tatify_app/view/authenticate/view/sign_in_screen.dart';

import '../../../data/service/location_service.dart';
import '../../../res/app_images/App_images.dart';
import '../../../res/common_widget/custom_checkbox.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController controller = Get.put(SignUpController());
  final ValidationController validationController = Get.put(ValidationController());

  double? latitude;
  double? longitude;

  @override
  void initState() {
    super.initState();
    _getLocationData();
  }

  Future<void> _getLocationData() async {
    try {
      var location = await LocationServiceWithAddress.getCurrentLocationWithAddress();
      print('Latitude: ${location['latitude']}');
      print('Longitude: ${location['longitude']}');
      print('Address: ${location['address']}');

      setState(() {
        latitude = location['latitude'];
        longitude = location['longitude'];
      });

      validationController.addressController.text = location['address'];
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: bodyPadding,
          child: Obx(
                () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CustomText(
                    title: 'sign_up'.tr,
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Center(
                  child: Image.asset(
                    AppImages.splashLogo,
                    width: width / 1.8,
                    height: height / 12,
                  ),
                ),

                // full name
                Visibility(
                  visible: controller.selectedRole.value == "User" ||
                      controller.selectedRole.value == "Vendor",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heightBox10,
                      Text(
                        'full_name'.tr,
                        style: customLabelStyle,
                      ),
                      heightBox5,
                      RoundTextField(
                        hint: 'enter_your_full_name'.tr,
                        controller: validationController.nameController,
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),

                // bank name
                Visibility(
                  visible: controller.selectedRole.value == "Vendor",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heightBox10,
                      Text(
                        'bank_name'.tr,
                        style: customLabelStyle,
                      ),
                      heightBox5,
                      RoundTextField(
                        hint: 'enter_bank_name'.tr,
                        controller: validationController.bankNameController,
                      )
                    ],
                  ),
                ),

                // holder name
                Visibility(
                  visible: controller.selectedRole.value == "Vendor",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heightBox10,
                      Text(
                        'holder_name'.tr,
                        style: customLabelStyle,
                      ),
                      heightBox5,
                      RoundTextField(
                        hint: 'enter_holder_name'.tr,
                        controller: validationController.holderNameController,
                      )
                    ],
                  ),
                ),

                // IBAN
                Visibility(
                  visible: controller.selectedRole.value == "Vendor",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heightBox10,
                      Text(
                        'iban'.tr,
                        style: customLabelStyle,
                      ),
                      heightBox5,
                      RoundTextField(
                        controller: validationController.ibanNumberController,
                        hint: 'enter_your_iban_number'.tr,
                        prefixIcon: Icon(
                          Icons.call_to_action_rounded,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),

                // Phone number
                Visibility(
                  visible: controller.selectedRole.value == "User" ||
                      controller.selectedRole.value == "Vendor",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heightBox10,
                      CountryCodePicker(
                          controller: validationController.phoneController,
                          titleText: 'phone_number'.tr,
                          hintText: 'enter_phone_number'.tr),
                    ],
                  ),
                ),

                // address
                Visibility(
                  visible: controller.selectedRole.value == "User",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heightBox10,
                      Text(
                        'address'.tr,
                        style: customLabelStyle,
                      ),
                      heightBox5,
                      RoundTextField(
                        controller: validationController.addressController,
                        hint: 'enter_your_address'.tr,
                        readOnly: false,
                        prefixIcon: Icon(
                          Icons.location_on,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),

                // Email
                Visibility(
                  visible: controller.selectedRole.value == "User" ||
                      controller.selectedRole.value == "Vendor",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heightBox10,
                      Text(
                        'email'.tr,
                        style: customLabelStyle,
                      ),
                      heightBox5,
                      RoundTextField(
                        controller: validationController.emailController,
                        hint: 'enter_your_email'.tr,
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                // password
                Visibility(
                  visible: controller.selectedRole.value == "User" ||
                      controller.selectedRole.value == "Vendor",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heightBox10,
                      Text(
                        'password'.tr,
                        style: customLabelStyle,
                      ),
                      heightBox5,
                      RoundTextField(
                        controller: validationController.passwordController,
                        hint: 'password_hint'.tr,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.grey,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isPasswordVisible.value
                                ? Icons.remove_red_eye
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            controller.togglePasswordVisibility();
                          },
                        ),
                        obscureText: !controller.isPasswordVisible.value,
                      ),
                    ],
                  ),
                ),

                // confirm password
                Visibility(
                  visible: controller.selectedRole.value == "User" ||
                      controller.selectedRole.value == "Vendor",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heightBox10,
                      Text(
                        'confirm_password'.tr,
                        style: customLabelStyle,
                      ),
                      heightBox5,
                      RoundTextField(
                        controller: validationController.confirmPasswordController,
                        hint: 'password_hint'.tr,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.grey,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isConfirmPasswordVisible.value
                                ? Icons.remove_red_eye
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            controller.toggleConfirmPasswordVisibility();
                          },
                        ),
                        obscureText: !controller.isConfirmPasswordVisible.value,
                      ),
                    ],
                  ),
                ),

                // terms and conditions
                heightBox20,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomCheckBox(
                      activeColor: AppColors.secondaryColor,
                      isChecked: controller.isChecked.value,
                      onChanged: (bool) {
                        controller.isChecked.value = !controller.isChecked.value;
                      },
                    ),
                    widthBox10,
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'by_creating_an_account_i_accept_the'.tr,
                              style: GoogleFonts.poppins(
                                  color: AppColors.blackColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                            TextSpan(
                              text: 'terms_conditions'.tr,
                              style: GoogleFonts.poppins(
                                  color: AppColors.secondaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                            TextSpan(
                              text: ' & ',
                              style: GoogleFonts.poppins(
                                  color: AppColors.blackColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                            TextSpan(
                              text: 'privacy_policy'.tr,
                              style: GoogleFonts.poppins(
                                  color: AppColors.secondaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),

                // select role
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomRadioButton(
                      options: ['User', 'Vendor'],
                      selectedValue: controller.selectedRole.value,
                      onChanged: (value) {
                        if (value != null) {
                          controller.changeRole(value);
                        }
                      },
                    ),
                    widthBox10,
                  ],
                ),

                // sign up
                heightBox10,
                controller.isChecked.value
                    ? CustomButton(
                  title: 'sign_up'.tr,
                  isLoading: controller.isLoading.value,
                  onTap: () async {
                    String? validationError =
                    validationController.validateCreateUserAccount();
                    String? validationVendorError =
                    validationController.validateCreateVendorAccount();

                    if (controller.selectedRole.value == 'User') {
                      if (validationError != null) {
                        Get.snackbar(
                            "error".tr,
                            validationError,
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.red,
                            colorText: Colors.white);
                      } else {
                        try {
                          controller.createUserAccount(
                            fullName: validationController.nameController.text,
                            phoneNumber:
                            validationController.phoneController.text,
                            address: validationController.addressController.text,
                            email: validationController.emailController.text,
                            password: validationController.passwordController.text,
                            latitude: latitude ?? 0.0,
                            longitude: longitude ?? 0.0,
                          );
                        } catch (e) {
                          print('Error: $e');
                        }
                      }
                    } else {
                      if (validationVendorError != null) {
                        Get.snackbar(
                            "error".tr,
                            validationVendorError,
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.red,
                            colorText: Colors.white);
                      } else {
                        controller.createVendorAccount(
                          fullName: validationController.nameController.text,
                          phoneNumber: validationController.phoneController.text,
                          email: validationController.emailController.text,
                          password: validationController.passwordController.text,
                          bankName: validationController.bankNameController.text,
                          holderName: validationController.holderNameController.text,
                          ibanNumber: validationController.ibanNumberController.text,
                        );
                      }
                    }
                  },
                )
                    : CustomButton(
                  title: 'sign_up'.tr,
                  onTap: () {},
                  buttonColor: Colors.transparent,
                  border: Border.all(color: AppColors.primaryColor),
                  titleColor: AppColors.primaryColor,
                ),

                //already have an account
                heightBox10,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'already_have_an_account'.tr,
                            style: GoogleFonts.poppins(
                                color: AppColors.blackColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text: 'log_in'.tr,
                            style: GoogleFonts.poppins(
                                color: AppColors.secondaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(() => SignInScreen());
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                heightBox20,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
