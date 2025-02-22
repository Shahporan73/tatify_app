import 'package:flutter/material.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';

class CustomCheckBox extends StatelessWidget {
  final bool isChecked; // Passed from parent
  final double size; // Size of the checkbox
  final Color activeColor; // Color when checkbox is checked
  final Color inactiveColor; // Color when checkbox is unchecked
  final double borderWidth; // Border width
  final Function(bool) onChanged; // Callback for state changes

  const CustomCheckBox({
    Key? key,
    required this.isChecked,
    this.size = 20.0,
    this.activeColor = Colors.pink,
    this.inactiveColor = Colors.transparent,
    this.borderWidth = 1.5,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!isChecked); // Notify the parent about the state change
      },
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.secondaryColor,
            width: borderWidth,
          ),
          borderRadius: BorderRadius.circular(4),
          color: isChecked ? activeColor : inactiveColor,
        ),
        child: isChecked
            ? Icon(
          Icons.check,
          size: size * 0.6,
          color: Colors.white,
        )
            : null,
      ),
    );
  }
}
