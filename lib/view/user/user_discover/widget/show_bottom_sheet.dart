// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../../../../res/common_widget/custom_network_image_widget.dart';

void showBottomSheet({required BuildContext context}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        margin: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CustomNetworkImage(
                  imageUrl: 'https://t4.ftcdn.net/jpg/02/74/99/01/360_F_274990113_ffVRBygLkLCZAATF9lWymzE6bItMVuH1.jpg',
                  fit: BoxFit.cover,
                  width: 60,
                  height: 60,
                ),
              ),
              title: Text("SPICETRAILS Altstadt",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Row(
                children: [
                  Icon(Icons.star, color: Colors.orange, size: 18),
                  SizedBox(width: 4),
                  Text("4.3 (17)"),
                  SizedBox(width: 8),
                  Icon(Icons.location_on, color: Colors.red, size: 18),
                  SizedBox(width: 4),
                  Text("2 km"),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8)),
                    child: Text("\$10 Discount",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(width: 8),
                  Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(8)),
                    child: Text("Free soft drink",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}