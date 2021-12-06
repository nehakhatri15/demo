import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text("Edit Profile"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Future.delayed(const Duration(milliseconds: 500), () {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            });
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.power_settings_new_sharp),
            onPressed: () {
              controller.logOutUser();
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Form(
              key: controller.profileFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Name",
                      prefixIcon: const Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.name,
                    controller: controller.nameController,
                    onSaved: (value) {
                      // controller.name = value!;
                    },
                    validator: (value) {
                      return controller.validateName(value!);
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Email",
                      prefixIcon: const Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    controller: controller.emailController,
                    onSaved: (value) {
                      // controller.email = value!;
                    },
                    validator: (value) {
                      return controller.validateEmail(value!);
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Mobile Number",
                      prefixIcon: SizedBox(
                        width: 100,
                        child: Row(
                          children: const [
                            SizedBox(width: 15),
                            Icon(Icons.phone_android),
                            Text(
                              " +91- ",
                              style: TextStyle(fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ),
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    controller: controller.mobileController,
                    validator: (value) {
                      return controller.validateMobile(value!);
                    },
                  ),
                  const SizedBox(height: 16),
                  Obx(() => TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: "Password",
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: Obx(() => IconButton(
                                  icon: Icon(
                                    controller.hidePassword.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    controller.updatePasswordView();
                                  },
                                ))),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: controller.hidePassword.value,
                        controller: controller.passwordController,
                        validator: (value) {
                          return controller.validatePassword(value!);
                        },
                      )),
                  const SizedBox(height: 16),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: context.width),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.deepPurpleAccent),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(14)),
                      ),
                      child: const Text(
                        "Save Changes",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      onPressed: () {
                        controller.updateUserInfo();
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
