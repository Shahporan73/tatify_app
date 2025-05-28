// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/data/utils/get_relative_time.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/app_const/app_const.dart';
import 'package:tatify_app/res/common_widget/empty_restaurant_view.dart';
import 'package:tatify_app/res/common_widget/main_app_bar.dart';
import 'package:tatify_app/view/user/user_home/controller/home_controller.dart';
import 'package:tatify_app/view/user/user_home/controller/single_restaurant_controller.dart';
import 'package:tatify_app/view/user/user_home/view/user_restaurant_details_screen.dart';
import 'package:tatify_app/view/user/user_home/widget/home_list_widget.dart';
import 'package:tatify_app/view/vendor/vendor_home/widget/home_menu_widget.dart';

import '../../../../data/utils/custom_loader.dart';
import '../../user_home/model/get_near_by_restaurant_model.dart';

class FilteredResultScreen extends StatelessWidget {
  FilteredResultScreen({super.key});

  final HomeController homeController = Get.put(HomeController());
  final SingleRestaurantController singleRestaurantController = Get.put(SingleRestaurantController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: MainAppBar(title: 'results'.tr),
      body: Obx(
            () => Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: homeController.isLoading.value
              ? Center(child: CustomLoader())
              : homeController.filterNearbyRestaurantList.isEmpty
              ? EmptyRestaurantView(title: 'no_restaurants_found'.tr)
              : ListView.builder(
              itemCount: homeController.filterNearbyRestaurantList.length,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                var data = homeController.filterNearbyRestaurantList[index];
                return GestureDetector(
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
                    imagePath: data.featureImage ?? placeholderImage,
                    title: data.name ?? 'not_found'.tr,
                    discountPrice: '6.99€',
                    price: '9.99€',
                    distance: '${data.distance?.toStringAsFixed(0) ?? 0} km',
                    kitchenStyle: getLimitedWord(data.kitchenStyle.join(', '), 7),
                    reviewsAndRating: '${data.review?.star?.toStringAsFixed(1) ?? 0.0}'
                        '(${data.review?.total?.toStringAsFixed(0) ?? 0})',
                    on2for1Click: () {},
                    onFreeSoftClick: () {},
                  ),
                );
              }),
        ),
      ),
    );
  }
}
