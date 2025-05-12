// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class BuildTimeButtonWidget extends StatelessWidget {
  final String day;
  final bool isOpeningTime;
  final TimeOfDay time;
  final VoidCallback onTap;

  const BuildTimeButtonWidget({
    Key? key,
    required this.day,
    required this.isOpeningTime,
    required this.time,
    required this.onTap,
  }) : super(key: key);

  String _formatTime(TimeOfDay time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          _formatTime(time),
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
