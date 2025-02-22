// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class CustomRowWidget extends StatelessWidget {
  final Widget title;
  final Widget value;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;
  CustomRowWidget({
    super.key,
    required this.title,
    required this.value,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment?? MainAxisAlignment.spaceBetween,
      crossAxisAlignment: crossAxisAlignment??CrossAxisAlignment.start,
      children: [
        title,
        value
      ],
    );
  }
}
