import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tatify_app/view/authenticate/view/sign_in_screen.dart';
import 'package:tatify_app/view/vendor/payment/views/payment_success_screen.dart';
import 'package:tatify_app/view/vendor/vendor_home/views/vendor_home_dashboard.dart';

import '../../../../data/api_client/bace_client.dart';
import '../../../../data/api_client/end_point.dart';
import '../../../../data/local_database/local_data_base.dart';
import '../../../../data/utils/const_value.dart';
import '../views/payment_webview_screen.dart';

class PaymentController extends GetxController {
  var isLoading = false.obs;

  /*var isSelectLoading = false.obs;
  var subscriptionModel = SubscriptionModel().obs;
  var subscriptionList = <SubscriptionList>[].obs;

  var currentPage = 1.obs;
  var totalPages = 1.obs;
  var isMoreLoading = false.obs;*/

/*  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getSubscription();
  }

  Future<void> getSubscription({bool isLoadMore = false}) async {
    if (isLoadMore) {
      isMoreLoading(true);
    } else {
      isLoading(true);
      subscriptionList.clear();
      currentPage.value = 1; // Reset to first page
    }

    try {
      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: "${ApiUrl.subscriptionURl}?page=${currentPage.value}"),
      );

      if (responseBody['success'] == true) {
        var model = SubscriptionModel.fromJson(responseBody);
        subscriptionModel.value = model;
        if (isLoadMore) {
          subscriptionList.addAll(model.data?.data ?? []);
        } else {
          subscriptionList.value = model.data?.data ?? [];
        }
        totalPages.value = model.data?.meta?.totalPage ?? 1;
      } else {
        throw 'Failed to load data: ${responseBody['message']}';
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
      isMoreLoading(false);
    }
  }

  void loadMore() {
    if (currentPage.value < totalPages.value && !isMoreLoading.value) {
      currentPage.value++;
      getSubscription(isLoadMore: true);
    }
  }*/

  Future<void> onCheckOutPayment() async {
    isLoading(true);
    try {

      final Uri url = Uri.parse(EndPoint.paymentURL);

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': LocalStorage.getData(key: accessToken),
      };

      // Map<String, dynamic> body = {
      //   "amount": 327,
      //   "currency": "eur"
      // };

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
      } else {
        print('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print("payment error: $e");
    } finally {
      isLoading(false);
    }
  }



  paymentResults({required String finishUrl}) async {
    isLoading(true);
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      final response = await http.get(Uri.parse(finishUrl), headers: headers);

      print("Response : ${response.statusCode}");
      if (response.statusCode == 200) {
        dynamic responseBody = jsonDecode(response.body);

        print("Response Body: $responseBody");
        if (responseBody != null && responseBody["success"] == true) {
          print("Payment Success");

          // Ensure navigation happens after the UI rebuilds
          Future.delayed(Duration(milliseconds: 500), () {
            Get.offAll(() => PaymentSuccessScreen(
                  title: 'Your Payment is Success',
                  subTitle:
                      'Thank you for connecting with us and for placing your trust in us',
                  onTap: () {
                    Get.offAll(() => VendorHomeDashboard());
                  },
                ));
          });
        } else {
          print("Payment Failed");
          Get.rawSnackbar(
            message: "Payment Failed",
          );
          if( LocalStorage.removeData(key: accessToken) != null) {
            LocalStorage.removeData(key: accessToken);
          }
          // Ensure that even on failure, navigation works correctly
          Future.delayed(Duration(milliseconds: 500), () {
            Get.offAll(() => SignInScreen());
          });
        }
      } else {
        throw 'Request failed with status: ${response.statusCode}';
      }
    } catch (e) {
      print("Error processing payment: $e");
    } finally {
      isLoading(false);
    }
  }

}
