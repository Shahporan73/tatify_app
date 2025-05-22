import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class FirstCartShimmer extends StatelessWidget {
  const    FirstCartShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // simulate the year selector area shimmer (commented out in your code)
            Container(
              width: Get.width / 1.2,
              height: 24,
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 20),
            ),
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 8,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) => Container(
                  width: 40,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
