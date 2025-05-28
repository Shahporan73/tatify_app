import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';

class ItemWidgetShimmer extends StatelessWidget {
  final int count;
  const ItemWidgetShimmer({Key? key, required this.count}) : super(key: key);

  Widget _shimmerBox({double? height, double? width, BorderRadius? borderRadius}) {
    return Container(
      height: height ?? 16,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: borderRadius ?? BorderRadius.circular(8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      itemCount: count,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.bgColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 1,
              ),
            ],
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _shimmerBox(height: 20, width: 150, borderRadius: BorderRadius.circular(8)),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      flex: 13,
                      child: _shimmerBox(height: 30, borderRadius: BorderRadius.circular(16)),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 12,
                      child: _shimmerBox(height: 30, borderRadius: BorderRadius.circular(16)),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 10,
                      child: _shimmerBox(height: 30, borderRadius: BorderRadius.circular(16)),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                _shimmerBox(height: 14, width: double.infinity, borderRadius: BorderRadius.circular(8)),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 40,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
