// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/data/utils/custom_loader.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/common_widget/custom_row_widget.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/view/vendor/vendor_home/views/search_on_going_item_screen.dart';
import 'package:tatify_app/view/vendor/vendor_home/widget/first_grap_widget.dart';
import 'package:tatify_app/view/vendor/vendor_home/widget/home_menu_widget.dart';
import 'package:tatify_app/view/vendor/vendor_home/widget/second_grap_widget.dart';
import 'package:tatify_app/view/vendor/vendor_home/widget/v_home_header_widget.dart';
import 'package:tatify_app/view/vendor/vendor_profile/controller/my_restaurant_controller.dart';
import '../../vendor_add_item/controller/item_controller.dart';
import '../../vendor_add_item/widget/item_widget_shimmer.dart';
import '../../vendor_profile/controller/vendor_profile_controller.dart';

class VendorHomeScreen extends StatelessWidget {
  final MyRestaurantController myRestaurantController = Get.put(MyRestaurantController());
  final VendorProfileController myProfileController = Get.put(VendorProfileController());
  final ItemController foodItemController = Get.put(ItemController());

  VendorHomeScreen({Key? key}) : super(key: key) {
    myRestaurantController.getMyRestaurants();
    myProfileController.getProfile();
  }

  Future<void> _refreshItems() async {
    await foodItemController.getFoods();
    await myRestaurantController.getMyRestaurants();
   await myProfileController.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        displacement: 20,
        color: AppColors.primaryColor,
        onRefresh: _refreshItems,
        child: CustomScrollView(
          slivers: [
            // Header section with sticky restaurant name
            SliverAppBar(
              expandedHeight: height / 4.8,
              floating: false,
              pinned: true,
              leading: SizedBox(),
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                background: Obx(
                      () => VHomeHeaderWidget(
                    userName: myProfileController.fullName.value.isNotEmpty
                        ? myProfileController.fullName.value
                        : 'User',
                    restaurantName:
                    myRestaurantController.myRestaurantsModel.value.data?.name ?? 'Not found',
                  ),
                ),
              ),
            ),

            // Content section below the header
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  heightBox10,
                  SizedBox(
                    height: height / 2.2,
                    child: NetIncomeChartWidget(),
                  ),

/*                  heightBox10,
                // total commission section
                  SizedBox(
                    height: height / 2.5,
                    child: SecondGrapWidget(),
                  ),*/
                  // OnGoing list
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: CustomRowWidget(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      title: CustomText(
                        title: 'ongoing_menu'.tr,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      value: IconButton(
                        onPressed: () {
                          Get.to(() => SearchOnGoingItemScreen(), transition: Transition.downToUp);
                        },
                        icon: Icon(
                          Icons.search_outlined,
                          size: 24,
                        ),
                      ),
                    ),
                  ),


                  Obx(
                        () => foodItemController.isLoading.value
                        ? Center(child: ItemWidgetShimmer(count: 2))
                        : foodItemController.onGoingList.isEmpty
                        ? Center(child: CustomText(title: 'no_item_found'.tr, fontSize: 16))
                        : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: min(foodItemController.onGoingList.length, 5),
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            var food = foodItemController.onGoingList[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: GestureDetector(
                                onTap: () {
                                  // Get.to(() => VendorRestaurantDetailsScreen());
                                },
                                child: HomeMenuWidget(
                                  foodName: food.itemName ?? '',
                                  foodPrice:
                                  food.price?.price?.toStringAsFixed(0) ?? '0',
                                  discountPrice:
                                  food.price?.discountPrice?.toStringAsFixed(0) ??
                                      '0',
                                  offerDay: food.price?.offerDay ?? '',
                                  description: food.description ?? '',
                                ),
                              ),
                            );
                          },
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
