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
import '../widget/item_sticky_header_delegate_widget.dart';
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
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.wait([
              controller.getFoods(
                isLoadMore: false,
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
                delegate: ItemStickyHeaderDelegateWidget(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 0.0),
                    color: Colors.white,
                    child: Row(
                      children: [
                        Expanded(
                          child: Obx(() => CustomButton(
                            title: 'On Going',
                            buttonColor: Colors.white,
                            borderRadius: 0,
                            titleColor: controller.selectedTab.value == 'onGoing'
                                ? Colors.green
                                : Colors.black,
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: controller.selectedTab.value == 'onGoing'
                                    ? AppColors.secondaryColor
                                    : Colors.black,
                              ),
                            ),
                            onTap: () => controller.switchTab('onGoing'),
                          )),
                        ),
                        Expanded(
                          child: Obx(() => CustomButton(
                            title: 'Closed',
                            buttonColor: Colors.white,
                            borderRadius: 0,
                            titleColor: controller.selectedTab.value == 'Closed'
                                ? Colors.green
                                : Colors.black,
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: controller.selectedTab.value == 'Closed'
                                    ? AppColors.secondaryColor
                                    : Colors.black,
                              ),
                            ),
                            onTap: () => controller.switchTab('Closed'),
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Only this Obx remains for list updates
              Obx(() {
                final isLoading = controller.isLoading.value;
                final selectedTab = controller.selectedTab.value;
                final list = selectedTab == 'onGoing' ? controller.onGoingList : controller.onCloseList;

                if (!isLoading && list.isEmpty) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: EmptyRestaurantView(title: 'No item added yet'),
                  );
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      if (isLoading && index == list.length) {
                        return Center(child: CustomLoader());
                      }

                      final item = list[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        child: selectedTab == 'onGoing'
                            ? ItemWidget(
                          title: item.itemName ?? '',
                          price: item.price?.price?.toString() ?? '',
                          discountPrice: item.price?.discountPrice?.toString() ?? '',
                          offerDay: item.price?.offerDay ?? '',
                          description: item.description ?? '',
                          onEdit: () => Get.to(() => EditItemScreen(
                            menuName: item.itemName ?? '',
                            menuDescription: item.description ?? '',
                            standardPrice: item.price?.price?.toString() ?? '',
                            discountPrice: item.price?.discountPrice?.toString() ?? '',
                            offerDay: item.price?.offerDay ?? '',
                            menuId: item.id ?? '',
                          )),
                          isEdit: true,
                        )
                            : ItemWidget(
                          title: item.itemName ?? '',
                          price: item.price?.price?.toString() ?? '',
                          discountPrice: item.price?.discountPrice?.toString() ?? '',
                          offerDay: item.price?.offerDay ?? '',
                          description: item.description ?? '',
                          isEdit: false,
                        ),
                      );
                    },
                    childCount: list.length + (isLoading ? 1 : 0),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
