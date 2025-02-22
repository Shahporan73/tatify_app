import 'package:flutter/material.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';

class FirstGrapWidget extends StatelessWidget {
  final List<Map<String, dynamic>> graphData = [
    {"menu": "Menu 1", "value": 17.40, "profit": 700, "height": 120.0},
    {"menu": "Menu 2", "value": 17.40, "profit": 700, "height": 90.0},
    {"menu": "Menu 3", "value": 17.40, "profit": 700, "height": 100.0},
    {"menu": "Menu 4", "value": 17.40, "profit": 700, "height": 80.0},
    {"menu": "Menu 5", "value": 17.40, "profit": 700, "height": 95.0},
    {"menu": "Menu 6", "value": 17.40, "profit": 700, "height": 110.0},
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
                  // Value text
                  Text(
                    "\$${data['value']}",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  // Profit text
                  Text(
                    "(\$${data['profit']})",
                    style: TextStyle(fontSize: 14, color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  // Graph Bar
                  Container(
                    width: 35,
                    height: data['height'],
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [Colors.blue.withOpacity(0.5), Colors.blueAccent.withOpacity(0.8)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  // Menu Label
                  Text(
                    data['menu'],
                    style: TextStyle(fontSize: 12, color: Colors.grey),
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
