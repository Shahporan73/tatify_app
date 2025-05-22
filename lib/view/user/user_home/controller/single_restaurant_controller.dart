import 'package:get/get.dart';
import 'package:tatify_app/view/user/user_home/model/single_Restaurant_model.dart';
import 'package:tatify_app/view/vendor/vendor_add_item/model/food_item_model.dart';

import '../../../../data/api_client/bace_client.dart';
import '../../../../data/api_client/end_point.dart';
import '../../../../data/local_database/local_data_base.dart';
import '../../../../data/utils/const_value.dart';
import '../model/reviews_model.dart';

class SingleRestaurantController extends GetxController{
  var isLoading = false.obs;
  var isLoadingFood = false.obs;
  var isLoadingReview = false.obs;

  var singleRestaurantModel = SingleRestaurantModel().obs;

  // food model
  var foodModel = FoodItemModel().obs;
  var foodList = <FoodList>[].obs;

  //review model
  var reviewModel = ReviewsModel().obs;
  var reviewList = <ReviewList>[].obs;


  Future<void> getSingleRestaurant({required String restaurantId}) async {
    isLoading.value = true;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': LocalStorage.getData(key: accessToken),
      };

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(
          api: EndPoint.singleRestaurantURL(id: restaurantId),
          headers: headers,
        ),
      );

      if (responseBody != null && responseBody['success'] == true) {
        singleRestaurantModel.value = SingleRestaurantModel.fromJson(responseBody);
        if(singleRestaurantModel.value.data != null){
          getRestaurantFood(restaurantId: singleRestaurantModel.value.data!.id.toString());
          getRestaurantReviews(restaurantId: singleRestaurantModel.value.data!.id.toString());
        }
      }else{
        print('food responseBody $responseBody');
      }
    } catch (e) {
      print('get single restaurant error $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getRestaurantFood({required String restaurantId}) async {
    isLoadingFood.value = true;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': LocalStorage.getData(key: accessToken),
      };

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(
          api: EndPoint.getFoodsURL(restaurantId: restaurantId),
          headers: headers,
        ),
      );

      if (responseBody != null && responseBody['success'] == true) {
        foodModel.value = FoodItemModel.fromJson(responseBody);
        foodList.value = foodModel.value.data?.result ?? [];
      }

    } catch (e) {
      print('get single restaurant food error $e');
    } finally {
      isLoadingFood.value = false;
    }
  }


  Future<void> getRestaurantReviews({required String restaurantId}) async {
    isLoadingReview.value = true;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': LocalStorage.getData(key: accessToken),
      };

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(
          api: EndPoint.getReviewURL(restaurantId: restaurantId),
          headers: headers,
        ),
      );

      if (responseBody != null && responseBody['success'] == true) {
        reviewModel.value = ReviewsModel.fromJson(responseBody);
        reviewList.value = reviewModel.value.data ?? [];
      }

    } catch (e) {
      print('get single restaurant review error $e');
    } finally {
      isLoadingReview.value = false;
    }
  }

  Future<void> createRestaurantReviews({required String foodId}) async {
    isLoadingReview.value = true;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': LocalStorage.getData(key: accessToken),
      };
      Map<String, dynamic> body = {
        "foodId": "68231fc9edb8a8173026e6e1",
        "service": 1,
        "food": 5,
        "ambience": 2,
        "cleanliness": 5
      };

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.postRequest(
          api: EndPoint.createReviewURL,
          headers: headers,
          body: body,
        ),
      );

      if (responseBody != null && responseBody['success'] == true) {
        Get.rawSnackbar(message: 'Review added successfully');
      }

    } catch (e) {
      print('create restaurant review error $e');
    } finally {
      isLoadingReview.value = false;
    }
  }

  Future<void> searchRestaurant(String query) async {
    isLoading.value = true;
    try {
      final String? token = await LocalStorage.getData(key: accessToken);
      if (token == null || token.isEmpty) {
        throw Exception('Authorization token is missing.');
      }

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': token,
      };

      final Map<String, String>? queryParams = query.isEmpty ? null : {'search': query.trim()};

      final dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(
          api: EndPoint.getMyRestaurantsURL,
          params: queryParams,
          headers: headers,
        ),
      );

      if (responseBody != null && responseBody['success'] == true) {
        singleRestaurantModel.value = SingleRestaurantModel.fromJson(responseBody);

        final restaurantData = singleRestaurantModel.value.data;
        if (restaurantData != null) {
          final String restaurantId = restaurantData.id.toString();
          await Future.wait([
            getRestaurantFood(restaurantId: restaurantId),
            getRestaurantReviews(restaurantId: restaurantId),
          ]);
        }
      } else {
        print('Search restaurant returned unsuccessful response.');
      }
    } catch (error, stackTrace) {
      print('Error during restaurant search: $error');
      print(stackTrace);
    } finally {
      isLoading.value = false;
    }
  }


}