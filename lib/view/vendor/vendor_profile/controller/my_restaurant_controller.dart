import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tatify_app/view/vendor/vendor_add_item/controller/item_controller.dart';
import 'package:tatify_app/view/vendor/vendor_profile/model/my_Restaurant_model.dart';

import '../../../../data/api_client/bace_client.dart';
import '../../../../data/api_client/end_point.dart';
import '../../../../data/local_database/local_data_base.dart';
import '../../../../data/utils/const_value.dart';

class MyRestaurantController extends GetxController {
  var isLoading = false.obs;
  var myRestaurantsModel = MyRestaurantModel().obs;
  var tags = <String>[].obs;

  // Updated openingHours to be a Map
  RxMap<String, Map<String, dynamic>> openingHours =
      <String, Map<String, dynamic>>{}.obs;

  final TextEditingController restaurantNameController =
      TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  var pickedImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  //  map data
  var address = "".obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;

  final ItemController itemController = Get.put(ItemController());

  @override
  void onInit() {
    super.onInit();
    getMyRestaurants();
  }

  // Track the opening and closing times for each day
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

  final Map<String, bool> closedDays = {
    "Monday": false,
    "Tuesday": false,
    "Wednesday": false,
    "Thursday": false,
    "Friday": false,
    "Saturday": false,
    "Sunday": false,
  };

  // Retrieve restaurant info
  GetInfor() {
    restaurantNameController.text = myRestaurantsModel.value.data?.name ?? '';
    addressController.text = myRestaurantsModel.value.data?.address ?? '';
    cityController.text = myRestaurantsModel.value.data?.city ?? '';
  }

  Future<void> getMyRestaurants() async {
    isLoading.value = true;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': await LocalStorage.getData(key: accessToken),
      };
      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(
          api: EndPoint.getMyRestaurantsURL,
          headers: headers,
        ),
      );
      if (responseBody != null && responseBody['success'] == true) {
        myRestaurantsModel.value = MyRestaurantModel.fromJson(responseBody);

        if (myRestaurantsModel.value.data?.address != null) {
          address.value = myRestaurantsModel.value.data?.address ?? '';
          latitude.value = myRestaurantsModel.value.data?.location?.coordinates[1] ?? 0.0;
          longitude.value = myRestaurantsModel.value.data?.location?.coordinates[0] ?? 0.0;
          itemController.getFoods(restaurantId: myRestaurantsModel.value.data?.id ?? '');
          itemController.searchFoods(restaurantId: myRestaurantsModel.value.data?.id ?? '');
        }

        // Initialize tags and opening hours from API response (if available)
        if (myRestaurantsModel.value.data?.kitchenStyle != null) {
          tags.addAll(myRestaurantsModel.value.data?.kitchenStyle ?? []);
        }

        if (myRestaurantsModel.value.data?.openingHr != null) {
          // Initialize opening hours based on the API response
          for (var hour in myRestaurantsModel.value.data!.openingHr) {
            String day = hour.day!;
            openingHours[day] = {
              'openTime': hour.openTime,
              'closeTime': hour.closeTime,
              'isClosed': hour.isClosed ?? false,
            };
          }
        }

        GetInfor();
      } else {
        print('responseBody $responseBody');
      }
    } catch (e) {
      print('get my restaurants error $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Update restaurant
  Future<void> updateRestaurant(
      {
      required BuildContext context}) async {
    isLoading.value = true;
    try {
      Map<String, String> headers = {
        'Content-Type': 'multipart/form-data',
        'Authorization': await LocalStorage.getData(key: accessToken),
      };

      var request = http.MultipartRequest(
        'PUT',
        Uri.parse(EndPoint.updateRestaurantURL),
      );

      // Convert opening times to the required format
      List<Map<String, dynamic>> openingHourList = [];
      openingHours.forEach((day, hour) {
        final openTime = hour['openTime'];
        final closeTime = hour['closeTime'];
        final isClosed = hour['isClosed'];

        openingHourList.add({
          "day": day.toLowerCase(),
          "openTime":
              isClosed || openTime == null ? "00:00" : formatTo24Hour(openTime),
          "closeTime": isClosed || closeTime == null
              ? "00:00"
              : formatTo24Hour(closeTime),
          "isClosed": isClosed,
        });
      });

      // Prepare the body for the request
      Map<String, dynamic> body = {
        'name': restaurantNameController.text.trim(),
        'address': addressController.text.trim(),
        'kitchenStyle': tags,
        'city': cityController.text.trim(),
        'location': {
          'type': 'Point',
          'coordinates': [longitude.value, latitude.value],
        },
        'openingHr': openingHourList,
      };

      request.headers.addAll(headers);
      request.fields['data'] = jsonEncode(body);

      // Add image file to request if selected
      if (pickedImage.value != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'featureImage',
            pickedImage.value?.path ?? '',
            contentType: MediaType('image', 'jpeg'), // Assuming JPEG format
          ),
        );
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print('Success: ${response.body}');
        Get.rawSnackbar(message: 'Update Success');
        getMyRestaurants();
        Navigator.pop(context);
      } else {
        print('Error: ${response.body}');
      }
    } catch (e) {
      print('update restaurant error $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Add a new tag if it does not already exist
  void addTag(String tag) {
    if (tag.isNotEmpty && !tags.contains(tag)) {
      tags.add(tag);
    }
  }

  // Remove a tag
  void removeTag(String tag) {
    tags.remove(tag);
  }

  // Update opening hour for a specific day
  void updateOpeningHour(String day, String openTime, String closeTime) {
    if (openingHours.containsKey(day)) {
      openingHours[day] = {
        'openTime': openTime,
        'closeTime': closeTime,
        'isClosed': openingHours[day]?['isClosed'] ?? false,
      };
    }
  }

  // Toggle closed status for a specific day
  void toggleClosedDay(String day) {
    if (openingHours.containsKey(day)) {
      var current = openingHours[day];
      openingHours[day] = {
        'openTime': current?['openTime'] ?? "00:00",
        'closeTime': current?['closeTime'] ?? "00:00",
        'isClosed': !(current?['isClosed'] ?? false),
      };
    }
  }

  Future<void> selectImage() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        pickedImage.value = File(pickedFile.path);
        print('Image selected: ${pickedImage.value?.path}');
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  // Convert TimeOfDay to 24-hour format
  String formatTo24Hour(String time) {
    if (time == null || time.isEmpty) return "00:00";
    final timeParts = time.split(":");
    final int hour = int.parse(timeParts[0]);
    final int minute = int.parse(timeParts[1]);
    return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
  }
}
