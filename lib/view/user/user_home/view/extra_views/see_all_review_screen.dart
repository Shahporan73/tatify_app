import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/res/common_widget/main_app_bar.dart';
import 'package:tatify_app/view/user/user_home/model/reviews_model.dart';

import '../../../../../res/app_const/app_const.dart';
import '../../../../../res/utils/created_at.dart';
import '../../../../../res/utils/review_format.dart';
import '../../controller/single_restaurant_controller.dart';
import '../../widget/user_reviews_widget.dart';

class SeeAllReviewScreen extends StatelessWidget {
  final List<ReviewList> reviewList;
  const SeeAllReviewScreen({super.key, required this.reviewList});

  @override
  Widget build(BuildContext context) {
    final SingleRestaurantController controller = Get.put(SingleRestaurantController());
    print('reviewList ${reviewList.length}');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppBar(title: 'Reviews'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
          itemCount: reviewList.length,
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var review = reviewList[index];
            return UserReviewsWidget(
              rating: review.ratings ?? 0.0,
              review: reviewFormat(review.ratings ?? 0.0),
              userImage:
              review.userInfo?.profileImage ?? placeholderImage,
              userName: review.userInfo?.name ?? 'Not Available',
              createdTime: createdAt(review.createdAt.toString()),
            );
          },
        ),
      ),
    );
  }
}
