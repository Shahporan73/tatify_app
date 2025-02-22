import 'package:flutter/material.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/common_widget/main_app_bar.dart';
import 'package:tatify_app/res/custom_style/custom_style.dart';
import 'package:tatify_app/view/vendor/vendor_profile/widget/history_widget.dart';

class VendorHistoryScreen extends StatelessWidget {
  VendorHistoryScreen({super.key});
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.orange, // Header background color
            colorScheme: ColorScheme.light(
              primary: Colors.orange, // Selected date color
            ),
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: MainAppBar(title: 'History', backgroundColor: AppColors.bgColor,),
      body: Padding(
        padding: bodyPadding,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: (){
                _selectDate(context);
              },
              icon: Icon(Icons.calendar_month_outlined, color: AppColors.secondaryColor, size: 28,),
            ),
          ),
          Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: 5,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  return HistoryWidget();
                },
              )
          ),
        ],
      ),
      ),
    );
  }
}
