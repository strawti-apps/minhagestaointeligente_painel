import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../shared/mixins/loader_manager.dart';
import '../forms/password_form.dart';
import '../pages/recovery_password_page.dart';

const mockUsers = [
  {
    'email': 'professor@strawti.com',
    'password': 'professor123',
    'type': 'professor',
  },
  {'email': 'medico@strawti.com', 'password': 'medico123', 'type': 'medico'},
  {'email': 'admin@strawti.com', 'password': 'admin123', 'type': 'admin'},
];

class LoginPasswordController extends GetxController with LoaderManager {
  final passwordForm = PasswordForm();
  final box = GetStorage();

  bool obscurePassword = true;

  @override
  void onReady() {
    super.onReady();
    final email = Get.parameters['email'] ?? '';
    if (email.isEmpty) {
      Get.back();
    }
  }

  @override
  void dispose() {
    passwordForm.dispose();
    super.dispose();
  }

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    update();
  }

  Future<void> signIn() async {
    if (!passwordForm.validate()) return;

    changeLoading(true);

    final email = Get.parameters['email'] ?? '';
    final password = passwordForm.getPassword();
    final user = mockUsers.firstWhereOrNull(
      (u) => u['email'] == email && u['password'] == password,
    );
    changeLoading(false);

    if (user == null) {
      Get.snackbar(
        'Erro',
        'E-mail ou senha inválidos',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    } else {
      // Salva o tipo de acesso e email para a dashboard
      box.write('user_type', user['type']);
      box.write('user_email', user['email']);
      // Navega para a dashboard passando os parâmetros
      Get.offAllNamed(
        '/dashboard',
        parameters: {'type': user['type']!, 'email': user['email']!},
      );
    }
  }

  void goToRecoveryPassword() {
    final email = Get.parameters['email'] ?? '';
    Get.toNamed(RecoveryPasswordPage.route, parameters: {'email': email});
  }
}
