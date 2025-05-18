import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/res/common_controller/map_controller.dart';

void showSearchDialog(BuildContext context) {
  final AddressSearchController searchController = Get.put(AddressSearchController());

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Search Places'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Search for places'),
              onChanged: (query) {
                searchController.searchPlaces(query);
              },
            ),
            Obx(() {
              if (searchController.isLoading.value) {
                return CircularProgressIndicator();
              } else if (searchController.searchResults.isEmpty) {
                print('No results found');
                return Text('No results found');
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: searchController.searchResults.length,
                  itemBuilder: (context, index) {
                    final place = searchController.searchResults[index];

                    print('place $place');
                    return ListTile(
                      title: Text(place['name']),
                      subtitle: Text(place['formatted_address'] ?? 'No address'),
                      onTap: () {
                        Get.snackbar(
                          'Selected Place',
                          place['formatted_address'] ?? 'No address',
                        );
                        // Optionally, save the selected place to your state
                        Get.back();
                      },
                    );
                  },
                );
              }
            }),
          ],
        ),
      );
    },
  );
}
