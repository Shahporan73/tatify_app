// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/view/user/user_discover/view/filtered_result_screen.dart';

class CityListWidget extends StatelessWidget {
  final CityController controller = Get.put(CityController());

  final List<String> cities = [
    'Aachen', 'Amsterdam', 'Bielefeld', 'Amsterdam', 'Augsburg', 'Bielefeld',
    'Augsburg', 'Augsburg', 'Augsburg', 'Augsburg', 'Berlin', 'Bielefeld',
    'Bielefeld', 'Bocuum', 'Aachen', 'Aachen', 'Bocuum', 'Aachen',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Close Button
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: const Icon(Icons.cancel, color: Colors.red, size: 28),
            onPressed: () => Get.back(),
          ),
        ),

        // City List
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: cities.length,
            separatorBuilder: (_, __) => const Divider(height: 1, thickness: 0.5),
            itemBuilder: (context, index) {
              String city = cities[index];
              return Obx(() => ListTile(
                title: Text(
                  city,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: controller.selectedCity.value == city
                        ? Colors.green
                        : Colors.black87,
                  ),
                ),
                trailing: const Text(
                  '108 Deals',
                  style: TextStyle(color: Colors.black45),
                ),
                onTap: () {
                  controller.selectedCity.value = city;
                  Get.back(); // Close the BottomSheet on selection
                  Get.to(()=>FilteredResultScreen(title: city,));
                },
              ));
            },
          ),
        ),
      ],
    );
  }
}

// Dummy City List Controller
class CityController extends GetxController {
  var selectedCity = ''.obs; // Holds selected city name
}