// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatify_app/data/utils/get_relative_time.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/app_const/app_const.dart';
import 'package:tatify_app/res/common_widget/empty_restaurant_view.dart';
import 'package:tatify_app/res/utils/created_at.dart';
import 'package:tatify_app/res/utils/review_format.dart';
import 'package:tatify_app/view/user/user_home/controller/single_restaurant_controller.dart';
import 'package:tatify_app/view/user/user_home/view/extra_views/see_all_food_screen.dart';
import 'package:tatify_app/view/user/user_home/view/extra_views/see_all_review_screen.dart';
import 'package:tatify_app/view/user/user_home/widget/restaurant_details_header_widget.dart';
import 'package:tatify_app/view/user/user_home/widget/user_details_item_widget.dart';
import 'package:tatify_app/view/user/user_home/widget/user_reviews_widget.dart';
import 'package:tatify_app/view/vendor/vendor_home/widget/map_widget.dart';
import 'package:tatify_app/view/vendor/vendor_home/widget/time_schedule_widget.dart';

import '../../../../data/utils/custom_loader.dart';
import '../../../../res/common_widget/custom_button.dart';
import '../../../../res/common_widget/custom_text.dart';
import '../../../../res/custom_style/custom_size.dart';

class UserRestaurantDetailsScreen extends StatefulWidget {
  final String? restaurantId;
  const UserRestaurantDetailsScreen({super.key, this.restaurantId});
  @override
  State<UserRestaurantDetailsScreen> createState() =>
      _UserRestaurantDetailsScreenState();
}

class _UserRestaurantDetailsScreenState extends State<UserRestaurantDetailsScreen> {
  late final SingleRestaurantController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(SingleRestaurantController());
    if (widget.restaurantId != null) {
      controller.getSingleRestaurant(restaurantId: widget.restaurantId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Obx(
            () {
          if (controller.isLoading.value) {
            return Center(child: CustomLoader());
          } else if (controller.singleRestaurantModel.value.data == null) {
            return EmptyRestaurantView(title: 'restaurant_not_available'.tr);
          }

          var data = controller.singleRestaurantModel.value.data;
          return SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: RestaurantDetailsHeaderWidget(
                    restaurantImage: data?.featureImage ?? placeholderImage,
                    restaurantName: data?.name ?? 'not_available'.tr,
                    rating: data?.review?.star?.toStringAsFixed(2) ?? '0.0',
                    kitchenType: data?.kitchenStyle.join(', ') ?? '',
                    restaurantId: widget.restaurantId ?? '',
                  ),
                ),

                // User details items list
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        if (controller.isLoadingFood.value &&
                            index == controller.foodList.length) {
                          return Center(child: CustomLoader());
                        }

                        if (controller.foodList.isEmpty &&
                            !controller.isLoadingFood.value) {
                          return EmptyRestaurantView(
                            title: 'food_not_available'.tr,
                          );
                        }

                        var food = controller.foodList[index];
                        return UserDetailsItemWidget(
                          foodName: food.itemName ?? 'not_available'.tr,
                          standardPrice: food.price?.price.toString() ?? '0',
                          discountPrice:
                          food.price?.discountPrice.toString() ?? '0',
                          offerDays: food.price?.offerDay ?? '',
                          description: food.description ?? 'not_available'.tr,
                          foodId: food.id ?? '',
                        );
                      },
                      childCount: min(controller.foodList.length, 2),
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: const SizedBox(height: 5),
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: (controller.foodList.length == 0 || controller.foodList.length <= 2)
                        ? SizedBox()
                        : CustomButton(
                      title: 'all_food'.trParams({'count': controller.foodList.length.toString()}),
                      buttonColor: AppColors.secondaryColor,
                      borderRadius: 25,
                      padding_vertical: 8,
                      onTap: () {
                        Get.to(
                              () => SeeAllFoodScreen(foodList: controller.foodList),
                          transition: Transition.downToUp,
                        );
                      },
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: const SizedBox(height: 20),
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'ratings_and_reviews'.tr,
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: const SizedBox(height: 10),
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Text(
                          data?.review?.star?.toStringAsFixed(2) ?? '0.0',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 8),
                        RatingBarIndicator(
                          itemCount: 5,
                          itemSize: 18,
                          rating: data?.review?.star ?? 0.0,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: AppColors.secondaryColor,
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: const SizedBox(height: 5),
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      '${data?.review?.total ?? 0} ${'reviews'.tr}',
                      style: TextStyle(
                        color: AppColors.black100,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: const Divider(color: AppColors.secondaryColor),
                ),

                // Reviews list
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        if (controller.isLoadingReview.value &&
                            index == controller.reviewList.length) {
                          return Center(child: CustomLoader());
                        }
                        if (controller.reviewList.isEmpty &&
                            !controller.isLoadingReview.value) {
                          return EmptyRestaurantView(
                            title: 'reviews_not_available'.tr,
                          );
                        }

                        var review = controller.reviewList[index];

                        String date = createdAt(review.createdAt.toString());

                        print('created at date: $date');
                        return UserReviewsWidget(
                          rating: review.ratings ?? 0.0,
                          review: reviewFormat(review.ratings ?? 0.0),
                          userImage:
                          review.userInfo?.profileImage ?? placeholderImage,
                          userName: review.userInfo?.name ?? 'not_available'.tr,
                          createdTime: createdAt(review.createdAt.toString()),
                        );
                      },
                      childCount: min(controller.reviewList.length, 5),
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: const SizedBox(height: 20),
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: (data?.review?.total ?? 0) <= 5
                        ? SizedBox()
                        : CustomButton(
                      title: 'all_reviews'.trParams({'count': (data?.review?.total ?? 0).toString()}),
                      buttonColor: AppColors.secondaryColor,
                      borderRadius: 25,
                      padding_vertical: 8,
                      onTap: () {
                        Get.to(
                              () => SeeAllReviewScreen(reviewList: controller.reviewList),
                          transition: Transition.downToUp,
                        );
                      },
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: const SizedBox(height: 20),
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on_outlined,
                            color: AppColors.secondaryColor, size: 24),
                        const SizedBox(width: 8),
                        Text(
                          'location'.tr,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(left: 41, top: 4),
                    child: CustomText(
                      title: data?.address ?? '',
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: const SizedBox(height: 10),
                ),

                // Map
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    width: double.infinity,
                    height: height / 3.5,
                    child: MapWidget(
                      latitude: data?.location?.coordinates[1] ?? 0.0,
                      longitude: data?.location?.coordinates[0] ?? 0.0,
                      address: data?.address ?? '',
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: const SizedBox(height: 20),
                ),

                SliverToBoxAdapter(
                  child: Container(
                    height: Get.height / 3.5,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.watch_later_outlined,
                              color: AppColors.secondaryColor,
                              size: 19,
                            ),
                            widthBox10,
                            CustomText(
                              title: 'opening_hours'.tr,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            )
                          ],
                        ),
                        heightBox5,
                        Expanded(
                          child: controller.isLoading.value
                              ? CustomLoader(
                            size: 28,
                          )
                              : ListView.builder(
                            itemCount: data?.openingHr.length ?? 0,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemBuilder: (context, index) {
                              return TimeScheduleWidget(
                                day: data?.openingHr[index].day ?? '',
                                openTime:
                                data?.openingHr[index].openTime ?? '',
                                closeTime:
                                data?.openingHr[index].closeTime ?? '',
                                isClosed:
                                data?.openingHr[index].isClosed ?? false,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: const SizedBox(height: 50),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
