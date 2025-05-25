// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tatify_app/data/utils/custom_loader.dart';
import 'package:tatify_app/res/common_widget/custom_button.dart';
import 'package:tatify_app/res/common_widget/custom_row_widget.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/view/user/user_home/widget/user_details_item_widget.dart';
import 'package:tatify_app/view/user/user_home/widget/user_reviews_widget.dart';
import 'package:tatify_app/view/vendor/vendor_home/widget/map_widget.dart';
import 'package:tatify_app/view/vendor/vendor_home/widget/time_schedule_widget.dart';

import '../../../../res/app_colors/App_Colors.dart';
import '../../../../res/app_const/app_const.dart';
import '../../../../res/app_images/App_images.dart';
import '../../../../res/common_widget/custom_network_image_widget.dart';
import '../../../../res/common_widget/custom_text.dart';
import '../../../../res/common_widget/empty_restaurant_view.dart';
import '../../../../res/utils/created_at.dart';
import '../../../../res/utils/review_format.dart';
import '../../user_home/controller/single_restaurant_controller.dart';
import '../../user_home/view/extra_views/see_all_food_screen.dart';
import '../../user_home/view/extra_views/see_all_review_screen.dart';
import '../controller/favorite_controller.dart';
import '../widget/fave_details_header_widget.dart';

class UserFavDetailsScreen extends StatefulWidget {
  final String? restaurantId;
  const UserFavDetailsScreen({super.key, this.restaurantId});

  @override
  State<UserFavDetailsScreen> createState() => _UserFavDetailsScreenState();
}

class _UserFavDetailsScreenState extends State<UserFavDetailsScreen> {
  late GoogleMapController mapController;

  final LatLng restaurantLocation = LatLng(23.7678, 90.4125);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final FavoriteController favoriteController = Get.put(FavoriteController());
    final SingleRestaurantController controller = Get.put(SingleRestaurantController());
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Obx(() {
            var data = controller.singleRestaurantModel.value.data;
            return SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: FaveDetailsHeaderWidget(
                      restaurantImage: data?.featureImage ?? placeholderImage,
                      restaurantName: data?.name ?? 'Not Available',
                      rating: data?.review?.star?.toStringAsFixed(2) ?? '0.0',
                      kitchenType: (data?.kitchenStyle ?? []).join(', '),
                      restaurantId: widget.restaurantId ?? '',
                    ),
                  ),

                  // User details items list
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          if (controller.isLoadingFood.value && index == controller.foodList.length) {
                            return Center(child: CustomLoader());
                          }

                          if (controller.foodList.isEmpty && !controller.isLoadingFood.value) {
                            return EmptyRestaurantView(
                              title: 'Food Not Available',
                            );
                          }
                          var food = controller.foodList[index];
                          return UserDetailsItemWidget(
                            foodName: food.itemName ?? 'Not Available',
                            standardPrice: food.price?.price.toString() ?? '0',
                            discountPrice: food.price?.discountPrice.toString() ?? '0',
                            offerDays: food.price?.offerDay ?? '',
                            description: food.description ?? 'Not Available',
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
                        title: 'All Food (${controller.foodList.length})',
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
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Ratings & reviews',
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
                        '${data?.review?.total ?? 0} reviews',
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
                          if (controller.isLoadingReview.value && index == controller.reviewList.length) {
                            return Center(child: CustomLoader());
                          }
                          if (controller.reviewList.isEmpty && !controller.isLoadingReview.value) {
                            return EmptyRestaurantView(
                              title: 'Reviews Not Available',
                            );
                          }

                          var review = controller.reviewList[index];

                          String date = createdAt(review.createdAt.toString());

                          print('created at date: $date');
                          return UserReviewsWidget(
                            rating: review.ratings ?? 0.0,
                            review: reviewFormat(review.ratings ?? 0.0),
                            userImage: review.userInfo?.profileImage ?? placeholderImage,
                            userName: review.userInfo?.name ?? 'Not Available',
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
                        title: 'All reviews (${data?.review?.total ?? 0})',
                        buttonColor: AppColors.secondaryColor,
                        borderRadius: 25,
                        padding_vertical: 8,
                        onTap: () {
                          Get.to(
                                () => SeeAllReviewScreen(reviewList: controller.reviewList,),
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
                        children: const [
                          Icon(Icons.location_on_outlined,
                              color: AppColors.secondaryColor, size: 24),
                          SizedBox(width: 8),
                          Text('Location',
                            style: TextStyle(fontSize: 18),
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
                              Icon(
                                Icons.watch_later_outlined,
                                color: AppColors.secondaryColor,
                                size: 19,
                              ),
                              widthBox10,
                              CustomText(
                                title: 'Opening hours',
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
                              itemBuilder: (context, index) {
                                return TimeScheduleWidget(
                                  day: data?.openingHr[index].day ?? '',
                                  openTime: data?.openingHr[index].openTime ?? '',
                                  closeTime:data?.openingHr[index].closeTime ??'',
                                  isClosed: data?.openingHr[index].isClosed ??false,
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


TextStyle titleStyle = GoogleFonts.poppins(
fontSize: 12,
  fontWeight: FontWeight.w400,
  color: Color(0xff5C5C5C)
);