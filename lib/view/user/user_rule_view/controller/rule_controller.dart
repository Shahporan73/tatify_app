import 'package:get/get.dart';

import '../../../../data/api_client/bace_client.dart';
import '../../../../data/api_client/end_point.dart';
import '../../../../data/local_database/local_data_base.dart';
import '../../../../data/utils/const_value.dart';

class RuleController extends GetxController{
  var isLoading = false.obs;
  var privacyPolicy = ''.obs;
  var termsAndCondition = ''.obs;
  var aboutUs = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPrivacy();
    getTermsAndCondition();
    getAboutUs();
  }

  Future<void> getPrivacy() async {
    isLoading.value = true;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': await LocalStorage.getData(key: accessToken),
      };

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(
          api: EndPoint.privacyPolicyURL,
          headers: headers,
        ),
      );

      if (responseBody != null && responseBody['success'] == true) {
        privacyPolicy.value = responseBody['data']['body'] ?? '';
      }
    } catch (e) {
      print('get privacy policy error $e');
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> getTermsAndCondition() async {
    isLoading.value = true;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': await LocalStorage.getData(key: accessToken),
      };

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(
          api: EndPoint.termsAndConditionURL,
          headers: headers,
        ),
      );

      if (responseBody != null && responseBody['success'] == true) {
        termsAndCondition.value = responseBody['data']['body'] ?? '';
      }
    } catch (e) {
      print('get terms and condition error $e');
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> getAboutUs() async {
    isLoading.value = true;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': await LocalStorage.getData(key: accessToken),
      };

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(
          api: EndPoint.aboutUsURL,
          headers: headers,
        ),
      );

      if (responseBody != null && responseBody['success'] == true) {
        aboutUs.value = responseBody['data']['body'] ?? '';
      }
    } catch (e) {
      print('get about us error $e');
    } finally {
      isLoading.value = false;
    }
  }



}