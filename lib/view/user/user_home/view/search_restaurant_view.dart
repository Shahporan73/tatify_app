import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/view/user/user_home/view/user_restaurant_details_screen.dart';

import '../../../../data/utils/custom_loader.dart';
import '../../../../res/common_widget/main_app_bar.dart';
import '../controller/home_controller.dart';
import '../controller/single_restaurant_controller.dart';
import '../widget/home_list_widget.dart';

class SearchRestaurantView extends StatelessWidget {
  const SearchRestaurantView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    final SingleRestaurantController singleRestaurantController = Get.put(SingleRestaurantController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MainAppBar(title: 'Search Restaurants'),
      body: RefreshIndicator(
        onRefresh: () async {
          await homeController.getNearbyRestaurants();
        },
        child: Obx(() {
          if (homeController.isLoading.value) {
            return ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [SizedBox(height: 300, child: Center(child: CustomLoader()))],
            );
          }

          if (homeController.nearbyRestaurantList.isEmpty) {
            return ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [SizedBox(height: 300, child: Center(child: Text('No Restaurants Found')))],
            );
          }

          return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: homeController.nearbyRestaurantList.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              var data = homeController.nearbyRestaurantList[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                  onTap: () {
                    singleRestaurantController.
                    getSingleRestaurant(restaurantId: data.id ?? '').then(
                          (value) {
                        Get.to(()=>UserRestaurantDetailsScreen(
                          restaurantId: data.id ?? '',
                        ));
                      },
                    );

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
          );
        }),
      ),
    );
  }
}
