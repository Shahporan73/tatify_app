import 'package:flutter/material.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/common_widget/RoundTextField.dart';
import 'package:tatify_app/res/common_widget/custom_button.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';

Future<void> openFilterDialog(
  BuildContext context,
  TextEditingController distanceController,
  TextEditingController limitController,
  void Function(int distance, int limit) onApply,
) async {
  await showDialog<Map<String, int>>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Filter Options"),
        backgroundColor: Colors.white,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RoundTextField(
              controller: distanceController,
              hint: 'Distance ex: 5',
              keyboardType: TextInputType.number,
            ),
            heightBox8,
            RoundTextField(
              controller: limitController,
              hint: 'Limit item ex: 10',
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  title: 'Cancel',
                  border: Border.all(color: AppColors.primaryColor),
                  buttonColor: Colors.white,
                  titleColor: Colors.black,
                  onTap: () => Navigator.pop(context),
                ),
              ),
              widthBox8,
              Expanded(
                child: CustomButton(
                  title: 'Apply',
                  onTap: () {
                    int distance = int.tryParse(distanceController.text) ?? 0;
                    int limit = int.tryParse(limitController.text) ?? 0;
                    onApply(distance, limit);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          )
        ],
      );
    },
  );
}
