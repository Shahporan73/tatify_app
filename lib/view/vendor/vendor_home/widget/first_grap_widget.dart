import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../res/common_widget/custom_text.dart';
import '../../../../res/custom_style/custom_size.dart';
import '../../../../res/app_colors/App_Colors.dart';
import '../controller/net_income_controller.dart';
import 'first_cart_shimmer.dart';

class NetIncomeChartWidget extends StatelessWidget {
  final NetIncomeController controller = Get.put(NetIncomeController());

  NetIncomeChartWidget({Key? key}) : super(key: key){
    controller.getNetIncome();
  }

  static const int fixedLineCount = 6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (controller.isLoading.value) {
          return FirstCartShimmer();
        }

        final netIncomeList = controller.netIncomeList;
        List<_GraphData> graphData = [];

        for (int i = 0; i < fixedLineCount; i++) {
          if (i < netIncomeList.length) {
            final item = netIncomeList[i];
            graphData.add(_GraphData(
              item.foodName ?? 'Empty',
              (item.totalPrice ?? 0).toDouble() - (item.itemNetIncome ?? 0).toDouble(),
              (item.itemNetIncome ?? 0).toDouble(),
            ));
          } else {
            // Fill remaining with empty data points
            graphData.add(_GraphData(
              '',
              0.0,
              0.0,
            ));
          }
        }

        return Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              // Net Income Summary on top
              Center(
                child: CustomText(
                  title: 'Net Income',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Center(
                child: CustomText(
                  title: '\$${controller.netIncomeModel.value.data?.totalNetIncome ?? 0}',
                  fontSize: 28,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),

              // Filter row
              InkWell(
                onTap: () => _showMonthYearPicker(context),
                child: Row(
                  children: [
                    Spacer(),
                    CustomText(
                      title: 'Filter',
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    Icon(Icons.filter_alt_outlined, color: AppColors.blackColor),
                    const SizedBox(width: 16),
                  ],
                ),
              ),
              const SizedBox(height: 5),

              // Chart
              Expanded(
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(
                    labelStyle: const TextStyle(color: Colors.grey, fontSize: 12),
                    majorGridLines: const MajorGridLines(width: 0),
                    axisLabelFormatter: (AxisLabelRenderDetails args) {
                      final String label = args.text;
                      final dataIndex = graphData.indexWhere((data) => data.menu == label);
                      if (dataIndex == -1 || graphData[dataIndex].menu.isEmpty) {
                        return ChartAxisLabel('', null);
                      }
                      return ChartAxisLabel(label, null);
                    },
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
                      xValueMapper: (_GraphData data, _) => data.menu.isEmpty ? '' : data.menu,
                      yValueMapper: (_GraphData data, _) => data.value,
                      pointColorMapper: (_GraphData data, _) =>
                      data.value == 0 ? Colors.grey.shade300 : Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                      dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                        labelAlignment: ChartDataLabelAlignment.top,
                        builder: (data, point, series, pointIndex, seriesIndex) {
                          final _GraphData currentData = data!;
                          if (currentData.value == 0) {
                            return const SizedBox.shrink(); // Hide label on empty bars
                          }
                          return Column(
                            mainAxisSize: MainAxisSize.min,
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
                                  color: Colors.white,
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
            ],
          ),
        );
      }),
    );
  }

  void _showMonthYearPicker(BuildContext context) async {
    final now = DateTime.now();

    final selectedDate = await showMonthYearPicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2015),
      lastDate: now,
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: Colors.deepPurple,
            onPrimary: Colors.white,
            onSurface: Colors.deepPurple,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: Colors.deepPurple),
          ),
          dialogBackgroundColor: Colors.white,
          dialogTheme: const DialogTheme(backgroundColor: Colors.white),
        ),
        child: child!,
      ),
    );

    if (selectedDate == null) return;

    if (selectedDate.isAfter(now)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You cannot select a future month or year.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    final formatted = '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}';
    controller.selectedYear.value = selectedDate.year;
    controller.getNetIncome(month: formatted);
  }
}

class _GraphData {
  final String menu;
  final double value;
  final double profit;

  _GraphData(this.menu, this.value, this.profit);
}
