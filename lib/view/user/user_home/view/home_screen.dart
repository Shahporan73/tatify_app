// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/data/utils/custom_loader.dart';
import 'package:tatify_app/res/common_widget/custom_row_widget.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/common_widget/empty_restaurant_view.dart';
import 'package:tatify_app/view/user/user_home/controller/home_controller.dart';
import 'package:tatify_app/view/user/user_home/controller/single_restaurant_controller.dart';
import 'package:tatify_app/view/user/user_home/view/see_all_restaurants_view.dart';
import 'package:tatify_app/view/user/user_home/view/user_restaurant_details_screen.dart';
import 'package:tatify_app/view/user/user_home/widget/home_list_widget.dart';
import '../../../../res/app_colors/App_Colors.dart';
import '../widget/custom_sliver_app_bar.dart';


class UserHomeScreen extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  final SingleRestaurantController singleRestaurantController = Get.put(SingleRestaurantController());
  UserHomeScreen({super.key}){
    homeController.getNearbyRestaurants();
    homeController.getNearbyRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        return RefreshIndicator(
          color: AppColors.primaryColor,
          onRefresh: () async {
            await homeController.getNearbyRestaurants();
          },
          child: CustomScrollView(
            slivers: [
              CustomSliverAppbar(),

              SliverToBoxAdapter(
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.all(0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 0),
                        child: CustomRowWidget(
                          title: CustomText(
                            title: 'Nearby Restaurant',
                            color: AppColors.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          value: InkWell(
                            onTap: () => Get.to(() => SeeAllRestaurantsView(), transition: Transition.rightToLeft),
                            child: CustomText(title: 'See all', color: Colors.green),
                          ),
                        ),
                      ),

                      // body
                      homeController.isLoading.value
                          ? SizedBox(
                        height: 200,
                        child: Center(child: CustomLoader()),
                      )
                          : homeController.nearbyRestaurantList.isEmpty
                          ? EmptyRestaurantView(title: 'No Restaurants Found')
                          : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: homeController.nearbyRestaurantList.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          var data = homeController.nearbyRestaurantList[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: GestureDetector(
                              onTap: () {
                                singleRestaurantController
                                    .getSingleRestaurant(restaurantId: data.id ?? '')
                                    .then((value) {
                                  Get.to(() => UserRestaurantDetailsScreen(
                                    restaurantId: data.id ?? '',
                                  ));
                                });
                              },
                              child: HomeListWidget(
                                imagePath: data.featureImage ?? '',
                                title: data.name ?? '',
                                discountPrice: '6.99€',
                                price: '9.99€',
                                distance: '${data.distance?.toStringAsFixed(2)} km',
                                reviewsAndRating: '${data.review?.star?.toStringAsFixed(1) ?? 0.0}'
                                    '(${data.review?.total ?? 0})',
                                kitchenStyle: 'Kabab',
                                on2for1Click: () {},
                                onFreeSoftClick: () {},
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

