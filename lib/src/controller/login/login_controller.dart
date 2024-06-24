import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/src/services/auth_service/auth.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  final auth_controller = Get.put(Authentication());

  RxBool obsecure = true.obs;
  RxBool isLoading = false.obs;

  isvisible() {
    obsecure.value = !obsecure.value;
  }

  final email = TextEditingController();
  final password = TextEditingController();

  void loginUser(String email, String password, BuildContext context) async {
    isLoading.value = true;
    try {
      await auth_controller.loginUserwithEmailandPassword(
          email, password, context);
    } finally {
      isLoading.value = false;
    }
  }
}
