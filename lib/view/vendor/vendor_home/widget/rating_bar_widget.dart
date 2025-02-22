import 'package:flutter/material.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';

class RatingBarWidget extends StatelessWidget {
  final int starCount;
  final double fillPercent;
  const RatingBarWidget({super.key, required this.starCount, required this.fillPercent,});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$starCount ★',
          style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w700),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              FractionallySizedBox(
                widthFactor: fillPercent,
                child: Container(
                  height: 5,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
