import 'package:flutter/material.dart';
import 'package:tatify_app/view/vendor/vendor_add_item/model/food_item_model.dart';

import '../../../../../res/common_widget/main_app_bar.dart';
import '../../widget/user_details_item_widget.dart';

class SeeAllFoodScreen extends StatelessWidget {
  final List<FoodList> foodList;
  const SeeAllFoodScreen({super.key, required this.foodList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppBar(title: 'Foods'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
          itemCount: foodList.length,
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var food = foodList[index];
            return UserDetailsItemWidget(
              foodName: food.itemName ?? 'Not Available',
              standardPrice: food.price?.price.toString() ?? '0',
              discountPrice: food.price?.discountPrice.toString() ?? '0',
              offerDays: food.price?.offerDay ?? '',
              description: food.description ?? 'Not Available',
              foodId: food.id ?? '',
            );
          },
        ),
      ),
    );
  }
}
