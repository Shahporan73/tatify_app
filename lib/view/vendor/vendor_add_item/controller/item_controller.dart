import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tatify_app/view/vendor/vendor_add_item/model/food_item_model.dart';

import '../../../../data/api_client/bace_client.dart';
import '../../../../data/api_client/end_point.dart';
import '../../../../data/local_database/local_data_base.dart';
import '../../../../data/utils/const_value.dart';
import '../../vendor_profile/controller/my_restaurant_controller.dart';

class ItemController extends GetxController {
  var isLoading = false.obs;
  var isDeletingLoading = false.obs;
  var selectedDay = "".obs;

  var selectedTab = 'onGoing'.obs;
  var itemStatus = 'on-going'.obs;
  var selectedDays = <String>[].obs;

  final menuNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final standardPriceController = TextEditingController();
  final discountController = TextEditingController();

  // for get food item
  var foodItemModel = FoodItemModel().obs;
  var onGoingList = <FoodList>[].obs;
  var onCloseList = <FoodList>[].obs;
  RxInt currentPage = 1.obs;
  RxInt totalPages = 1.obs;


  void updateItemStatus(String value) {
    itemStatus.value = value;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getFoods(isLoadMore: false);
    selectDay(selectedDay.value);
  }

  Future<void> getFoods({bool isLoadMore = false}) async {
    if (isLoading.value) return;

    if (!isLoadMore) {
      currentPage.value = 1;
      totalPages.value = 1;
      onGoingList.clear();
      onCloseList.clear();
    } else if (currentPage.value > totalPages.value) {
      return;
    }
    isLoading.value = true;

    try {

      String? restid = await LocalStorage.getData(key: restaurantId);


      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': LocalStorage.getData(key: accessToken),
      };

      final url = EndPoint.getFoodsURL(
        restaurantId: restid,
        page: currentPage.value,
        limit: 9999999999999999,
      );
      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(
            api: url,
            headers: headers
        ),
      );

      print('API Hit: $url');
      print('Response Body: $responseBody');

      if (responseBody != null && responseBody['success'] == true) {
        final newModel = FoodItemModel.fromJson(responseBody);

        // Clear lists if not loading more
        if (!isLoadMore) {
          onGoingList.clear();
          onCloseList.clear();
        }

        final items = newModel.data?.result ?? [];

        // Separate items based on status - match exact strings returned by API
        final ongoingItems = items.where((item) => item.status == "on-going").toList();
        final closedItems = items.where((item) => item.status == "closed").toList();

        if (!isLoadMore) {
          onGoingList.assignAll(ongoingItems);
          onCloseList.assignAll(closedItems);
        } else {
          onGoingList.addAll(ongoingItems);
          onCloseList.addAll(closedItems);
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

  Future<void> searchFoods({String? searchTerm}) async {
    isLoading.value = true;
    try {
      String? restid = await LocalStorage.getData(key: restaurantId);
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': LocalStorage.getData(key: accessToken),
      };

      final url = EndPoint.getFoodsURL(
        restaurantId: restid,
        searchTerm: searchTerm
      );

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(
            api: url,
            headers: headers
        ),
      );

      print('API Hit: $url');
      print('Response Body: $responseBody');

      if (responseBody != null && responseBody['success'] == true) {
        final newModel = FoodItemModel.fromJson(responseBody);
        final items = newModel.data?.result ?? [];
        // Separate items based on status
        final ongoingItems = items.where((item) => item.status == "on-going").toList();
        onGoingList.value = ongoingItems;
        onGoingList.addAll(ongoingItems);
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
        await getFoods();
        selectedDay.value = "";
        menuNameController.clear();
        descriptionController.clear();
        standardPriceController.clear();
        discountController.clear();
        Navigator.of(context).pop();
        Get.rawSnackbar(message: 'Food created successfully');
      } else {
        print('Failed to create food item: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      print('create food item error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateItem(
      {required BuildContext context,
      required String menuId,
      required String menuName,
      required String menuDescription,
      required String standardPrice,
      required String discountPrice}) async {
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
        },
        'status': itemStatus.value
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
        getFoods();
        selectedDay.value = "";
        Get.rawSnackbar(message: 'Food updated successfully');
        Navigator.of(context).pop();
      } else {
        print('Failed to update food item: ${responseBody.statusCode}');
        print('Response: ${responseBody.body}');
      }
    } catch (e) {
      print('update food item error: $e');
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> deleteItem({required String foodId, required BuildContext context}) async {
    isDeletingLoading.value = true;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': LocalStorage.getData(key: accessToken),
      };

      Map<String, dynamic> body = {
        'status': 'archived'
      };

      print('body $body');

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.putRequest(
          api: EndPoint.updateFoodURL(foodId: foodId),
          body: body,
          headers: headers,
        ),
      );

      if (responseBody != null && responseBody['success'] == true) {
        getFoods();
        Navigator.of(context).pop();
        Get.rawSnackbar(message: 'delete_success'.tr, backgroundColor: Colors.red);
      } else {
        print('Failed to delete food item: ${responseBody.statusCode}');
        print('Response: ${responseBody.body}');
      }
    } catch (e) {
      print('Delete food item error: $e');
    } finally {
      isDeletingLoading.value = false;
    }
  }

  void switchTab(String newData) {
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
