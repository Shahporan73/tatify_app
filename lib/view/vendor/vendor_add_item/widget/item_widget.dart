// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/app_images/App_images.dart';
import 'package:tatify_app/res/common_widget/custom_alert_dialog.dart';
import 'package:tatify_app/res/common_widget/custom_button.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/view/vendor/vendor_add_item/views/edit_item_screen.dart';

class ItemWidget extends StatelessWidget {
  final bool? isEdit;
  const ItemWidget({super.key, this.isEdit = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: BoxDecoration(
          color: AppColors.bgColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(title: 'Pommes',
            fontWeight: FontWeight.w700, color: AppColors.blackColor, fontSize: 18,
          ),
          heightBox5,
          Row(
            children: [
              Expanded(
                flex: 13,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(16),

                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(AppImages.parchentageIcon, scale: 4,),
                      widthBox5,
                      Text.rich(TextSpan(
                          children: [
                            TextSpan(
                              text: '12.50€',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 11,
                                color: AppColors.whiteColor,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.white,
                                decorationThickness: 2,
                              ),
                            ),
                            TextSpan(
                              text: ' 8.49€',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 11, color: Color(0xff00FF00),
                              ),
                            ),
                          ]
                      ),),
                    ],
                  ),
                ),),
              widthBox10,
              Expanded(
                flex: 10,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(16),

                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(AppImages.refreshIcon, scale: 4,),
                      widthBox5,
                      CustomText(title: '6 days', fontWeight: FontWeight.w600, fontSize: 11, color: AppColors.whiteColor,)
                    ],
                  ),
                ),),
              widthBox10,
              Expanded(
                flex: 10,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(16),

                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on_outlined, color: Colors.white, size: 18,),
                      widthBox5,
                      CustomText(title: 'On-site', fontWeight: FontWeight.w600, fontSize: 11, color: AppColors.whiteColor,)
                    ],
                  ),
                ),)
            ],
          ),
          heightBox5,
          CustomText(title: 'You order 2 Turkish Moccas, the cheaper/equally priced one will not be charged.',
            fontWeight: FontWeight.w400, color: Color(0xff677294), fontSize: 12,
          ),
          heightBox8,
          CustomButton(
              title: 'Use as Template',
              borderRadius: 25,
              padding_vertical: 8,
              buttonColor: AppColors.secondaryColor,
              widget: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  CustomText(title: 'Use as Template',
                    fontSize: 14, color: Colors.white,),
                  Spacer(),
                  isEdit == true ? GestureDetector(
                    onTap: () => Get.to(()=>EditItemScreen()),
                    child: Image.asset(AppImages.editIcon, width: 20,),
                  ): SizedBox(),
                  widthBox5,
                  GestureDetector(
                    onTap: () {
                      CustomAlertDialog().customAlert(
                          context: context, title: "Alert", 
                          message: 'Are you sure you want to delete item?',
                          NegativebuttonText: "Cancel", 
                          PositivvebuttonText: "Confirm", 
                          onPositiveButtonPressed: () {
                            Navigator.of(context).pop();
                            Get.rawSnackbar(message: "Delete successful");
                          }, 
                          onNegativeButtonPressed: () => Navigator.of(context).pop(),
                      );
                    },
                    child: Image.asset(AppImages.deleteIcon, width: 20,),
                  )
                ],
              ),),
              onTap: (){}
          ),
        ],
      ),
    );
  }
}
