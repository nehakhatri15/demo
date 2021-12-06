import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_demo/routes/app_pages.dart';
import 'package:login_demo/storage/user_storage.dart';
import 'package:login_demo/utils/validator.dart';

class LoginController extends GetxController with ValidationMixin {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  late TextEditingController emailController, passwordController;
  final hidePassword = true.obs;
  final storage = UserStorage();

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  updatePasswordView() {
    hidePassword.value = !hidePassword.value;
  }

  checkLogin() async {
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      String? emailValue = await storage.getEmail();
      String? passwordValue = await storage.getPwd();

      if (emailValue == emailController.text &&
          passwordValue == passwordController.text) {
        navigateToProfileView();
      } else {
        Get.snackbar("Error", "Please check email or password");
      }
    }
    loginFormKey.currentState!.save();
  }

  navigateToRegisterView() {
    Get.toNamed(Routes.REGISTER);
  }

  navigateToProfileView() {
    Get.offAllNamed(Routes.PROFILE);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
