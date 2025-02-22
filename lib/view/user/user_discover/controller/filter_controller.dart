import 'package:get/get.dart';

class FilterController extends GetxController{
  var selectedDay = "Today".obs;

  void selectDay(String day) {
    selectedDay.value = day;
  }
}