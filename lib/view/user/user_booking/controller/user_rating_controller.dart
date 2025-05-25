import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../data/api_client/end_point.dart';
import '../../../../data/local_database/local_data_base.dart';
import '../../../../data/utils/const_value.dart';

class UserRatingController extends GetxController {
  var isLoading = false.obs;

  Future<void> submitRating(
      {required String foodId,
      required double service,
        required double food,
        required double ambience,
        required double cleanliness,
      required BuildContext context}) async {
    isLoading.value = true;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': LocalStorage.getData(key: accessToken),
      };

      Map<String, dynamic> body = {
        "foodId": foodId,
        "service": service,
        "food": food,
        "ambience": ambience,
        "cleanliness": cleanliness
      };
      String bodyJson = json.encode(body);

      print('body $body');

      final response = await http.post(
        Uri.parse(EndPoint.createReviewURL),
        headers: headers,
        body: bodyJson,
      );
      print('Hit api ${EndPoint.createReviewURL}');
      print('response ${response.body}');

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        Get.rawSnackbar(message: 'Rating submitted successfully', backgroundColor: Colors.green);
        Navigator.pop(context);
      }
    } catch (e) {
      print('submit rating error $e');
    } finally {
      isLoading.value = false;
    }
  }
}
