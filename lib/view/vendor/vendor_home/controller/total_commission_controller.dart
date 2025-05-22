import 'package:get/get.dart';

import '../../../../data/api_client/bace_client.dart';
import '../../../../data/api_client/end_point.dart';
import '../../../../data/local_database/local_data_base.dart';
import '../../../../data/utils/const_value.dart';
import '../model/total_commission_model.dart';

class TotalCommissionController extends GetxController {
  var isLoading = false.obs;
  var totalCommissionModel = TotalCommissionModel().obs;
  var totalCommissionList = <CommissionList>[].obs;
  var selectedYear = DateTime.now().year.obs;
  var selectedMonthIndex = 0.obs;

  Future<void> getTotalCommission({String? year}) async {
    isLoading.value = true;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': await LocalStorage.getData(key: accessToken),
      };
      final queryYear = year ?? selectedYear.value.toString();
      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(
          api: EndPoint.getTotalCommissionURL(year: queryYear),
          headers: headers,
        ),
      );
      if (responseBody != null && responseBody['success'] == true) {
        totalCommissionModel.value = TotalCommissionModel.fromJson(responseBody);
        totalCommissionList.value = totalCommissionModel.value.data?.items ?? [];
        selectedYear.value = int.parse(queryYear);
      }
    } catch (e) {
      print('get total commission error $e');
    } finally {
      isLoading.value = false;
    }
  }
  void updateYear(int year) {
    selectedYear.value = year;
    getTotalCommission(year: year.toString());
  }
}