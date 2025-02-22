import 'package:flutter/material.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';

class SecondGrapWidget extends StatelessWidget {
  final List<Map<String, dynamic>> graphData = [
    {"month": "Jan", "value": 50.0, "color": Colors.green},
    {"month": "Feb", "value": 20.0, "color": Colors.green},
    {"month": "Mar", "value": 45.0, "color": Colors.green},
    {"month": "Apr", "value": 80.0, "color": Colors.green},
    {"month": "May", "value": 65.0, "color": Colors.green},
    {"month": "Jun", "value": 100.0, "color": Colors.green},
    {"month": "Jul", "value": 50.0, "color": Colors.green},
    {"month": "Aug", "value": 50.0, "color": Colors.green},
    {"month": "Sep", "value": 50.0, "color": Colors.green},
    {"month": "Oct", "value": 50.0, "color": Colors.green},
    {"month": "Nov", "value": 50.0, "color": Colors.green},
    {"month": "Dec", "value": 100.0, "color": Colors.orange}, // Highlighted month
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor, // Light background like the image
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: graphData.map((data) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Graph Bar
                  Container(
                    width: 20,
                    height: data['value'],
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: data['color'],
                    ),
                  ),
                  SizedBox(height: 5),
                  // Month Label
                  Text(
                    data['month'],
                    style: TextStyle(
                      fontSize: 12,
                      color: data['month'] == "Dec" ? Colors.orange : Colors.grey[700],
                      fontWeight: data['month'] == "Dec" ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
