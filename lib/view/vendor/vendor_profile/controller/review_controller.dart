import 'package:get/get.dart';
import 'package:tatify_app/view/vendor/vendor_profile/controller/my_restaurant_controller.dart';

import '../../../../data/api_client/bace_client.dart';
import '../../../../data/api_client/end_point.dart';
import '../../../../data/local_database/local_data_base.dart';
import '../../../../data/utils/const_value.dart';
import '../../../user/user_home/model/reviews_model.dart';

class ReviewController extends GetxController {
  var isLoadingReview = false.obs;
  var reviewModel = ReviewsModel().obs;
  var reviewList = <ReviewList>[].obs;
  final MyRestaurantController myRestaurantController = Get.find<MyRestaurantController>();

  @override
  void onInit() {
    super.onInit();
    getRestaurantReviews(restaurantId: myRestaurantController.myRestaurantsModel.value.data?.id ?? '');
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

  int get count1Star => reviewList.where((r) => (r.ratings ?? 0) >= 1 && (r.ratings ?? 0) < 2).length;
  int get count2Star => reviewList.where((r) => (r.ratings ?? 0) >= 2 && (r.ratings ?? 0) < 3).length;
  int get count3Star => reviewList.where((r) => (r.ratings ?? 0) >= 3 && (r.ratings ?? 0) < 4).length;
  int get count4Star => reviewList.where((r) => (r.ratings ?? 0) >= 4 && (r.ratings ?? 0) < 5).length;
  int get count5Star => reviewList.where((r) => (r.ratings ?? 0) == 5).length;

  double get averageRating {
    if (reviewList.isEmpty) return 0;
    double total = reviewList.fold(0, (sum, r) => sum + (r.ratings ?? 0));
    return total / reviewList.length;
  }
}
