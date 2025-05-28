// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/data/utils/custom_loader.dart';
import 'package:tatify_app/res/common_widget/custom_button.dart';
import 'package:tatify_app/res/common_widget/empty_restaurant_view.dart';
import 'package:tatify_app/view/vendor/vendor_add_item/controller/item_controller.dart';
import 'package:tatify_app/view/vendor/vendor_add_item/widget/item_widget.dart';
import 'package:tatify_app/view/vendor/vendor_add_item/widget/item_widget_shimmer.dart';
import 'package:tatify_app/view/vendor/vendor_profile/controller/my_restaurant_controller.dart';

import '../../../../res/app_colors/App_Colors.dart';
import '../../../../res/common_widget/custom_alert_dialog.dart';
import '../widget/added_all_item_header.dart';
import '../widget/item_sticky_header_delegate_widget.dart';
import 'edit_item_screen.dart';

class AddedAllItemScreen extends StatelessWidget {
  final ItemController controller = Get.put(ItemController());
  final MyRestaurantController restaurantController = Get.put(MyRestaurantController());
  AddedAllItemScreen({super.key}){
    controller.getFoods(isLoadMore: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primaryColor,
          onRefresh: () async {
            controller.selectedTab.value = 'onGoing';
            await Future.wait([
              controller.getFoods(
                isLoadMore: false,
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
                            title: 'on_going'.tr,
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
                            title: 'closed'.tr,
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
                    child: EmptyRestaurantView(title: 'no_item_added_yet'.tr),
                  );
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {

                      if (isLoading && index == list.length) {
                        return Center(child: ItemWidgetShimmer(count: 3));
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
                          onDelete: () {
                            CustomAlertDialog().customAlert(
                              context: context,
                              isLoading: controller.isDeletingLoading,
                              title: "alert".tr,
                              message: 'are_you_sure_you_want_to_delete_item'.tr,
                              NegativebuttonText: "cancel".tr,
                              PositivvebuttonText: "confirm".tr,
                              onPositiveButtonPressed: () => controller.deleteItem(foodId: item.id ?? '', context: context),
                              onNegativeButtonPressed: () => Navigator.of(context).pop(),
                            );
                          },
                        )
                            : ItemWidget(
                          title: item.itemName ?? '',
                          price: item.price?.price?.toString() ?? '',
                          discountPrice: item.price?.discountPrice?.toString() ?? '',
                          offerDay: item.price?.offerDay ?? '',
                          description: item.description ?? '',
                          isEdit: true,
                          onEdit: () => Get.to(() => EditItemScreen(
                            menuName: item.itemName ?? '',
                            menuDescription: item.description ?? '',
                            standardPrice: item.price?.price?.toString() ?? '',
                            discountPrice: item.price?.discountPrice?.toString() ?? '',
                            offerDay: item.price?.offerDay ?? '',
                            menuId: item.id ?? '',
                          )),
                          onDelete: () {
                            CustomAlertDialog().customAlert(
                              context: context,
                              isLoading: controller.isDeletingLoading,
                              title: "alert".tr,
                              message: 'are_you_sure_you_want_to_delete_item'.tr,
                              NegativebuttonText: "cancel".tr,
                              PositivvebuttonText: "confirm".tr,
                              onPositiveButtonPressed: () => controller.deleteItem(foodId: item.id ?? '', context: context),
                              onNegativeButtonPressed: () => Navigator.of(context).pop(),
                            );
                          },
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
