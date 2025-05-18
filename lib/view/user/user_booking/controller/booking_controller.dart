import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tatify_app/view/user/user_booking/model/get_book_redeem_model.dart';

import '../../../../data/api_client/bace_client.dart';
import '../../../../data/api_client/end_point.dart';
import '../../../../data/local_database/local_data_base.dart';
import '../../../../data/utils/const_value.dart';
import '../../../vendor/vendor_redeem/views/redeem_success_screen.dart';
import '../../user_home/view/book_deal_success_screen.dart';

class BookingController extends GetxController {
  var isLoading = false.obs;

  var getBookRedeemModel = GetBookRedeemModel().obs;
  var getBookRedeemList = <BookingList>[].obs;


  @override
  void onInit() {
    super.onInit();
    getBookRedeem();
  }

  Future<void> getBookRedeem() async {
    isLoading.value = true;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': LocalStorage.getData(key: accessToken),
      };
      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(
          api: EndPoint.getRedeemURL(),
          headers: headers,
        ),
      );
      if (responseBody != null && responseBody['success'] == true) {
        getBookRedeemModel.value = GetBookRedeemModel.fromJson(responseBody);
        getBookRedeemList.value = getBookRedeemModel.value.data?.data ?? [];

        print('get book redeem ${getBookRedeemList.length}');
      }
    } catch (e) {
      print('get book redeem error $e');
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> createBooking({required String foodId, required BuildContext context}) async {
    isLoading.value = true;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': LocalStorage.getData(key: accessToken),
      };

      Map<String, dynamic> body = {"food": foodId};
      String bodyJson = json.encode(body);

      final response = await http.post(
        Uri.parse(EndPoint.createRedeemURL),
        headers: headers,
        body: bodyJson,
      );

      print(response.body);

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        if (responseBody != null && responseBody['success'] == true) {
          getBookRedeem();
          Get.rawSnackbar(message: 'Booking created successfully');
          Navigator.pop(context);
          Get.to(() => BookDealSuccessScreen());
        } else {
          Get.rawSnackbar(message: 'Add to favorite failed');
        }
      } else {
        final respon = json.decode(response.body);
        Get.rawSnackbar(message: '${respon['message']}');
      }
    } catch (e) {
      print('create booking error $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> userRedeem({required String redeemId}) async {
    isLoading.value = true;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': LocalStorage.getData(key: accessToken),
      };

      Map<String, dynamic> body = {
        "redeemStatus": "redeemed",
        "redeemId": redeemId
      };

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.putRequest(
          api: EndPoint.userRedeemURL,
          headers: headers,
          body: body,
        ),
      );

      if (responseBody != null && responseBody['success'] == true) {
        Get.rawSnackbar(message: 'Redeem successfully');
        getBookRedeem();
        Future.delayed(Duration(seconds: 1), () {
          Get.offAll(() => RedeemSuccessScreen(isUser: true));
        });
        return true;
      } else {
        Get.rawSnackbar(message: 'Redeem failed');
        return false;
      }
    } catch (e) {
      print('user redeem error $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> vendorRedeem({required String redeemId}) async {
    isLoading.value = true;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': LocalStorage.getData(key: accessToken),
      };

      Map<String, dynamic> body = {
        "redeemStatus": "redeemed",
        "redeemId": redeemId
      };

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.putRequest(
          api: EndPoint.vendorRedeemURL,
          headers: headers,
          body: body,
        ),
      );

      if (responseBody != null && responseBody['success'] == true) {
        Get.rawSnackbar(message: 'Redeem successfully');
        getBookRedeem();
        Future.delayed(Duration(seconds: 1), () {
          Get.offAll(() => RedeemSuccessScreen(isUser: false));
        });
        return true;
      } else {
        Get.rawSnackbar(message: 'Redeem failed');
        return false;
      }
    } catch (e) {
      print('user redeem error $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

}
