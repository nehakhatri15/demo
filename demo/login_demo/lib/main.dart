import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_demo/routes/app_pages.dart';
import 'package:login_demo/storage/user_storage.dart';
import 'package:login_demo/utils/them_data.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isRegistered = await UserStorage().isRegistered();
  runApp(
    GetMaterialApp(
      title: "Demo App",
      debugShowCheckedModeBanner: false,
      initialRoute: isRegistered ? Routes.PROFILE : AppPages.LANDING_PAGE,
      getPages: AppPages.routes,
      theme: Themes.light,
      darkTheme: Themes.dark,
    ),
  );
}
