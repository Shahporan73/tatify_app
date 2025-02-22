// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../app_colors/App_Colors.dart';

class CustomDropDownWidget extends StatelessWidget {
  final String selectedValue;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String hintText;
  final Decoration? decoration;
  final double? paddingHorizontal;
  final bool? isExpanded;
  final TextStyle? textStyle;
  final Color? dropDownColor;
  final TextStyle? hintStyle;
  final Function()? onTap;
  final Widget? iconWidget;
  final double? width;
  final double? height;
  CustomDropDownWidget({
    required this.selectedValue,
    required this.items,
    required this.onChanged,
    required this.hintText,
    this.decoration,
    this.paddingHorizontal,
    this.isExpanded,
    this.textStyle,
    this.dropDownColor,
    this.hintStyle,
    this.onTap,
    this.iconWidget,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    // Ensure the items list contains unique values
    final uniqueItems = items.toSet().toList();

    return Container(
      height: height ?? MediaQuery.of(context).size.height * 0.06,
      width: width ?? double.infinity,
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal ?? 10),
      decoration: decoration ?? BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Colors.black, width: 1.0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: uniqueItems.contains(selectedValue) ? selectedValue : null, // Ensure the selected value is valid
        hint: Text(
          hintText,
          style: hintStyle ?? TextStyle(
              fontSize: 14,
              color: Colors.grey
          ),
        ),
        underline: SizedBox(),
        onChanged: onChanged,
        items: uniqueItems
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        isExpanded: isExpanded ?? true,
        style: textStyle ?? TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
        icon: iconWidget ?? Icon(
          Icons.arrow_drop_down,
          color: Colors.black,
        ),
        dropdownColor: dropDownColor ?? AppColors.whiteColor,
        onTap: onTap,
      ),
    );
  }
}
