import 'package:flutter/material.dart';

import '../../../../res/app_colors/App_Colors.dart';
import '../../../../res/common_widget/custom_text.dart';
import '../../../../res/custom_style/custom_size.dart';
import '../../../authenticate/widget/build_time_button_widget.dart';

class OpeningTimeTile extends StatelessWidget {
  final String day;
  final bool isClosed;
  final TimeOfDay openingTime;
  final TimeOfDay closingTime;
  final Function(bool) onClosedToggle; // Toggle closed day
  final VoidCallback onPickOpeningTime; // Pick opening time
  final VoidCallback onPickClosingTime; // Pick closing time

  const OpeningTimeTile({
    Key? key,
    required this.day,
    required this.isClosed,
    required this.openingTime,
    required this.closingTime,
    required this.onClosedToggle,
    required this.onPickOpeningTime,
    required this.onPickClosingTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Day and Switch to toggle closed status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                title: day,
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              Switch(
                value: isClosed,
                onChanged: onClosedToggle,
                activeColor: AppColors.primaryColor,
              ),
            ],
          ),
          // If not closed, show opening and closing times
          if (!isClosed)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Opening time
                Row(
                  children: [
                    CustomText(
                      title: 'Opening',
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                    widthBox5,
                    BuildTimeButtonWidget(
                      day: day,
                      isOpeningTime: true,
                      time: openingTime,
                      onTap: onPickOpeningTime,
                    )
                  ],
                ),
                // Closing time
                Row(
                  children: [
                    CustomText(
                      title: 'Closing',
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                    widthBox5,
                    BuildTimeButtonWidget(
                      day: day,
                      isOpeningTime: false,
                      time: closingTime,
                      onTap: onPickClosingTime,
                    )
                  ],
                ),
              ],
            ),
          // If closed, show a "Closed" message
          if (isClosed)
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: CustomText(
                title: "Closed",
                color: Colors.red,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}
