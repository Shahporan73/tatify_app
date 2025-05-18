// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/common_widget/empty_restaurant_view.dart';
import 'package:tatify_app/res/common_widget/main_app_bar.dart';
import 'package:tatify_app/view/user/user_favorite/controller/favorite_controller.dart';
import 'package:tatify_app/view/user/user_favorite/view/user_fav_details_screen.dart';
import 'package:tatify_app/view/user/user_home/controller/single_restaurant_controller.dart';

import '../../../../data/utils/custom_loader.dart';
import '../../../../res/custom_style/custom_style.dart';
import '../widget/favorite_widget.dart';

class UserFavoriteScreen extends StatelessWidget {
  const UserFavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoriteController controller = Get.put(FavoriteController());
    final SingleRestaurantController singleRestaurantController = Get.put(SingleRestaurantController());
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: MainAppBar(
        title: 'Favorite',
        leading: SizedBox(),
        backgroundColor: AppColors.bgColor,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.getFavorite();
        },
        child: Obx(
          () => Padding(
            padding: bodyPadding,
            child: controller.isLoading.value
                ? CustomLoader(
                    size: 32,
                  )
                : controller.favoriteList.isEmpty
                    ? EmptyRestaurantView()
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.favoriteList.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          var data = controller.favoriteList[index].restaurant;
                          return GestureDetector(
                            onTap: () {
                              singleRestaurantController.getSingleRestaurant(
                                restaurantId: data?.id ?? '',
                              ).then((value) {
                                  Get.to(() => UserFavDetailsScreen(
                                        restaurantId: controller.favoriteList[index].id ?? '',
                                      ),
                                  );
                                },
                              );
                            },
                            child: FavoriteWidget(
                              imagePath: data?.featureImage ?? '',
                              title: data?.name ?? '',
                              reviewsAndRating: '4.3(17)',
                              distance: '2km',
                              on2for1Click: () {},
                              onFreeSoftClick: () {},
                            ),
                          );
                        },
                      ),
          ),
        ),
      ),
    );
  }
}
