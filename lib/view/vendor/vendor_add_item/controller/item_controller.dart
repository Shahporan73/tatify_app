import 'package:get/get.dart';

class ItemController extends GetxController {
  var selectedDay = "Tuesday".obs;
  var selectedTab = 'onGoing'.obs;
  var selectedDays = <String>[].obs;


  void switchTab(newData){
    selectedTab.value = newData;
  }

  void selectDay(String day) {
    if (day == "7 days") {
      selectedDays.value = ["7 days"]; // Reset and select only "7 days"
    } else {
      if (selectedDays.contains("7 days")) {
        selectedDays.clear(); // Remove "7 days" if other days are selected
      }
      if (selectedDays.contains(day)) {
        selectedDays.remove(day); // Deselect if already selected
      } else {
        selectedDays.add(day); // Select the new day
      }
    }
  }

}