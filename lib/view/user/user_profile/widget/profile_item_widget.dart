
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../../res/app_colors/App_Colors.dart';
import '../../../../res/common_widget/custom_text.dart';
import '../../../../res/custom_style/custom_size.dart';

class ProfileItemWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color? color;
  final Color? titleColor;
  final Color? iconColor;
  final VoidCallback onTap;
  final bool isDivider;
  ProfileItemWidget({super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.color, this.titleColor,
    this.iconColor,
    this.isDivider=false
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8)
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Icon(icon, size: 20, color: iconColor?? Colors.black,),
                ),
                widthBox10,
                Expanded(child: CustomText(title: title, fontWeight: FontWeight.w400, fontSize: 15, color:titleColor?? Colors.black,)),
              ],
            ),
            isDivider == false? Divider(height: 1,):SizedBox(),
          ],
        ),
      ),
    );
  }
}