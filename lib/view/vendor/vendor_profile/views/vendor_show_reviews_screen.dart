// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatify_app/res/common_widget/RoundTextField.dart';
import 'package:tatify_app/res/common_widget/custom_button.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/common_widget/empty_restaurant_view.dart';
import 'package:tatify_app/res/common_widget/main_app_bar.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/res/custom_style/custom_style.dart';
import 'package:tatify_app/view/vendor/vendor_home/widget/rating_bar_widget.dart';
import 'package:tatify_app/view/vendor/vendor_home/widget/show_reviews_widget.dart';
import 'package:tatify_app/view/vendor/vendor_profile/controller/review_controller.dart';

import '../../../../data/utils/custom_loader.dart';
import '../../../../res/app_colors/App_Colors.dart';
import '../../../../res/app_const/app_const.dart';
import '../../../../res/utils/created_at.dart';
import '../../../../res/utils/review_format.dart';

class VendorShowReviewsScreen extends StatelessWidget {
  const VendorShowReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ReviewController controller = Get.put(ReviewController());
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: MainAppBar(
        title: 'rating_and_review'.tr,
        backgroundColor: AppColors.whiteColor,
      ),
      body: SingleChildScrollView(
        padding: bodyPadding,
        child: Obx(
              () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Average Rating & Review count
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Average Rating
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            controller.averageRating.toStringAsFixed(1),
                            style: GoogleFonts.urbanist(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '${controller.reviewList.length}\n${'ratings'.tr}',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.urbanist(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 20),
                      // Rating Distribution Bars
                      Expanded(
                        child: Column(
                          children: [
                            RatingBarWidget(
                              starCount: 5,
                              fillPercent: 0.8,
                              rating: controller.count5Star,
                            ),
                            RatingBarWidget(
                              starCount: 4,
                              fillPercent: 0.6,
                              rating: controller.count4Star,
                            ),
                            RatingBarWidget(
                              starCount: 3,
                              fillPercent: 0.4,
                              rating: controller.count3Star,
                            ),
                            RatingBarWidget(
                              starCount: 2,
                              fillPercent: 0.2,
                              rating: controller.count2Star,
                            ),
                            RatingBarWidget(
                              starCount: 1,
                              fillPercent: 0.1,
                              rating: controller.count1Star,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  heightBox20,
                  CustomText(
                    title: '${controller.reviewList.length} ${'reviews'.tr}',
                    color: AppColors.black100,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                  Divider(
                    color: AppColors.secondaryColor,
                  ),
                  controller.isLoadingReview.value
                      ? CustomLoader()
                      : controller.reviewList.isEmpty
                      ? EmptyRestaurantView(
                    title: 'no_review_available'.tr,
                  )
                      : ListView.builder(
                    itemCount: controller.reviewList.length,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      var review = controller.reviewList[index];
                      return ShowReviewsWidget(
                        rating: review.ratings ?? 0.0,
                        review: reviewFormat(review.ratings ?? 0.0),
                        userImage: review.userInfo?.profileImage ??
                            placeholderImage,
                        userName: review.userInfo?.name ??
                            'not_available'.tr,
                        createdTime:
                        createdAt(review.createdAt.toString()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
