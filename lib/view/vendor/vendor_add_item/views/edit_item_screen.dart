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

class EditItemScreen extends StatelessWidget {
  EditItemScreen({super.key});

  final TextEditingController manuNameC = TextEditingController();
  final TextEditingController menuDesC = TextEditingController();
  final TextEditingController standardPriceC = TextEditingController();
  final TextEditingController discountPriceC = TextEditingController();


  final ItemController controller = Get.put(ItemController());

  final List<String> days = [
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
    "Monday",
  ];



  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    manuNameC.text = 'PROMMES';
    menuDesC.text = 'You order 2 Turkish Moccas, the cheaper/equally priced one will not be charged.';
    standardPriceC.text = '12.50€';
    discountPriceC.text = '8.49€';

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: MainAppBar(title: 'Edit a menu for your customers', backgroundColor: AppColors.bgColor,),
      body: SingleChildScrollView(
        padding: bodyPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Menu Name or Items Name',
              style: customLabelStyle,
            ),
            heightBox10,
            RoundTextField(
              controller: manuNameC,
              hint: 'Enter menu name',
            ),

            heightBox20,
            RoundTextField(
              controller: menuDesC,
              maxLine: 5,
              height: height / 8,
              vertical_padding: 5,
              hint: 'Enter menu  description',
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
                        title: 'Pricing',
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
                        title: 'Standard price',
                        fontWeight: FontWeight.w400,
                        color: AppColors.whiteDarker,
                      ),
                      Divider(color: Colors.grey, height: 5,),
                      heightBox10,
                      RoundTextField(
                        controller: standardPriceC,
                        hint: '',
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
                        title: 'Discount price',
                        fontWeight: FontWeight.w400,
                        color: AppColors.whiteDarker,
                      ),
                      Divider(color: Colors.grey, height: 5,),
                      heightBox10,
                      RoundTextField(
                        controller: discountPriceC,
                        hint: '',
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
                title: 'Offer Days',
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
                  bool isSelected = controller.selectedDay.value == day;
                  return GestureDetector(
                    onTap: () => controller.selectDay(day),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.green.withOpacity(0.2) : Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        day,
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
            CustomButton(
                title: 'Update',
                onTap: (){Navigator.of(context).pop();}
            ),


          ],
        ),
      ),
    );
  }
}
