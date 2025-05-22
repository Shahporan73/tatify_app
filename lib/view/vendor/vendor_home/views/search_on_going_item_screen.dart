// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/common_widget/RoundTextField.dart';
import 'package:tatify_app/res/common_widget/main_app_bar.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/view/vendor/vendor_home/widget/home_menu_widget.dart';

import '../../../../data/utils/custom_loader.dart';
import '../../../../res/common_widget/custom_text.dart';
import '../../vendor_add_item/controller/item_controller.dart';
import 'vendor_restaurant_details_screen.dart';

class SearchOnGoingItemScreen extends StatelessWidget {
  const SearchOnGoingItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ItemController foodItemController = Get.put(ItemController());
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: MainAppBar(title: 'Search', backgroundColor: AppColors.bgColor,),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: RoundTextField(
              hint: 'Search',
              prefixIcon: Icon(
                Icons.search_outlined,
                color: Colors.grey,
              ),
            ),
          ),
          heightBox20,
          Expanded(
            child: foodItemController.isLoading.value?
            Center(child: CustomLoader(),):
            foodItemController.onGoingList.isEmpty?
            Center(child: CustomText(title: 'No item found', fontSize: 16,)):
            ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: foodItemController.onGoingList.length,
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
                      foodPrice: food.price?.price?.toStringAsFixed(0) ?? '0',
                      discountPrice: food.price?.discountPrice?.toStringAsFixed(0) ?? '0',
                      offerDay: food.price?.offerDay ?? '',
                      description: food.description ?? '',
                    ),
                  ),
                );
              },
            )
          )
        ],
      ),
    );
  }
}
