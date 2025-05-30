// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';

class CustomRadioButton extends StatelessWidget {
  final List<String> options;
  final String selectedValue;
  final ValueChanged<String> onChanged;
  final Color selectedColor;

  CustomRadioButton({
    required this.options,
    required this.selectedValue,
    required this.onChanged,
    this.selectedColor = AppColors.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: options.map((option) {
          return Row(
            children: [
              Radio<String>(
                value: option,
                // fillColor: MaterialStateProperty.all(AppColors.primaryColor),
                groupValue: selectedValue,
                onChanged: (value) {
                  if (value != null) {
                    onChanged(value);
                  }
                },
                activeColor: selectedColor,
              ),
              Text(
                option,
                style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              if (option != options.last) SizedBox(width: 20),
            ],
          );
        }).toList(),
      ),
    );
  }
}
