import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_demo/routes/app_pages.dart';
import 'package:login_demo/storage/user_storage.dart';
import 'package:login_demo/utils/validator.dart';

class RegisterController extends GetxController with ValidationMixin {
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  late TextEditingController nameController,
      emailController,
      mobileController,
      passwordController;
  final hidePassword = true.obs;
  final storage = UserStorage();

  @override
  void onInit() {
    super.onInit();
    nameController = new TextEditingController();
    emailController = new TextEditingController();
    mobileController = new TextEditingController();
    passwordController = new TextEditingController();
  }

  void updatePasswordView() {
     hidePassword.value = !hidePassword.value;
   }

  checkRegister() async{
    final isValid = registerFormKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      String? userEmail = await storage.getEmail();
      if (userEmail == emailController.text) {
        Get.snackbar("Alert", "Email already exists");
      } else {
        storage.setName(nameController.text);
        storage.setEmail(emailController.text);
        storage.setPhone('+91- '+mobileController.text);
        storage.setPwd(passwordController.text);
        Get.snackbar("Alert", "User register successfully");
        Future.delayed(const Duration(seconds: 2))
            .whenComplete(() => Get.offAllNamed(Routes.PROFILE));
      }
    }
    registerFormKey.currentState!.save();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }
}
