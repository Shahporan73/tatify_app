import 'package:get/get.dart';

import '../../../../data/api_client/bace_client.dart';
import '../../../../data/api_client/end_point.dart';
import '../../../../data/local_database/local_data_base.dart';
import '../../../../data/utils/const_value.dart';
import '../../../user/user_booking/model/get_book_redeem_model.dart';

class VendorBookingController extends GetxController{
  var isLoading = false.obs;

  var getBookRedeemModel = GetBookRedeemModel().obs;
  var getBookRedeemList = <BookingList>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCompleteBookRedeem();
  }

  Future<void> onRefresh() async => getCompleteBookRedeem();

  Future<void> getCompleteBookRedeem() async {
    isLoading.value = true;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "Authorization": LocalStorage.getData(key: accessToken),
      };
      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(
          api: EndPoint.getRedeemURL(),
          headers: headers,
        ),
      );
      if (responseBody != null && responseBody['success'] == true) {
        getBookRedeemModel.value = GetBookRedeemModel.fromJson(responseBody);
        final dataList = getBookRedeemModel.value.data?.data;

        if (dataList != null && dataList.any((e) => e.vendorRedeem?.redeemStatus == 'redeemed')) {
          getBookRedeemList.value = dataList;
          print('booking complete ${getBookRedeemList.length}');
        }
      }
    } catch (e) {
      print('get book redeem error $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getFilteredBookRedeem(DateTime selectedDate) async {
    isLoading.value = true;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "Authorization": LocalStorage.getData(key: accessToken),
      };

      final responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(
          api: EndPoint.getRedeemURL(),
          headers: headers,
        ),
      );

      if (responseBody != null && responseBody['success'] == true) {
        getBookRedeemModel.value = GetBookRedeemModel.fromJson(responseBody);
        final dataList = getBookRedeemModel.value.data?.data;

        if (dataList != null) {
          final filteredList = dataList.where((e) {
            final redeemDate = e.vendorRedeem?.redeemDate;
            if (redeemDate == null || e.vendorRedeem?.redeemStatus != 'redeemed') {
              return false;
            }
            final parsedDate = DateTime.tryParse(redeemDate.toString());
            return parsedDate != null &&
                parsedDate.year == selectedDate.year &&
                parsedDate.month == selectedDate.month &&
                parsedDate.day == selectedDate.day;
          }).toList();

          getBookRedeemList.value = filteredList;
          print('filtered bookings ${getBookRedeemList.length}');
        }
      }
    } catch (e) {
      print('get filtered book redeem error $e');
    } finally {
      isLoading.value = false;
    }
  }

}