import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../res/app_colors/App_Colors.dart';
import '../../../../res/common_widget/custom_row_widget.dart';
import '../../../../res/common_widget/custom_text.dart';
import '../../../../res/custom_style/custom_size.dart';

class TimeScheduleWidget extends StatelessWidget {
  const TimeScheduleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.watch_later_outlined, color: AppColors.secondaryColor,size: 19,),
            widthBox10,
            CustomText(title: 'Opening hours', fontSize: 14, fontWeight: FontWeight.w500,)
          ],
        ),
        heightBox10,
        CustomRowWidget(title: Text('Monday', style: titleStyle,), value: Text('09:00-19:00', style: titleStyle,)),
        CustomRowWidget(title: Text('Tuesday', style: titleStyle,), value: Text('09:00-19:00', style: titleStyle,)),
        CustomRowWidget(title: Text('Wednesday', style: titleStyle,), value: Text('09:00-19:00', style: titleStyle,)),
        CustomRowWidget(title: Text('Thursday', style: titleStyle,), value: Text('09:00-19:00', style: titleStyle,)),
        CustomRowWidget(title: Text('Friday', style: titleStyle,), value: Text('09:00-19:00', style: titleStyle,)),
        CustomRowWidget(title: Text('Saturday', style: titleStyle,), value: Text('09:00-19:00', style: titleStyle,)),
        CustomRowWidget(title: Text('Sunday', style: titleStyle,), value: CustomText(title: 'Closed',
          color: AppColors.primaryColor,)),
      ],
    );
  }
}

TextStyle titleStyle = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Color(0xff5C5C5C)
);