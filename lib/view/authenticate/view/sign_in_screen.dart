// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatify_app/data/local_database/local_data_base.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/common_widget/RoundTextField.dart';
import 'package:tatify_app/res/common_widget/custom_button.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/res/custom_style/custom_style.dart';
import 'package:tatify_app/view/authenticate/controller/sign_in_controller.dart';
import 'package:tatify_app/view/authenticate/view/sign_up_screen.dart';
import 'package:tatify_app/view/user/user_home/view/home_dashboard.dart';

import '../../../data/utils/const_value.dart';
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
    print('restaurant id ${LocalStorage.getData(key: restaurantId)}');
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
            )),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: bodyPadding,
            child: Obx(
                  () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CustomText(
                      title: 'log_in'.tr,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      AppImages.splashLogo,
                      width: width / 1.8,
                      height: height / 12,
                    ),
                  ),

                  heightBox10,
                  Text(
                    'email'.tr,
                    style: customLabelStyle,
                  ),
                  heightBox5,
                  RoundTextField(
                    controller: controller.emailC,
                    hint: 'enter_your_email'.tr,
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.grey,
                    ),
                  ),

                  heightBox10,
                  Text(
                    'password'.tr,
                    style: customLabelStyle,
                  ),
                  heightBox5,
                  RoundTextField(
                    controller: controller.passC,
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

                  heightBox10,
                  Row(
                    children: [
                      SizedBox(
                        width: Get.width / 16,
                        child: Checkbox(
                          activeColor: AppColors.primaryColor,
                          value: controller.isSelected.value,
                          onChanged: (bool? value) {
                            controller.isSelected.value =
                            !controller.isSelected.value;
                            controller.isRemembered();
                          },
                        ),
                      ),
                      widthBox8,
                      Text(
                        'remember_me'.tr,
                        style: TextStyle(color: Colors.black),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            isDismissible: false,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20)),
                            ),
                            builder: (_) => ForgotPasswordSheet(),
                          );
                        },
                        child: Text(
                          'forgot_password'.tr,
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // sign up button
                  heightBox10,
                  Obx(
                        () => CustomButton(
                      title: 'log_in'.tr,
                      isLoading: controller.isLoading.value,
                      onTap: () {
                        String? validationError = controller.validateLogin();

                        if (validationError != null) {
                          Get.snackbar(
                            'error'.tr,
                            validationError,
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        } else {
                          controller.loginMethod();
                          controller.checkUser();
                        }
                      },
                    ),
                  ),

                  //already have an account text with sign up link
                  heightBox10,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'dont_have_account'.tr,
                            style: GoogleFonts.poppins(
                              color: AppColors.blackColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: 'sign_up'.tr,
                            style: GoogleFonts.poppins(
                              color: AppColors.secondaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(() => SignUpScreen());
                              },
                          ),
                        ]),
                      ),
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
