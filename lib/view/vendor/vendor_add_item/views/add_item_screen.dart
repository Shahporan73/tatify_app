// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/app_images/App_images.dart';
import 'package:tatify_app/res/common_widget/RoundTextField.dart';
import 'package:tatify_app/res/common_widget/custom_button.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/common_widget/main_app_bar.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/res/custom_style/custom_style.dart';
import 'package:tatify_app/view/vendor/vendor_add_item/controller/item_controller.dart';

class AddItemScreen extends StatelessWidget {
  AddItemScreen({super.key});

  final ItemController controller = Get.put(ItemController());

  final List<String> days = [
    "tuesday",
    "wednesday",
    "thursday",
    "friday",
    "saturday",
    "sunday",
    "monday",
    "7days"
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: MainAppBar(title: 'add_a_menu_for_your_customers'.tr, backgroundColor: AppColors.bgColor,),
      body: SingleChildScrollView(
        padding: bodyPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RoundTextField(
                hint: 'enter_menu_name'.tr,
              controller: controller.menuNameController,
            ),

            heightBox20,
            RoundTextField(
              maxLine: 5,
              height: height / 8,
              vertical_padding: 5,
              hint: 'enter_menu_description'.tr,
              controller: controller.descriptionController,
            ),

            heightBox20,
            Row(
              children: [
                Image.asset(
                  AppImages.parchentageIcon,
                  color: Colors.black,
                  scale: 4,
                ),
                Expanded(
                  child: Center(
                      child: CustomText(
                    title: 'pricing'.tr,
                        fontWeight: FontWeight.w400,
                        color: AppColors.whiteDarker,
                  )),
                ),
              ],
            ),
            Divider(color: Colors.grey, height: 10,),

            heightBox20,
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      CustomText(
                        title: 'standard_price'.tr,
                        fontWeight: FontWeight.w400,
                        color: AppColors.whiteDarker,
                      ),
                      Divider(color: Colors.grey, height: 5,),
                      heightBox10,
                      RoundTextField(
                        hint: '0.0',
                        controller: controller.standardPriceController,
                        borderRadius: 25,
                        filled: true,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        fillColor: Color(0xffD9D9D9),
                        focusBorderRadius: 25,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width / 5,
                ),

                Expanded(
                  child: Column(
                    children: [
                      CustomText(
                        title: 'discount_price'.tr,
                        fontWeight: FontWeight.w400,
                        color: AppColors.whiteDarker,
                      ),
                      Divider(color: Colors.grey, height: 5,),
                      heightBox10,
                      RoundTextField(
                        hint: '0.0',
                        controller: controller.discountController,
                        borderRadius: 25,
                        textAlign: TextAlign.center,
                        filled: true,
                        keyboardType: TextInputType.number,
                        fillColor: Color(0xffD9D9D9),
                        focusBorderRadius: 25,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            heightBox20,
            Center(
                child: CustomText(
                  title: 'offer_days'.tr,
                  fontWeight: FontWeight.w500,
                  color: AppColors.whiteDarker,
                ),
            ),
            Divider(color: Colors.grey, height: 10,),
            heightBox10,
            Obx(
                  () => Wrap(
                spacing: 10,
                runSpacing: 10,
                children: days.map((day) {
                  bool isSelected = controller.selectedDays.contains(day);
                  return GestureDetector(
                    onTap: () => controller.selectDay(day),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.green.withOpacity(0.2) : Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: CustomText(
                        title: day,
                        style: TextStyle(
                          color: isSelected ? Colors.green : Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),


            heightBox20,
            Obx(
              ()=> CustomButton(
                  title: 'submit'.tr,
                  isLoading: controller.isLoading.value,
                  onTap: (){

                    if(controller.menuNameController.text.isEmpty ||
                    controller.descriptionController.text.isEmpty ||
                    controller.standardPriceController.text.isEmpty ||
                    controller.discountController.text.isEmpty ||
                    controller.selectedDays.isEmpty){
                      Get.rawSnackbar(
                        message: 'please_fill_all_the_fields'.tr,
                        backgroundColor: Colors.red,
                        snackPosition: SnackPosition.TOP,
                      );
                      return;
                    }

                   controller.addItem(context: context);
                  }
              ),
            ),


            heightBox50,
          ],
        ),
      ),
    );
  }
}
