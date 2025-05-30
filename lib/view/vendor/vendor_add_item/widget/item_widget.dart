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
  final String title;
  final String price;
  final String discountPrice;
  final String offerDay;
  final String description;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  const ItemWidget(
      {super.key,
      this.isEdit = false,
      required this.title,
      required this.price,
      required this.discountPrice,
      required this.offerDay,
      required this.description, this.onEdit,
        this.onDelete
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5, top: 5),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: BoxDecoration(
          color: AppColors.bgColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 1,
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title: title,
            fontWeight: FontWeight.w700,
            color: AppColors.blackColor,
            fontSize: 18,
          ),
          heightBox5,
          Row(
            children: [
              Expanded(
                flex: 13,
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImages.parchentageIcon,
                        scale: 4,
                      ),
                      widthBox5,
                      Text.rich(
                        TextSpan(children: [
                          TextSpan(
                            text: '$price€',
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
                            text: ' $discountPrice€',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                              color: Color(0xff00FF00),
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
              widthBox10,
              Expanded(
                flex: 12,
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImages.refreshIcon,
                        scale: 4,
                      ),
                      widthBox5,
                      CustomText(
                        title: offerDay,
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                        color: AppColors.whiteColor,
                      )
                    ],
                  ),
                ),
              ),
              widthBox10,
              Expanded(
                flex: 10,
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.white,
                        size: 18,
                      ),
                      widthBox5,
                      CustomText(
                        title: 'on_site'.tr,
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                        color: AppColors.whiteColor,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          heightBox5,
          CustomText(
            title: description,
            fontWeight: FontWeight.w400,
            color: Color(0xff677294),
            fontSize: 12,
          ),
          heightBox8,
          CustomButton(
              title: 'use_as_template'.tr,
              borderRadius: 25,
              padding_vertical: 8,
              buttonColor: AppColors.secondaryColor,
              widget: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    CustomText(
                      title: 'use_as_template'.tr,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                    Spacer(),
                    isEdit == true
                        ? GestureDetector(
                            onTap: onEdit,
                            child: Image.asset(
                              AppImages.editIcon,
                              width: 20,
                            ),
                          )
                        : SizedBox(),
                    widthBox5,
                    InkWell(
                      onTap: onDelete,
                      child: Image.asset(
                        AppImages.deleteIcon,
                        width: 20,
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {}),
        ],
      ),
    );
  }
}
