// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
import 'package:tatify_app/view/authenticate/view/email_verification_screen.dart';
import 'package:tatify_app/view/authenticate/view/sign_in_screen.dart';

import '../../../res/app_images/App_images.dart';
import '../../../res/common_widget/custom_checkbox.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final SignUpController controller = Get.put(SignUpController());

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
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Center(
                  child: Image.asset(
                    AppImages.splashLogo,
                    scale: 6,
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
                          titleText: 'Phone Number',
                          hintText: 'Enter phone number'
                      ),
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
                      ])),
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
                  onTap: () {
                    if(controller.selectedRole.value == 'User'){
                      Get.to(
                            () => EmailVerificationScreen(isVendor: false,),
                      );
                    }else{
                      Get.to(
                            () => EmailVerificationScreen(isVendor: true,),
                      );
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
                          title: 'Sign Up with',
                          color: AppColors.blackColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
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
