// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/data/local_database/local_data_base.dart';
import 'package:tatify_app/data/utils/const_value.dart';
import 'package:tatify_app/res/app_const/app_const.dart';
import 'package:tatify_app/res/common_widget/custom_alert_dialog.dart';
import 'package:tatify_app/res/common_widget/custom_app_bar.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/view/authenticate/view/sign_in_screen.dart';
import 'package:tatify_app/view/user/user_profile/controller/my_profile_controller.dart';
import 'package:tatify_app/view/user/user_profile/view/user_personal_information_screen.dart';
import 'package:tatify_app/view/user/user_profile/widget/profile_item_widget.dart';
import 'package:tatify_app/view/user/user_rule_view/user_privacy_policy_screen.dart';
import 'package:tatify_app/view/user/user_rule_view/user_support_screen.dart';
import 'package:tatify_app/view/user/user_rule_view/user_terms_and_condition_screen.dart';
import 'package:tatify_app/view/user/user_settings/view/user_setting_screen.dart';
import '../../../../res/app_colors/App_Colors.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({super.key});

  final MyProfileController myProfileController = Get.put(MyProfileController());
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Stack(
        children: [


          // Header image
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: height / 2,
              padding: EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 16),
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25)
                )
              ),
              child: Obx(
                ()=> Column(
                  children: [
                    CustomAppBar(appBarName: 'Profile', titleColor: Colors.white, widget: SizedBox(),),
                    heightBox20,
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: AppColors.primaryColor,
                      backgroundImage: NetworkImage(
                        myProfileController.profileImage.value.isNotEmpty ? myProfileController.profileImage.value :
                        placeholderImage,
                      ),
                    ),
                    heightBox10,
                    CustomText(
                      title: myProfileController.fullName.value.isNotEmpty ?
                      myProfileController.fullName.value : 'User Name',
                      fontWeight: FontWeight.w600,
                      color: Colors.white,fontSize: 18,
                    )
                  ],
                ),
              ),
            ),
          ),

          // details
          Positioned(
            top: height / 2.8,
            left: 16,
            right: 22,
            bottom: 22,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 1)
                  )
                ]
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ProfileItemWidget(
                        icon: Icons.person,
                        title: 'Personal Information',
                        onTap: (){
                          Get.to(() => UserPersonalInformationScreen());
                        }
                    ),
                    ProfileItemWidget(
                        icon: Icons.settings,
                        title: 'Settings',
                        onTap: (){
                          Get.to(() => UserSettingScreen());
                        }
                    ),

                    ProfileItemWidget(
                        icon: Icons.description,
                        title: 'Terms of Services',
                        onTap: (){
                          Get.to(() => UserTermsAndConditionScreen());
                        }
                    ),
                    ProfileItemWidget(
                        icon: Icons.privacy_tip,
                        title: 'Privacy Policy',
                        onTap: (){
                          Get.to(() => UserPrivacyPolicyScreen());
                        }
                    ),
                    ProfileItemWidget(
                        icon: Icons.info_outline,
                        title: 'About Us',
                        onTap: (){
                          Get.to(() => UserSupportScreen());
                        }
                    ),
                    ProfileItemWidget(
                        icon: Icons.logout,
                        title: 'Logout',
                        iconColor: Colors.red,
                        titleColor: Colors.red,
                        onTap: (){
                          CustomAlertDialog().customAlert(
                              context: context,
                              title: 'Delete',
                              message: 'Are your sure you want to logout?',
                              NegativebuttonText: "Cancel",
                              PositivvebuttonText: "Logout",
                              onPositiveButtonPressed: () {
                                LocalStorage.removeData(key: accessToken);
                                Get.offAll(() => SignInScreen());
                              },
                              onNegativeButtonPressed: () {
                                Navigator.of(context).pop();
                              },
                          );
                        },
                      isDivider: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
