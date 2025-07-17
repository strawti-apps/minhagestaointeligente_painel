import 'package:get/get.dart';

import '../../infra/services/user_service.dart';
import '../auth/pages/login_email_page.dart';
import '../dashboard/dashboard_page.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    await Future.delayed(
      const Duration(milliseconds: 1200),
    );
    if (!UserService.loggedIn) {
      Get.offAllNamed(LoginEmailPage.route);
    } else {
      Get.offAllNamed(DashboardPage.route);
    }
  }
}