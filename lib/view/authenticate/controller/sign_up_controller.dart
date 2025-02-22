import 'package:get/get.dart';

class SignUpController extends GetxController{
  // Controller to handle checkbox state using GetX
  var isChecked = false.obs;
  var selectedRole = 'User'.obs;
  // Visibility state for password fields
  RxBool isPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;
  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }
  void changeRole(String role) {
    selectedRole.value = role;
  }
}