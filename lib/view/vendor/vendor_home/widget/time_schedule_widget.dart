import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../res/app_colors/App_Colors.dart';
import '../../../../res/common_widget/custom_row_widget.dart';
import '../../../../res/common_widget/custom_text.dart';
import '../../../../res/custom_style/custom_size.dart';

class TimeScheduleWidget extends StatelessWidget {
  final String day;
  final String openTime;
  final String closeTime;
  final bool isClosed;
  const TimeScheduleWidget(
      {super.key,
      required this.day,
      required this.openTime,
      required this.closeTime,
      required this.isClosed});

  @override
  Widget build(BuildContext context) {
    return CustomRowWidget(
        title: Text(
          day,
          style: titleStyle,
        ),
        value: CustomText(
          title: isClosed ? 'Closed' : '$openTime - $closeTime',
          color: AppColors.primaryColor,
        )
    );
  }
}

TextStyle titleStyle = GoogleFonts.poppins(
    fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xff5C5C5C));
