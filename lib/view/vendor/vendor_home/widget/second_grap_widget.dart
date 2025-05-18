import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';

class SecondGrapWidget extends StatelessWidget {
  final List<_MonthlyData> graphData = [
    _MonthlyData('Jan', 50.0, Colors.green),
    _MonthlyData('Feb', 20.0, Colors.green),
    _MonthlyData('Mar', 45.0, Colors.green),
    _MonthlyData('Apr', 80.0, Colors.green),
    _MonthlyData('May', 65.0, Colors.green),
    _MonthlyData('Jun', 100.0, Colors.green),
    _MonthlyData('Jul', 50.0, Colors.green),
    _MonthlyData('Aug', 50.0, Colors.green),
    _MonthlyData('Sep', 50.0, Colors.green),
    _MonthlyData('Oct', 50.0, Colors.green),
    _MonthlyData('Nov', 50.0, Colors.green),
    _MonthlyData('Dec', 100.0, Colors.orange),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: Get.height / 4.2,
                child: SfCartesianChart(
                  plotAreaBorderWidth: 0,
                  primaryXAxis: CategoryAxis(
                    axisLine: const AxisLine(width: 0),
                    majorTickLines: const MajorTickLines(size: 0),
                    // Hide default labels
                    labelStyle: const TextStyle(color: Colors.transparent, fontSize: 0),
                  ),
                  primaryYAxis: NumericAxis(
                    isVisible: false,
                    minimum: 0,
                    maximum: 110,
                  ),
                  series: <ColumnSeries<_MonthlyData, String>>[
                    ColumnSeries<_MonthlyData, String>(
                      dataSource: graphData,
                      xValueMapper: (_MonthlyData data, _) => data.month,
                      yValueMapper: (_MonthlyData data, _) => data.value,
                      pointColorMapper: (_MonthlyData data, _) => data.color,
                      width: 0.5,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ],
                ),
              ),
              // Show month labels
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: graphData.map((data) {
                  final bool isDec = data.month == 'Dec';
                  return Text(
                    data.month,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDec ? Colors.orange : Colors.grey[700],
                      fontWeight: isDec ? FontWeight.bold : FontWeight.normal,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MonthlyData {
  final String month;
  final double value;
  final Color color;

  _MonthlyData(this.month, this.value, this.color);
}
