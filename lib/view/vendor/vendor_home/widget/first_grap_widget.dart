import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';

class FirstGrapWidget extends StatelessWidget {
  final List<_GraphData> graphData = [
    _GraphData('Menu 1', 17.40, 700),
    _GraphData('Menu 2', 16, 700),
    _GraphData('Menu 3', 17.40, 700),
    _GraphData('Menu 4', 15, 700),
    _GraphData('Menu 5', 12, 700),
    _GraphData('Menu 6', 17.40, 700),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(
              labelStyle: const TextStyle(color: Colors.grey, fontSize: 12),
              majorGridLines: const MajorGridLines(width: 0),
            ),
            primaryYAxis: NumericAxis(
              labelFormat: '\${value}',
              axisLine: const AxisLine(width: 0),
              majorTickLines: const MajorTickLines(size: 0),
            ),
            tooltipBehavior: TooltipBehavior(
              enable: true,
              format: 'point.x : \$point.y\nProfit: \$point.profit',
            ),
            series: <CartesianSeries<_GraphData, String>>[
              ColumnSeries<_GraphData, String>(
                dataSource: graphData,
                xValueMapper: (_GraphData data, _) => data.menu,
                yValueMapper: (_GraphData data, _) => data.value,
                pointColorMapper: (_, __) => Colors.blue,
                borderRadius: BorderRadius.circular(10),
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  labelAlignment: ChartDataLabelAlignment.top,
                  builder: (data, point, series, pointIndex, seriesIndex) {
                    final _GraphData currentData = data!;
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          '\$${currentData.value.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '(\$${currentData.profit.toStringAsFixed(0)})',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GraphData {
  final String menu;
  final double value;
  final double profit;

  _GraphData(this.menu, this.value, this.profit);
}
