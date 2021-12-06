import 'package:get/get.dart';
import 'package:login_demo/modules/login/bindings/login_binding.dart';
import 'package:login_demo/modules/login/views/login_view.dart';
import 'package:login_demo/modules/profile/bindings/home_binding.dart';
import 'package:login_demo/modules/profile/views/profile_view.dart';
import 'package:login_demo/modules/register/bindings/register_binding.dart';
import 'package:login_demo/modules/register/views/register_view.dart';


part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const LANDING_PAGE = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () =>const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
  ];
}
