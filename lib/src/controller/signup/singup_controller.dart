import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/src/services/auth_service/auth.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();
  final auth_controller = Get.put(Authentication());
  RxBool obsecure = true.obs;
  RxBool isLoading = false.obs;

  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final phoneNo = TextEditingController();

  isvisible() {
    obsecure.value = !obsecure.value;
  }

  void registerUser(String email, String password, String name, String phoneNo,
      context) async {
    isLoading.value = true;
    try {
      await auth_controller.createUserwithEmailandPassword(
          email, password, name, phoneNo, context);
    } finally {
      isLoading.value = false;
    }
  }
}
