import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/view/user/user_home/view/user_restaurant_details_screen.dart';

import '../../../../data/utils/custom_loader.dart';
import '../../../../res/common_widget/main_app_bar.dart';
import '../controller/home_controller.dart';
import '../widget/home_list_widget.dart';

class SearchRestaurantView extends StatelessWidget {
  const SearchRestaurantView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    return Scaffold(
      appBar: const MainAppBar(title: 'Search Restaurants'),
      body: Column(
        children: [
          homeController.isLoading.value ?
            Center(child: CustomLoader(),) :
            ListView.builder(
              shrinkWrap: true,
              itemCount: homeController.nearbyRestaurantList.length,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                var data = homeController.nearbyRestaurantList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(()=>const UserRestaurantDetailsScreen());
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
        ],
      ),
    );
  }
}
