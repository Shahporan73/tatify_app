import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tatify_app/view/user/user_favorite/model/favorite_restaurant_model.dart';
import 'package:tatify_app/view/user/user_home/controller/home_controller.dart';
import 'package:tatify_app/view/user/user_home/controller/single_restaurant_controller.dart';

import '../../../../data/api_client/bace_client.dart';
import '../../../../data/api_client/end_point.dart';
import '../../../../data/local_database/local_data_base.dart';
import '../../../../data/utils/const_value.dart';

class FavoriteController extends GetxController{
  var isLoading = false.obs;
  var favoriteRestaurantModel = FavoriteRestaurantModel().obs;
  var favoriteList = <Fav_restaurant_list>[].obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getFavorite();
  }

  Future<void> getFavorite() async {
    isLoading.value = true;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': await LocalStorage.getData(key: accessToken),
      };
      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(
          api: EndPoint.getFavoriteURL,
          headers: headers,
        ),
      );
      if(responseBody != null && responseBody['success'] == true){
        print('responseBody $responseBody');
        favoriteRestaurantModel.value = FavoriteRestaurantModel.fromJson(responseBody);
        favoriteList.value = favoriteRestaurantModel.value.data ?? [];
      }
    } catch (e) {
      print('get favorite error $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createFavorite({required String restaurantId}) async {
    isLoading.value = true;
    try {
      String token = await LocalStorage.getData(key: accessToken);
      // Prepare headers for the request
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': token,
      };

      Map<String, String> body = {
        'restaurant': restaurantId,
      };

      String bodyJson = json.encode(body);

      // Send the POST request
      final response = await http.post(
        Uri.parse(EndPoint.addFavoriteURL),
        headers: headers,
        body: bodyJson,
      );

      print('response ${response.body}');

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        if (responseBody != null && responseBody['success'] == true) {
          getFavorite();
          Get.rawSnackbar(message: 'Add to favorite successfully');
        } else {
          Get.rawSnackbar(message: 'Add to favorite failed');
        }
      } else {
        final respon = json.decode(response.body);
        Get.rawSnackbar(message: '${respon['message']}');
      }
    } catch (e) {
      Get.rawSnackbar(message: 'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removeFavorite({required String restaurantId, required BuildContext context}) async {
    isLoading.value = true;
    try {
      String token = await LocalStorage.getData(key: accessToken);
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': token,
      };
      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.deleteRequest(
          api: EndPoint.removeFavoriteURL(restaurantId: restaurantId),
          headers: headers,
        ),
      );

      print('Hit api ${EndPoint.removeFavoriteURL(restaurantId: restaurantId)}');


      if(responseBody != null && responseBody['success'] == true){
        getFavorite();
        Navigator.pop(context);
        Get.rawSnackbar(message: 'Remove from favorite successfully');
      }else{
        Get.rawSnackbar(message: 'Remove from favorite failed');
      }
    } catch (e) {
      print('create favorite error $e');
    } finally {
      isLoading.value = false;
    }
  }


}