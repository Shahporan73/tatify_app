// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/res/common_widget/main_app_bar.dart';
import 'package:tatify_app/res/utils/created_at.dart';
import 'package:tatify_app/view/user/user_home/controller/notification_controller.dart';

import '../../../../data/utils/custom_loader.dart';
import '../../../../res/app_colors/App_Colors.dart';
import '../../../../res/common_widget/custom_text.dart';
import '../../../../res/custom_style/custom_size.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationController controller = Get.put(NotificationController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        // When scrolled close to the bottom, load more notifications
        controller.loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: MainAppBar(title: 'Notification'),
      body: Obx(() {
        if (controller.isLoading.value && controller.notificationList.isEmpty) {
          return CustomLoader();
        } else if (controller.notificationList.isEmpty) {
          return Center(child: Text('No Notification'));
        } else {
          return RefreshIndicator(
            color: AppColors.primaryColor,
            onRefresh: () async {
              await controller.getNotification(reset: true);
            },
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: 16),
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: controller.notificationList.length + 1, // +1 for loader
              itemBuilder: (context, index) {
                if (index == controller.notificationList.length) {
                  // Pagination loader at bottom
                  return Obx(() => controller.isMoreLoading.value
                      ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: CircularProgressIndicator()),
                  )
                      : SizedBox.shrink());
                }

                var data = controller.notificationList[index];
                bool isRead = data.isRead ?? false;

                return ListTile(
                  leading: Container(
                    width: Get.width / 7.2,
                    child: Row(
                      children: [
                        isRead
                            ? Container()
                            : CircleAvatar(
                          radius: 5,
                          backgroundColor: AppColors.primaryColor,
                        ),
                        widthBox5,
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Color(0xffE8EBF0),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.notifications_outlined,
                            color: AppColors.primaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  title: CustomText(
                    title: data.title ?? '',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black33,
                  ),
                  subtitle: CustomText(
                    title: createdAt(data.createdAt.toString()),
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black100,
                  ),
                );
              },
            ),
          );
        }
      }),
    );
  }
}
