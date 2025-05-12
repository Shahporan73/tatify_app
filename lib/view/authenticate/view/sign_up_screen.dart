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
import 'package:tatify_app/res/common_widget/custom_password_field.dart';
import 'package:tatify_app/res/common_widget/custom_radio_button.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/res/custom_style/custom_style.dart';
import 'package:tatify_app/view/authenticate/controller/sign_up_controller.dart';
import 'package:tatify_app/view/authenticate/controller/validation_controller.dart';
import 'package:tatify_app/view/authenticate/view/email_verification_screen.dart';
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
                    title: 'Sign Up',
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Center(
                  child: Image.asset(
                    AppImages.splashLogo,
                    width: Get.width / 3,
                    height: Get.height / 8,
                  ),
                ),

                // full name
                Visibility(
                  visible: controller.selectedRole.value =="User" || controller.selectedRole.value =="Vendor",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heightBox10,
                      Text(
                        'Full name',
                        style: customLabelStyle,
                      ),
                      heightBox5,
                      RoundTextField(
                        hint: 'Enter your full name',
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
                  visible: controller.selectedRole.value =="Vendor",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heightBox10,
                      Text(
                        'Bank name',
                        style: customLabelStyle,
                      ),
                      heightBox5,
                      RoundTextField(
                        hint: 'Enter bank name',
                        controller: validationController.bankNameController,
                      )
                    ],
                  ),
                ),

                // holder name
                Visibility(
                  visible: controller.selectedRole.value =="Vendor",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heightBox10,
                      Text(
                        'Holder Name',
                        style: customLabelStyle,
                      ),
                      heightBox5,
                      RoundTextField(
                        hint: 'Enter holder name',
                        controller: validationController.holderNameController,
                      )
                    ],
                  ),
                ),

                // IBAN
                Visibility(
                  visible: controller.selectedRole.value =="Vendor",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heightBox10,
                      Text(
                        'IBAN',
                        style: customLabelStyle,
                      ),
                      heightBox5,
                      RoundTextField(
                        controller: validationController.ibanNumberController,
                        hint: 'Enter your IBAN number',
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
                  visible: controller.selectedRole.value =="User" || controller.selectedRole.value =="Vendor",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heightBox10,
                      CountryCodePicker(
                          controller: validationController.phoneController,
                          titleText: 'Phone Number',
                          hintText: 'Enter phone number'
                      ),
                    ],
                  ),
                ),

                // address
                Visibility(
                  visible: controller.selectedRole.value =="User",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heightBox10,
                      Text(
                        'Address',
                        style: customLabelStyle,
                      ),
                      heightBox5,
                      RoundTextField(
                        controller: validationController.addressController,
                        hint: 'Enter your address',
                        readOnly: false,
                        prefixIcon: Icon(
                          Icons.location_on,
                          color: Colors.grey,
                        ),
                        /*onTap: () async {
                          try {
                            var location = await LocationServiceWithAddress.getCurrentLocationWithAddress();
                            print('Latitude: ${location['latitude']}');
                            print('Longitude: ${location['longitude']}');
                            print('Address: ${location['address']}');
                            validationController.addressController.text = location['address'];
                          } catch (e) {
                            print('Error: $e');
                          }
                        },*/
                      )
                    ],
                  ),
                ),


                // Email
                Visibility(
                  visible: controller.selectedRole.value =="User" || controller.selectedRole.value =="Vendor",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heightBox10,
                      Text(
                        'Email',
                        style: customLabelStyle,
                      ),
                      heightBox5,
                      RoundTextField(
                        controller: validationController.emailController,
                        hint: 'Enter your email',
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
                  visible: controller.selectedRole.value =="User" || controller.selectedRole.value =="Vendor",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heightBox10,
                      Text(
                        'Password',
                        style: customLabelStyle,
                      ),
                      heightBox5,
                      RoundTextField(
                        controller: validationController.passwordController,
                        hint: '************',
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.grey,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isPasswordVisible.value ? Icons.remove_red_eye : Icons.visibility_off,
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
                  visible: controller.selectedRole.value =="User" || controller.selectedRole.value =="Vendor",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heightBox10,
                      Text(
                        'Confirm Password',
                        style: customLabelStyle,
                      ),
                      heightBox5,
                      RoundTextField(
                        controller: validationController.confirmPasswordController,
                        hint: '************',
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.grey,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isConfirmPasswordVisible.value ? Icons.remove_red_eye : Icons.visibility_off,
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
                        controller.isChecked.value =
                        !controller.isChecked.value;
                      },
                    ),
                    widthBox10,
                    Expanded(
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'By creating an account, I accept the ',
                            style: GoogleFonts.poppins(
                                color: AppColors.blackColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                          TextSpan(
                            text: 'Terms & Conditions',
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
                            text: 'Privacy Policy',
                            style: GoogleFonts.poppins(
                                color: AppColors.secondaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                        ],),),
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
                controller.isChecked.value ?
                CustomButton(
                  title: 'Sign Up',
                  isLoading: controller.isLoading.value,
                  onTap: () async {
                    String? validationError = validationController.validateCreateUserAccount();
                    String? validationVendorError = validationController.validateCreateVendorAccount();

                    if(controller.selectedRole.value == 'User'){
                      if(validationError != null){
                        Get.snackbar("Error", validationError, snackPosition: SnackPosition.TOP, backgroundColor: Colors.red, colorText: Colors.white);
                      }else{
                        try {
                          // var location = await LocationServiceWithAddress.getCurrentLocationWithAddress();
                          // print('Latitude: ${location['latitude']}');
                          // print('Longitude: ${location['longitude']}');
                          // print('Address: ${location['address']}');

                          controller.createUserAccount(
                            fullName: validationController.nameController.text,
                            phoneNumber: validationController.phoneController.text,
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
                    }else{
                      if(validationVendorError != null){
                        Get.snackbar("Error", validationVendorError, snackPosition: SnackPosition.TOP, backgroundColor: Colors.red, colorText: Colors.white);
                      }else{
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
                      // Get.to(() => EmailVerificationScreen(isVendor: true, email: '',));
                    }
                  },
                ):
                CustomButton(
                    title: 'Sign Up',
                    onTap: () {},
                    buttonColor: Colors.transparent,
                    border: Border.all(color: AppColors.primaryColor),
                    titleColor: AppColors.primaryColor
                ),


                // sign in with google
                heightBox10,
                CustomButton(
                  title: 'Sign Up',
                  border: Border.all(color: Color(0xffEDEDED)),
                  buttonColor: Colors.white,
                  widget: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImages.googleLogo,
                        scale: 4,
                      ),
                      widthBox10,
                      CustomText(
                          title: 'Continue with google',
                          color: AppColors.blackColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                      ),
                    ],
                  ),
                  onTap: () {},
                ),

                //already have an account
                heightBox10,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'Already have an account? ',
                            style: GoogleFonts.poppins(
                                color: AppColors.blackColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text: 'Log In',
                            style: GoogleFonts.poppins(
                                color: AppColors.secondaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(
                                        ()=>SignInScreen()
                                );
                              },
                          ),
                        ])),
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

