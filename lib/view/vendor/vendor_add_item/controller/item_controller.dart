import 'package:get/get.dart';

class ItemController extends GetxController {
  var selectedDay = "Tuesday".obs;
  var selectedTab = 'onGoing'.obs;

  void selectDay(String day) {
    selectedDay.value = day;
  }

  void switchTab(newData){
    selectedTab.value = newData;
  }

}