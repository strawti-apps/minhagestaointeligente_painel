import 'package:get/get.dart';

import '../../../shared/mixins/loader_manager.dart';
import '../forms/email_form.dart';
import '../pages/login_password_page.dart';
import '../pages/sign_up_page.dart';

class LoginEmailController extends GetxController with LoaderManager {
  final emailForm = EmailForm();

  @override
  void onReady() {
    super.onReady();
    final email = Get.parameters['email'] ?? '';
    if (email.isNotEmpty) {
      emailForm.emailController.text = email;
    }
  }

  @override
  void dispose() {
    emailForm.dispose();
    super.dispose();
  }

  Future<void> verifyEmail() async {
    changeLoading(true);
    final email = emailForm.getEmail();
    final user = mockUsers.firstWhereOrNull((u) => u['email'] == email);
    changeLoading(false);

    if (user != null) {
      Get.toNamed(
        LoginPasswordPage.route,
        parameters: {'email': email, 'type': user['type']!},
      );
    } else {
      Get.toNamed(SignUpPage.route, parameters: {'email': email});
    }
  }

  void goToSignUpPage() {
    final email = emailForm.emailController.text;
    Get.toNamed(
      SignUpPage.route,
      parameters: {'email': email.trim().toLowerCase()},
    );
  }

  List<Map<String, String>> mockUsers = [
    {'email': 'professor@strawti.com', 'type': 'professor'},
    {'email': 'medico@strawti.com', 'type': 'medico'},
    {'email': 'admin@strawti.com', 'type': 'admin'},
  ];
}
