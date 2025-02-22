import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgWidget extends StatelessWidget {
  final String path;
  final double height;
  final double width;
  final BoxFit? fit;
  final AlignmentGeometry? alignment;
  SvgWidget({super.key,
    required this.path,
    required this.height,
    required this.width,
    this.fit,
    this.alignment
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      height: height,
      width: width,
      fit: fit ?? BoxFit.contain,
      alignment: alignment ?? Alignment.center,
    );
  }
}
