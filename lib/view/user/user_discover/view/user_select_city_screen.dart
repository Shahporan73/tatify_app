// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/app_images/App_images.dart';
import 'package:tatify_app/res/common_widget/custom_button.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/view/user/user_discover/view/user_filter_bottom_sheet.dart';
import 'package:tatify_app/view/user/user_discover/widget/city_list_widget.dart';

class UserSelectCityScreen extends StatelessWidget {
  const UserSelectCityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: Get.height / 6,
          ),
          Center(
            child: Image.asset(
              AppImages.cityIcon,
              width: Get.width / 2,
              height: Get.height / 5,
            ),
          ),
          CustomText(
            title: 'first_select_city'.tr,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          heightBox10,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: CustomText(
              textAlign: TextAlign.center,
              title: 'choose_city_from_list'.tr,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          heightBox20,
          CustomButton(
            title: 'open_city_list'.tr,
            borderRadius: 25,
            width: Get.width / 2,
            onTap: () {
              Get.bottomSheet(
                Container(
                  height: Get.height * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: CityListWidget(),
                ),
                isScrollControlled: true, // Allows full height modal
              );
            },
          ),
          Spacer(),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100, // Light background
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  spreadRadius: 2,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildButton(
                  icon: Icons.filter_list,
                  text: "filter".tr,
                  onTap: () {
                    Navigator.pop(context);
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (context) {
                        return UserFilterBottomSheet();
                      },
                    );
                  },
                ),
                Container(
                  width: 1,
                  height: 30,
                  color: Colors.grey.shade300,
                ),
                _buildButton(
                  icon: Icons.map,
                  text: "map".tr,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          heightBox50,
        ],
      ),
    );
  }

  Widget _buildButton(
      {required IconData icon,
        required String text,
        required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: Colors.black54, size: 20),
            const SizedBox(width: 6),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
