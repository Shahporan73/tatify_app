// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/data/utils/custom_loader.dart';
import 'package:tatify_app/res/common_widget/custom_button.dart';
import 'package:tatify_app/res/common_widget/empty_restaurant_view.dart';
import 'package:tatify_app/view/vendor/vendor_add_item/controller/item_controller.dart';
import 'package:tatify_app/view/vendor/vendor_add_item/widget/item_widget.dart';
import 'package:tatify_app/view/vendor/vendor_profile/controller/my_restaurant_controller.dart';

import '../../../../res/app_colors/App_Colors.dart';
import '../widget/added_all_item_header.dart';
import 'edit_item_screen.dart';

class AddedAllItemScreen extends StatelessWidget {
  const AddedAllItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ItemController controller = Get.put(ItemController());
    final MyRestaurantController restaurantController = Get.put(MyRestaurantController());
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Obx(
          ()=> RefreshIndicator(
            onRefresh: () async{
              await Future.wait([
                controller.getFoods(isLoadMore: false,
                    restaurantId: restaurantController.myRestaurantsModel.value.data?.id ?? '',
                ),
                restaurantController.getMyRestaurants(),
              ]);
            },
            child: CustomScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              slivers: [
                const SliverToBoxAdapter(
                  child: AddedAllItemHeader(),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _StickyHeaderDelegate(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 0.0),
                      color: Colors.white,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Obx(
                                      () => CustomButton(
                                    title: 'On Going',
                                    buttonColor: Colors.white,
                                    borderRadius: 0,
                                    titleColor: controller.selectedTab.value == 'onGoing' ? Colors.green : Colors.black,
                                    border: Border(bottom: BorderSide(
                                      width: 1,
                                      color: controller.selectedTab.value == 'onGoing'
                                          ? AppColors.secondaryColor
                                          : Colors.black,
                                    )),
                                    onTap: () => controller.switchTab('onGoing'),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Obx(
                                      () => CustomButton(
                                    title: 'Closed',
                                    buttonColor: Colors.white,
                                    borderRadius: 0,
                                    titleColor: controller.selectedTab.value == 'Closed' ? Colors.green : Colors.black,
                                    border: Border(bottom: BorderSide(
                                      width: 1,
                                      color: controller.selectedTab.value == 'Closed'
                                          ? AppColors.secondaryColor
                                          : Colors.black,
                                    )),
                                    onTap: () => controller.switchTab('Closed'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // List content: On Going and Closed list
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {

                      if (controller.isLoading.value && index == controller.foodList.length) {
                        return Center(
                          child: CustomLoader(),
                        );
                      }

                      if (controller.foodList.isEmpty && !controller.isLoading.value) {
                        return EmptyRestaurantView(
                          title: 'No item added yet',
                        );
                      }

                      var data = controller.foodList[index];
                      print('food length ${controller.foodList.length}');
                      return Obx(
                            ()=> Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                          child: controller.selectedTab.value == 'onGoing'
                              ? ItemWidget(
                              title: data.itemName ?? '',
                              price: data.price?.price?.toString() ?? '',
                              discountPrice: data.price?.discountPrice?.toString() ?? '',
                              offerDay: data.price?.offerDay ?? '',
                              description: data.description ?? '',

                              onEdit: () => Get.to(() => EditItemScreen(
                                menuName: data.itemName ?? '',
                                menuDescription: data.description ?? '',
                                standardPrice: data.price?.price?.toString() ?? '',
                                discountPrice: data.price?.discountPrice?.toString() ?? '',
                                offerDay: data.price?.offerDay ?? '',
                                menuId: data.id ?? '',
                              )),

                              isEdit: true
                          )
                              : ItemWidget(
                              title: data.itemName ?? '',
                              price: data.price?.price?.toString() ?? '',
                              discountPrice: data.price?.discountPrice?.toString() ?? '',
                              offerDay: data.price?.offerDay ?? '',
                              description: data.description ?? '',
                              isEdit: false
                          ),
                        ),
                      );
                    },
                    childCount: controller.selectedTab.value == 'onGoing'
                        ? controller.foodList.length  + (controller.isLoading.value ? 1 : 0)
                        : controller.foodList.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Custom delegate for sticky header
class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _StickyHeaderDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      elevation: 2.0,
      child: child,
    );
  }

  @override
  double get maxExtent => Get.height / 12;

  @override
  double get minExtent => Get.height / 12;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
