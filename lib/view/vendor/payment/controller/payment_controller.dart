import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tatify_app/view/authenticate/view/sign_in_screen.dart';
import 'package:tatify_app/view/vendor/payment/model/get_subscription_model.dart';
import 'package:tatify_app/view/vendor/payment/views/payment_success_screen.dart';
import 'package:tatify_app/view/vendor/vendor_home/views/vendor_home_dashboard.dart';

import '../../../../data/api_client/bace_client.dart';
import '../../../../data/api_client/end_point.dart';
import '../../../../data/local_database/local_data_base.dart';
import '../../../../data/utils/const_value.dart';
import '../views/payment_webview_screen.dart';

class PaymentController extends GetxController {
  var isLoading = false.obs;
  var isPayNowLoading = false.obs;
  var subscriptionModel = GetSubscriptionModel().obs;
  var subscriptionList = <SubscriptionList>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getSubscription();
  }

  Future<void> getSubscription() async {
    isLoading(true);
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': await LocalStorage.getData(key: accessToken),
      };

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(
            api: EndPoint.getSubscriptionURL,
            headers: headers
        ),
      );

      if (responseBody != null && responseBody['success'] == true) {
        subscriptionModel.value = GetSubscriptionModel.fromJson(responseBody);
        subscriptionList.value = subscriptionModel.value.data ?? [];
      } else {
        throw 'Failed to load data: ${responseBody['message']}';
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }


  Future<void> onCheckOutPayment({required String subscriptionId}) async {
    isPayNowLoading(true);
    try {
      final Uri url = Uri.parse(EndPoint.paymentURL(subscriptionId: subscriptionId));

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': LocalStorage.getData(key: accessToken),
      };

      final http.Response response = await http.post(
        url,
        headers: headers,
        body: jsonEncode({}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true) {
          var paymentURL = jsonResponse['data'];
          Get.to(() => PaymentWebView(paymentUrl: paymentURL));
        } else {
          print('Payment failed: ${jsonResponse['message']}');
        }
      } if(response.statusCode == 504){
        Get.rawSnackbar(message: 'Please check your internet connection');
      } else {
        print('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print("payment error: $e");
    } finally {
      isPayNowLoading(false);
    }
  }

  paymentResults({required String finishUrl}) async {
    isLoading(true);
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      final response = await http.get(Uri.parse(finishUrl), headers: headers);
      dynamic responseBody = jsonDecode(response.body);

      print("Response : ${response.statusCode}");


      if (responseBody != null) {
        print("Payment Success");
        // Ensure navigation happens after the UI rebuilds
        Future.delayed(
            Duration(milliseconds: 0), () {
          Get.offAll(() => PaymentSuccessScreen(
            title: 'your_payment_is_success'.tr,
            subTitle:
            'thank_you_for_connecting_with_us_and_for_placing_your_trust_in_us'.tr,
            onTap: () {
              Get.offAll(() => VendorHomeDashboard());
            },
          ));
        });
      } else {
        print("Payment Failed");
        Get.rawSnackbar(
          message: "payment_failed".tr,
        );
        if (LocalStorage.removeData(key: accessToken) != null) {
          LocalStorage.removeData(key: accessToken);
        }
        // Ensure that even on failure, navigation works correctly
        Future.delayed(Duration(milliseconds: 0), () {
          Get.offAll(() => SignInScreen());
        });
        throw 'Request failed with status: ${response.statusCode}';
      }
    } catch (e) {
      print("Error processing payment: $e");
    } finally {
      isLoading(false);
    }
  }


}
