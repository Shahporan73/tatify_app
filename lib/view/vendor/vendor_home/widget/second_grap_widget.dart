import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import '../../../../res/custom_style/custom_size.dart';
import '../controller/total_commission_controller.dart';
import 'commisson_shimmer_widget.dart';

class SecondGrapWidget extends StatelessWidget {
  final TotalCommissionController controller = Get.put(TotalCommissionController());

  SecondGrapWidget({Key? key}) : super(key: key) {
    controller.getTotalCommission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Obx(() {
            if (controller.isLoading.value) {
              return CommissionShimmerWidget();
            }

            // If empty, create default months with 0 commission so chart shows empty bars
            List<_MonthlyData> graphData;
            if (controller.totalCommissionList.isEmpty) {
              final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
              graphData = months
                  .map((m) => _MonthlyData(m, 0, m == 'Dec' ? Colors.orange : Colors.green))
                  .toList();
            } else {
              graphData = controller.totalCommissionList.map((item) {
                final color = (item.monthName == 'Dec') ? Colors.orange : Colors.green;
                return _MonthlyData(item.monthName ?? '', (item.totalCommission ?? 0).toDouble(), color);
              }).toList();
            }

            final selectedIndex = controller.selectedMonthIndex.value;

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(children: [
                        TextSpan(
                          text: 'Total Commission this year: ',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                        TextSpan(
                          text: '\$${controller.totalCommissionModel.value.data?.totalCommission ?? 0}',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        )
                      ]),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () => _filterByYear(context),
                      child: Row(
                        children: [
                          CustomText(
                            title: 'Filter',
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          Icon(Icons.filter_alt_outlined, color: AppColors.blackColor),
                        ],
                      ),
                    ),
                    widthBox15,
                  ],
                ),
                heightBox10,
                SizedBox(
                  height: Get.height / 4.2,
                  child: SfCartesianChart(
                    plotAreaBorderWidth: 0,
                    primaryXAxis: CategoryAxis(
                      axisLine: const AxisLine(width: 0),
                      majorTickLines: const MajorTickLines(size: 0),
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
                        pointColorMapper: (_MonthlyData data, index) {
                          if (index == selectedIndex) return Colors.blueAccent;
                          return data.color;
                        },
                        width: 0.8,
                        borderRadius: BorderRadius.circular(5),
                        onPointTap: (ChartPointDetails details) {
                          controller.selectedMonthIndex.value = details.pointIndex ?? 0;
                        },
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: graphData.asMap().entries.map((entry) {
                    final idx = entry.key;
                    final data = entry.value;
                    final bool isSelected = idx == selectedIndex;
                    final bool isDec = data.month == 'Dec';
                    final label = (data.month.length > 3) ? data.month.substring(0, 3) : data.month;
                    return GestureDetector(
                      onTap: () => controller.selectedMonthIndex.value = idx,
                      child: Text(
                        label,
                        style: TextStyle(
                          fontSize: 12,
                          color: isSelected
                              ? Colors.blueAccent
                              : (isDec ? Colors.orange : Colors.grey[700]),
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : (isDec ? FontWeight.bold : FontWeight.normal),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Future<int?> showSimpleYearPicker(BuildContext context) async {
    final currentYear = DateTime.now().year;
    final years = List.generate(50, (index) => currentYear - index);

    return await showDialog<int>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Year'),
        content: SingleChildScrollView(
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: years.map((year) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  backgroundColor: Colors.grey[200],
                  foregroundColor: Colors.black,
                ),
                onPressed: () => Navigator.pop(context, year),
                child: Text(year.toString()),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }


  Future<void> _filterByYear(BuildContext context) async {
    final pickedYear = await showSimpleYearPicker(context);
    if (pickedYear != null) {
      controller.selectedYear.value = pickedYear;
      await controller.getTotalCommission(year: pickedYear.toString());
      controller.selectedMonthIndex.value = 0;
    }
  }
}

class _MonthlyData {
  final String month;
  final double value;
  final Color color;

  _MonthlyData(this.month, this.value, this.color);
}
