// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/app_images/App_images.dart';
import 'package:tatify_app/res/common_widget/RoundTextField.dart';
import 'package:tatify_app/res/common_widget/custom_button.dart';
import 'package:tatify_app/res/common_widget/custom_radio_button.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/common_widget/main_app_bar.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/res/custom_style/custom_style.dart';
import 'package:tatify_app/view/vendor/vendor_add_item/controller/item_controller.dart';

class EditItemScreen extends StatelessWidget {
  final String menuId;
  final String menuName;
  final String menuDescription;
  final String standardPrice;
  final String discountPrice;
  final String offerDay;
  EditItemScreen(
      {super.key,
      required this.menuId,
      required this.menuName,
      required this.menuDescription,
      required this.standardPrice,
      required this.discountPrice,
      required this.offerDay});

  final TextEditingController manuNameC = TextEditingController();
  final TextEditingController menuDesC = TextEditingController();
  final TextEditingController standardPriceC = TextEditingController();
  final TextEditingController discountPriceC = TextEditingController();

  final ItemController controller = Get.put(ItemController());

  final List<String> days = [
    "tuesday",
    "wednesday",
    "thursday",
    "friday",
    "saturday",
    "sunday",
    "monday",
    "7days",
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    manuNameC.text = menuName;
    menuDesC.text = menuDescription;
    standardPriceC.text = standardPrice;
    discountPriceC.text = discountPrice;

    // Init offerDay
    controller.selectedDay.value = offerDay;
    if (offerDay.isNotEmpty) {
      controller.selectDay(offerDay);
    }
    print('menu id $menuId');
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: MainAppBar(
        title: 'edit_a_menu_for_your_customers'.tr,
        backgroundColor: AppColors.bgColor,
      ),
      body: SingleChildScrollView(
        padding: bodyPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'menu_name'.tr,
              style: customLabelStyle,
            ),
            heightBox5,
            RoundTextField(
              controller: manuNameC,
              hint: 'enter_menu_name'.tr,
            ),
            heightBox10,
            Text(
              'menu_description'.tr,
              style: customLabelStyle,
            ),
            RoundTextField(
              controller: menuDesC,
              maxLine: 5,
              height: height / 8,
              vertical_padding: 5,
              hint: 'enter_menu_description'.tr,
            ),
            heightBox10,
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
            Divider(
              color: Colors.grey,
              height: 10,
            ),
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
                      Divider(
                        color: Colors.grey,
                        height: 5,
                      ),
                      heightBox10,
                      RoundTextField(
                        controller: standardPriceC,
                        hint: '',
                        keyboardType: TextInputType.number,
                        borderRadius: 25,
                        filled: true,
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
                      Divider(
                        color: Colors.grey,
                        height: 5,
                      ),
                      heightBox10,
                      RoundTextField(
                        controller: discountPriceC,
                        hint: '',
                        keyboardType: TextInputType.number,
                        borderRadius: 25,
                        filled: true,
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
            Divider(
              color: Colors.grey,
              height: 10,
            ),
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.green.withOpacity(0.2)
                            : Colors.grey[200],
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
            heightBox10,


            Obx(
              ()=> Row(
                children: [
                  CustomText(
                    title: 'Item Status',
                    fontWeight: FontWeight.w500,
                  ),
                  CustomRadioButton(
                    options: ['on-going', 'closed'],
                    selectedValue: controller.itemStatus.value,
                    onChanged: (value) {
                      controller.updateItemStatus(value);
                      print(controller.itemStatus.value);
                    },
                  )
                ],
              ),
            ),


            heightBox20,
            Obx(
              () => CustomButton(
                title: 'update',
                isLoading: controller.isLoading.value,
                onTap: () {
                  controller.updateItem(
                    context: context,
                    menuId: menuId,
                    menuName: manuNameC.text,
                    menuDescription: menuDesC.text,
                    standardPrice: standardPriceC.text,
                    discountPrice: discountPriceC.text,
                  );
                },
              ),
            ),
            heightBox20,
          ],
        ),
      ),
    );
  }
}
