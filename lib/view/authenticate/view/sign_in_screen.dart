// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/common_widget/RoundTextField.dart';
import 'package:tatify_app/res/common_widget/custom_button.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/res/custom_style/custom_style.dart';
import 'package:tatify_app/view/authenticate/controller/sign_in_controller.dart';
import 'package:tatify_app/view/authenticate/view/sign_up_screen.dart';
import 'package:tatify_app/view/user/user_home/view/home_dashboard.dart';

import '../../../res/app_images/App_images.dart';
import 'email_verification_screen.dart';
import 'forgot_sheet_screen/forgot_password_sheet.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final SignInController controller = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Container(
        width: width * double.infinity,
        height: height * double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xffFFFAFB),
                const Color(0xFFFFD7C599),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
          )
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: bodyPadding,
            child: Obx(
                  () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CustomText(
                      title: 'Log In',
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      AppImages.splashLogo,
                      scale: 6,
                    ),
                  ),

                  heightBox10,
                  Text(
                    'Email',
                    style: customLabelStyle,
                  ),
                  heightBox5,
                  RoundTextField(
                    controller: controller.emailC,
                    hint: 'Enter your email',
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.grey,
                    ),
                  ),

                  heightBox10,
                  Text(
                    'Password',
                    style: customLabelStyle,
                  ),
                  heightBox5,
                  RoundTextField(
                    controller: controller.passC,
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

                  heightBox10,
                  Row(
                    children: [
                      Checkbox(
                        activeColor: AppColors.primaryColor,
                        value: controller.isSelected.value,
                        onChanged: (bool? value) {
                          controller.isSelected.value = !controller.isSelected.value;
                        },
                      ),
                      Text(
                        'Remember me',
                        style: TextStyle(color: Colors.black),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                            builder: (_) => ForgotPasswordSheet(),
                          );
                        },
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // sign up
                  heightBox10,
                  CustomButton(
                    title: 'Log In',
                    onTap: () {
                      controller.checkUser();
                    },
                  ),

                  // sign in with google
                  heightBox10,
                  CustomButton(
                    title: 'Sign Up',
                    border: Border.all(color: Color(0xffEDEDED)),
                    buttonColor: Colors.transparent,
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
                            title: 'Sign in with',
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
                              text: 'Don\'t have an account? ',
                              style: GoogleFonts.poppins(
                                  color: AppColors.blackColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                            TextSpan(
                              text: 'Sign Up',
                              style: GoogleFonts.poppins(
                                  color: AppColors.secondaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.to(
                                          ()=> SignUpScreen()
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
      ),
    );
  }
}
