import 'package:get/get.dart';
import 'package:tatify_app/view/vendor/vendor_home/model/net_income_model.dart';

import '../../../../data/api_client/bace_client.dart';
import '../../../../data/api_client/end_point.dart';
import '../../../../data/local_database/local_data_base.dart';
import '../../../../data/utils/const_value.dart';

class NetIncomeController extends GetxController {
  var isLoading = false.obs;
  var netIncomeModel = NetIncomeModel().obs;
  var netIncomeList = <NetIncomeList>[].obs;

  var selectedYear = DateTime.now().year.obs;

  @override
  void onInit() {
    super.onInit();
    getNetIncome();
  }

  Future<void> getNetIncome({String? month, int? year}) async {
    isLoading.value = true;
    try {
      final String targetMonth = month ?? '${year ?? selectedYear.value}-01';
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "Authorization": await LocalStorage.getData(key: accessToken),
      };
      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(
          api: EndPoint.netIncomeURL(month: targetMonth),
          headers: headers,
        ),
      );
      if (responseBody != null && responseBody['success'] == true) {
        netIncomeModel.value = NetIncomeModel.fromJson(responseBody);
        netIncomeList.value = netIncomeModel.value.data?.items ?? [];
      }
    } catch (e) {
      print('get net income error $e');
    } finally {
      isLoading.value = false;
    }
  }

  void updateYear(int year) {
    selectedYear.value = year;
    getNetIncome(year: year);
  }

}
