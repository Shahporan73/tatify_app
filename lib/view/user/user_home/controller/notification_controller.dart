import 'dart:convert';

import 'package:get/get.dart';
import 'package:tatify_app/view/user/user_home/model/notification_model.dart';

import '../../../../data/api_client/bace_client.dart';
import '../../../../data/api_client/end_point.dart';
import '../../../../data/local_database/local_data_base.dart';
import '../../../../data/utils/const_value.dart';

class NotificationController extends GetxController {
  var isLoading = false.obs;
  var isMoreLoading = false.obs;
  var notificationModel = NotificationModel().obs;
  var notificationList = <NotificationList>[].obs;
  var currentPage = 1.obs;
  final int pageSize = 10;
  var hasMore = true.obs;

  @override
  void onInit() {
    super.onInit();
    getNotification(reset: true);
  }

  Future<void> onRefresh() async {
    await getNotification(reset: true);
  }

  Future<void> loadMore() async {
    if (isMoreLoading.value || !hasMore.value) return;

    isMoreLoading.value = true;
    currentPage.value++;
    await getNotification();
    isMoreLoading.value = false;
  }

  Future<void> getNotification({bool reset = false}) async {
    if (reset) {
      currentPage.value = 1;
      hasMore.value = true;
      notificationList.clear();
    }

    if (!hasMore.value) return;

    if (reset) {
      isLoading.value = true;
    }

    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': await LocalStorage.getData(key: accessToken),
      };

      // Add query parameters
      final queryParams = {
        'page': currentPage.value.toString(),
        'limit': pageSize.toString(),
      };

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(
          api: "${EndPoint.notificationURL}?${queryParams.entries.map((e) => '${e.key}=${e.value}').join('&')}",
          headers: headers,
        ),
      );

      if (responseBody != null) {
        NotificationModel newNotificationModel = NotificationModel.fromJson(responseBody);

        if (reset) {
          notificationModel.value = newNotificationModel;
          notificationList.value = newNotificationModel.data?.result ?? [];
        } else {
          // Append new notifications
          notificationList.addAll(newNotificationModel.data?.result ?? []);
        }

        // Check if more pages are available
        if ((newNotificationModel.data?.result.length ?? 0) < pageSize) {
          hasMore.value = false;
        }
        readAllNotification();
      }
    } catch (e) {
      print('get notification error $e');
    } finally {
      if (reset) isLoading.value = false;
    }
  }

  Future<void> readAllNotification() async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': LocalStorage.getData(key: accessToken),
      };
      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.putRequest(
          api: EndPoint.readAllNotificationURL,
          body: {},
          headers: headers,
        ),
      );

      if (responseBody != null && responseBody['success'] == true) {
        getNotification();
      }
    } catch (e) {
      print('read all notification error $e');
    }
  }
}
