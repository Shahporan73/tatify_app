// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'dart:io';
import 'package:tatify_app/res/common_widget/custom_network_image_widget.dart'; // Update with the actual path of CustomNetworkImage widget

class RestaurantImageWidget extends StatelessWidget {
  final Rx<File?> pickedImage;
  final String? featureImage;
  final Function()? onImagePick;

  const RestaurantImageWidget({
    Key? key,
    required this.pickedImage,
    this.featureImage,
    this.onImagePick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // If pickedImage is not null, use its path. Otherwise, use featureImage (fallback).
      String? imageUrl = pickedImage.value?.path ?? featureImage;

      return Stack(
        alignment: Alignment.topRight,
        children: [
          if (pickedImage.value != null)
            FutureBuilder<File>(
              future: Future.value(pickedImage.value),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error loading image'));
                } else if (snapshot.hasData) {
                  return Image.file(
                    snapshot.data!,
                    height: Get.height / 4,
                    width: Get.width,
                    fit: BoxFit.cover,
                  );
                }
                return Container();
              },
            )
          else if (featureImage != null && featureImage!.isNotEmpty)
            CustomNetworkImage(
              imageUrl: featureImage!,
              height: Get.height / 4,
              width: Get.width,
              borderRadius: BorderRadius.circular(8),
            )
          else
            Container(),

          if (pickedImage.value != null)
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                pickedImage.value = null;
                print('Image deleted');
              },
            ),
          if (pickedImage.value == null)
            SizedBox(),

          // Button to pick a new image
          Positioned(
            bottom: 10,
            right: 10,
            child: InkWell(
              onTap: onImagePick,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.camera_alt, color: AppColors.primaryColor, size: 24,),
              ),
            ),
          ),
        ],
      );
    });
  }
}
