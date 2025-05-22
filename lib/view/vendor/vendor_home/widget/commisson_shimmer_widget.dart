import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CommissionShimmerWidget extends StatelessWidget {
  const CommissionShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double spacing = 8.0;
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: LayoutBuilder(builder: (context, constraints) {
          final double totalWidth = constraints.maxWidth;
          // Total spacing between 12 columns = 11 * spacing
          final double totalSpacing = spacing * 11;
          // Base column width (assume no doubled columns for calculation)
          final double columnWidth = (totalWidth - totalSpacing) / 12;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title bar (spans 4 columns + 3 spacings)
              Container(
                width: columnWidth * 4 + spacing * 3,
                height: 20,
                color: Colors.white,
              ),
              SizedBox(height: spacing * 2),
              // 3 rows of 12 columns
              for (int row = 0; row < 3; row++)
                Padding(
                  padding: EdgeInsets.only(bottom: spacing * 2),
                  child: Row(
                    children: List.generate(12, (index) {
                      // If double-width column, skip next column to avoid overlap
                      bool isDoubleWidth = (index % 3 == 0);

                      double width = columnWidth;
                      if (isDoubleWidth) {
                        width = columnWidth * 2 + spacing; // only one spacing added here
                      }

                      // If double-width, only render for current index, skip next index
                      if (isDoubleWidth) {
                        return Container(
                          margin: EdgeInsets.only(right: index == 11 ? 0 : spacing),
                          width: width,
                          height: 15,
                          color: Colors.white,
                        );
                      } else {
                        // If previous index was double-width, skip rendering this one
                        if (index > 0 && (index - 1) % 3 == 0) {
                          return const SizedBox.shrink();
                        }
                        return Container(
                          margin: EdgeInsets.only(right: index == 11 ? 0 : spacing),
                          width: width,
                          height: 15,
                          color: Colors.white,
                        );
                      }
                    }),
                  ),
                ),
              Container(
                width: double.infinity,
                height: 60,
                color: Colors.white,
              )
            ],
          );
        }),
      ),
    );
  }
}
