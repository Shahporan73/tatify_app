import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tatify_app/view/vendor/vendor_add_item/model/food_item_model.dart';

import '../../../../data/api_client/bace_client.dart';
import '../../../../data/api_client/end_point.dart';
import '../../../../data/local_database/local_data_base.dart';
import '../../../../data/utils/const_value.dart';

class ItemController extends GetxController {
  var isLoading = false.obs;
  var selectedDay = "".obs;

  var selectedTab = 'onGoing'.obs;
  var selectedDays = <String>[].obs;

  final menuNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final standardPriceController = TextEditingController();
  final discountController = TextEditingController();

  // for get food item
  var foodItemModel = FoodItemModel().obs;
  var foodList = <FoodList>[].obs;
  RxInt currentPage = 1.obs;
  RxInt totalPages = 1.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    selectDay(selectedDay.value);
  }


  Future<void> getFoods({bool isLoadMore = false, required String restaurantId}) async {
    if (isLoading.value) return;

    // If not loading more, reset pagination
    if (!isLoadMore) {
      currentPage.value = 1;
      totalPages.value = 1;
    } else if (currentPage.value > totalPages.value) {
      return;
    }

    isLoading.value = true;

    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': LocalStorage.getData(key: accessToken),
      };

      final url = EndPoint.getFoodsURL(
        restaurantId: restaurantId,
          page: currentPage.value,
          limit: 10
      );
      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: url, headers: headers),
      );

      print('API Hit: $url');
      print('Response Body: $responseBody');

      if (responseBody != null && responseBody['success'] == true) {
        final newModel = FoodItemModel.fromJson(responseBody);

        if (!isLoadMore) {
          foodList.value = newModel.data?.result ?? [];
        } else {
          foodList.addAll(newModel.data?.result ?? []);
        }

        foodItemModel.value = newModel;
        totalPages.value = newModel.data?.meta?.totalPage ?? 1;
        currentPage.value++;
      } else {
        print("Failed to load food data");
      }
    } catch (e) {
      print('Error fetching food list: $e');
    } finally {
      isLoading.value = false;
    }
  }





  Future<void> addItem({required BuildContext context}) async {
    isLoading.value = true;
    try {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': LocalStorage.getData(key: accessToken),
    };

    Map<String, dynamic> body = {
      "itemName": menuNameController.text,
      "description": descriptionController.text,
      "price": {
        "price": int.parse(standardPriceController.text),
        "discountPrice": int.parse(discountController.text),
        "offerDay": selectedDay.value.toLowerCase(),
      }
    };

    print('body $body');

      var response = await http.post(
        Uri.parse(EndPoint.createFoodURL),
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        Navigator.of(context).pop();
        selectedDay.value = "";
        Get.rawSnackbar(message: 'Food created successfully');
      } else {
        print('Failed to create food item: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      print('create food item error: $e');
    }finally{
      isLoading.value = false;
    }
  }

  Future<void> updateItem({
    required BuildContext context,
    required String menuId,
    required String menuName,
    required String menuDescription,
    required String standardPrice,
    required String discountPrice
  }) async {
    isLoading.value = true;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': LocalStorage.getData(key: accessToken),
      };

      Map<String, dynamic> body = {
        "itemName": menuName,
        "description": menuDescription,
        "price": {
          "price": int.parse(standardPrice),
          "discountPrice": int.parse(discountPrice),
          "offerDay": selectedDay.value.toLowerCase(),
        }
      };


      print('body $body');

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.putRequest(
          api: EndPoint.updateFoodURL(foodId: menuId),
          body: body,
          headers: headers,
        ),
      );


      if (responseBody != null && responseBody['success'] == true) {
        selectedDay.value = "";
        Get.rawSnackbar(message: 'Food updated successfully');
        Navigator.of(context).pop();
      } else {
        print('Failed to create food item: ${responseBody.statusCode}');
        print('Response: ${responseBody.body}');
      }
    } catch (e) {
      print('update food item error: $e');
    }finally{
      isLoading.value = false;
    }
  }



  void switchTab(String newData){
    selectedTab.value = newData;
  }

  /*void selectDay(String day) {
      if (day == "7 days") {
        selectedDays.value = ["7 days"];
      } else {
        if (selectedDays.contains("7 days")) {
          selectedDays.clear();
        }

        if (selectedDays.contains(day)) {
          selectedDays.remove(day);
        } else {
          selectedDays.value = [day];
        }
      }
  }*/


  void selectDay(String day) {
    if (day == "7days") {
      selectedDays.value = ["7days"];
      selectedDay.value = "7days";
    } else {
      if (selectedDays.contains("7days")) {
        selectedDays.clear();
      }

      if (selectedDays.contains(day)) {
        selectedDays.remove(day);
        selectedDay.value = "";
      } else {
        selectedDays.value = [day];
        selectedDay.value = day;
      }
    }
  }


}