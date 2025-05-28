import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/common_widget/RoundTextField.dart';
import 'package:tatify_app/res/common_widget/empty_restaurant_view.dart';
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
    final TextEditingController _searchController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppBar(
          title: 'search_restaurants'.tr,
      ),
      body: RefreshIndicator(
        color: AppColors.primaryColor,
        onRefresh: () async {
          await homeController.getNearbyRestaurants();
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: RoundTextField(
                prefixIcon: Icon(Icons.search_outlined, color: Colors.grey,),
                hint: 'search_restaurants'.tr,
                controller: _searchController,
                onChanged: (p0) {
                  homeController.searchNearbyRestaurants(searchTerm: p0);
                },
                suffixIcon: _searchController.text.isNotEmpty
                    ? GestureDetector(
                  onTap: () {
                    _searchController.clear();
                  },
                  child: const Icon(Icons.clear, color: Colors.grey),
                )
                    : null,
              ),
            ),
            SizedBox(height: 16,),
            Expanded(
              child: Obx(() =>
              homeController.isLoading.value? Center(child: CustomLoader()):
              homeController.nearbyRestaurantList.isEmpty?
              EmptyRestaurantView(title: 'no_restaurant_found'.tr,) :
              ListView.builder(
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
                        reviewsAndRating: '${data.review?.star?.toStringAsFixed(1)??0.0}(${data.review?.total??0})',
                        kitchenStyle: 'Kabab',
                        on2for1Click: () {},
                        onFreeSoftClick: () {},
                      ),
                    ),
                  );
                },
              ),),
            ),
          ],
        )
      ),
    );
  }
}
