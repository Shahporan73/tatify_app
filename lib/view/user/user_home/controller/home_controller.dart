import 'package:get/get.dart';
import 'package:tatify_app/view/user/user_home/model/get_near_by_restaurant_model.dart';

import '../../../../data/api_client/bace_client.dart';
import '../../../../data/api_client/end_point.dart';
import '../../../../data/local_database/local_data_base.dart';
import '../../../../data/utils/const_value.dart';

class HomeController extends GetxController{
  RxBool isLoading = false.obs;
  var nearbyRestaurantModel = GetNearByRestaurantModel().obs;
  var nearbyRestaurantList = <RestaurantList>[].obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getNearbyRestaurants();
  }

  Future<void> getNearbyRestaurants() async {
    isLoading.value = true;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': await LocalStorage.getData(key: accessToken),
      };
      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(
          api: EndPoint.nearbyRestaurantsURL(),
          headers: headers,
        ),
      );
      if (responseBody != null && responseBody['success'] == true) {
        nearbyRestaurantModel.value = GetNearByRestaurantModel.fromJson(responseBody);
        nearbyRestaurantList.value = nearbyRestaurantModel.value.data?.result ?? [];
      }
    } catch (e) {
      print('get nearby restaurants error $e');
    } finally {
      isLoading.value = false;
    }
  }
}