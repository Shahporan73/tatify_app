import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../../data/api_client/end_point.dart';
import '../../../data/local_database/local_data_base.dart';
import '../../../data/utils/const_value.dart';
import '../view/sign_in_screen.dart';
import 'package:path/path.dart' as path;

class RestaurantController extends GetxController {
  var isLoading = false.obs;


  var imagePath = Rxn<String>();
  final ImagePicker _picker = ImagePicker();

  final TextEditingController restaurantNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  final TextEditingController kitchenStyleController = TextEditingController();
  final List<dynamic> tags = [].obs;

  final Map<String, TimeOfDay?> openingTimes = {
    "Monday": null,
    "Tuesday": null,
    "Wednesday": null,
    "Thursday": null,
    "Friday": null,
    "Saturday": null,
    "Sunday": null,
  };

  final Map<String, TimeOfDay?> closingTimes = {
    "Monday": null,
    "Tuesday": null,
    "Wednesday": null,
    "Thursday": null,
    "Friday": null,
    "Saturday": null,
    "Sunday": null,
  };

  final RxSet<String> closedDays = <String>{}.obs;

  void addTag(String tag) {
    if (tag.isNotEmpty && !tags.contains(tag)) {
      tags.add(tag);
    }
    kitchenStyleController.clear();
  }

  void removeTag(String tag) {
    tags.remove(tag);
  }

  Future<void> createRestaurant({required double latitude, required double longitude}) async {
    isLoading.value = true;
    var imageFile = imagePath.value;
    try {
      Map<String, String> headers = {
        'Content-Type': 'multipart/form-data',
      };

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(EndPoint.createRestaurantURL),
      );

      String vendId = await LocalStorage.getData(key: vendorId);
      if (vendId.isEmpty) {
        Get.snackbar('Error', 'Vendor id is empty');
      }


      RxList openingHours = [].obs;

      // Convert to 24-hour format when sending data
      openingTimes.forEach((day, openTime) {
        final isClosed = closedDays.contains(day);
        final closeTime = closingTimes[day];

        openingHours.add({
          "day": day.toLowerCase(),
          "openTime": isClosed || openTime == null ? "00:00" : formatTo24Hour(openTime),
          "closeTime": isClosed || closeTime == null ? "00:00" : formatTo24Hour(closeTime),
          "isClosed": isClosed,
        });
      });

      Map<String, dynamic> body = {
        'name': restaurantNameController.text.trim(),
        'vendorId': vendId,
        'address': addressController.text.trim(),
        'kitchenStyle': tags,
        'city': cityController.text.trim(),
        'location': {
          'coordinates': [longitude, latitude],
        },
        'openingHr': openingHours,
      };

      request.headers.addAll(headers);
      request.fields['data'] = jsonEncode(body);

      if (imageFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'featureImage',
            imageFile,
            contentType: MediaType('image', 'jpeg'),
          ),
        );
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print('Success: ${response.body}');

        var responseBody = jsonDecode(response.body);

        var resId = responseBody['data']['_id'];
        print('resId $resId');
        await LocalStorage.saveData(key: restaurantId, data: resId);


        Get.offAll(() => SignInScreen());


        Get.rawSnackbar(message: 'Restaurant created successfully');
      }else if(response.statusCode == 413) {
        Get.rawSnackbar(message: 'Image size is too large');
      } else {
        print('Error ${response.statusCode}: ${response.body}');
        var responseBody = jsonDecode(response.body);
        if (responseBody['message'] == 'You allready have a restaurant!') {
          Get.offAll(() => SignInScreen());
          Get.rawSnackbar(message: 'You already have a restaurant!');
        }
      }

    } catch (e) {
      print('create restaurant error $e');
    } finally {
      isLoading.value = false;
    }
  }


  String formatTo24Hour(TimeOfDay time) {
    final hour = time.hour;
    final minute = time.minute;
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  // Method to pick the image from the gallery
  Future<void> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    if (pickedFile != null) {
      final File originalFile = File(pickedFile.path);
      final int fileSize = await originalFile.length();

      // If image is > 1MB, compress it
      if (fileSize > 1 * 1024 * 1024) {
        final dir = await getTemporaryDirectory();
        final targetPath = path.join(dir.path, 'compressed_${path.basename(pickedFile.path)}');

        final compressedFile = await FlutterImageCompress.compressAndGetFile(
          pickedFile.path,
          targetPath,
          quality: 70, // Reduce quality to shrink size
        );

        if (compressedFile != null) {
          imagePath.value = compressedFile.path;
        } else {
          Get.snackbar('Error', 'Image compression failed',
              backgroundColor: Colors.red, snackPosition: SnackPosition.TOP);
        }
      } else {
        imagePath.value = pickedFile.path;
      }
    }
  }

}
