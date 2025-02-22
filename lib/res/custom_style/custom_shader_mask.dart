// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class CustomTextGradient extends StatelessWidget {
  final Widget customText;
  final List<Color>? colors;
  CustomTextGradient({required this.customText, this.colors});
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          colors: colors ?? [
            Color(0xFF8E6463),
            Color(0xFFBC9776),
            Color(0xFF946D66),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds);
      },
      child:  customText,
    );
  }
}

