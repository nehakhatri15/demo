import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_demo/routes/app_pages.dart';
import 'package:login_demo/storage/user_storage.dart';
import 'package:login_demo/utils/validator.dart';

class ProfileController extends GetxController with ValidationMixin {
  final GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();

  late TextEditingController emailController,
      passwordController,
      nameController,
      mobileController;
  var name = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;
  var password = ''.obs;
  final hidePassword = true.obs;
  final storage = UserStorage();

  @override
  void onInit() {
    super.onInit();
    nameController =  TextEditingController();
    emailController =  TextEditingController();
    mobileController =  TextEditingController();
    passwordController =  TextEditingController();
    getInfoFromDb();
  }

  getInfoFromDb() async{
    nameController.text = await storage.getName();
    emailController.text = await storage.getEmail();
    passwordController.text = await storage.getPwd();
    String mobileNumber = await storage.getPhone();
    print('mobileNumber $mobileNumber');
    if (mobileNumber.contains('+91- ')) {
      mobileNumber = mobileNumber.replaceAll('+91- ', '');
      mobileController.text = mobileNumber;
    } else {
      mobileController.text = mobileNumber;
    }
  }

  void updatePasswordView() {
    hidePassword.value = !hidePassword.value;
  }

  logOutUser() {
    storage.clearCache();
    Get.snackbar("Alert", "You have successfully Logout");
    Future.delayed(const Duration(seconds: 2))
        .whenComplete(() => Get.offAllNamed(Routes.LOGIN));
  }

  updateUserInfo() {
    final isValid = profileFormKey.currentState!.validate();
    if (!isValid) {
      Get.snackbar("Error", "Please check input fields");
      return;
    } else {
      storage.setName(nameController.text);
      storage.setEmail(emailController.text);
      storage.setPhone( '+91- ' + mobileController.text);
      storage.setPwd(passwordController.text);
      Get.snackbar("Alert", "User update successfully");
    }
    profileFormKey.currentState!.save();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    passwordController.dispose();
  }
}
