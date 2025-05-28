// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/data/utils/custom_loader.dart';
import 'package:tatify_app/res/common_widget/main_app_bar.dart';
import 'package:tatify_app/view/user/user_home/view/user_restaurant_details_screen.dart';
import '../controller/home_controller.dart';
import '../controller/single_restaurant_controller.dart';
import '../widget/home_list_widget.dart';

class SeeAllRestaurantsView extends StatelessWidget {
  const SeeAllRestaurantsView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    final SingleRestaurantController singleRestaurantController = Get.put(SingleRestaurantController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppBar(title: 'all_restaurants'.tr),
      body: Obx(() {
        if (homeController.isLoading.value) {
          // Show loader inside a scrollable widget so RefreshIndicator works
          return RefreshIndicator(
            onRefresh: () async {
              await homeController.getNearbyRestaurants();
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: 300,
                  child: Center(child: CustomLoader()),
                ),
              ],
            ),
          );
        }

        if (homeController.nearbyRestaurantList.isEmpty) {
          // Show empty message inside scrollable widget so RefreshIndicator works
          return RefreshIndicator(
            onRefresh: () async {
              await homeController.getNearbyRestaurants();
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: 300,
                  child: Center(
                    child: Text('no_restaurants_found'.tr),
                  ),
                ),
              ],
            ),
          );
        }

        // Normal list with refresh
        return RefreshIndicator(
          onRefresh: () async {
            await homeController.getNearbyRestaurants();
          },
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: homeController.nearbyRestaurantList.length,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              var data = homeController.nearbyRestaurantList[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    reviewsAndRating: '4.3(17)',
                    kitchenStyle: 'Kabab',
                    on2for1Click: () {},
                    onFreeSoftClick: () {},
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
