import 'package:get/get.dart';

import 'controllers/login_email_controller.dart';
import 'controllers/login_password_controller.dart';
import 'controllers/recovery_password_controller.dart';
import 'controllers/sign_up_controller.dart';
import 'controllers/change_password_controller.dart';
import 'pages/login_email_page.dart';
import 'pages/login_password_page.dart';
import 'pages/recovery_password_page.dart';
import 'pages/sign_up_page.dart';
import 'pages/change_password_page.dart';

class AuthRoutes {
  static List<GetPage> routes = [
    GetPage(
      name: LoginEmailPage.route,
      page: () => const LoginEmailPage(),
      binding: BindingsBuilder(() {
        Get.put(LoginEmailController());
      }),
    ),
    GetPage(
      name: LoginPasswordPage.route,
      page: () => const LoginPasswordPage(),
      binding: BindingsBuilder(() {
        Get.put(LoginPasswordController());
      }),
    ),
    GetPage(
      name: SignUpPage.route,
      page: () => const SignUpPage(),
      binding: BindingsBuilder(() {
        Get.put(SignUpController());
      }),
    ),
    GetPage(
      name: RecoveryPasswordPage.route,
      page: () => const RecoveryPasswordPage(),
      binding: BindingsBuilder(() {
        Get.put(RecoveryPasswordController());
      }),
    ),
    GetPage(
      name: ChangePasswordPage.route,
      page: () => const ChangePasswordPage(),
      binding: BindingsBuilder(() {
        Get.put(ChangePasswordController());
      }),
    ),
  ];
}
