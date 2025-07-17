import 'package:get/get.dart';

import '../../../shared/mixins/loader_manager.dart';
import '../forms/email_form.dart';

class RecoveryPasswordController extends GetxController with LoaderManager {
  // final authRepository = AuthRepository();
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

  // Future<void> recoveryPassword() async {
  //   if (!emailForm.validate()) return;

  //   changeLoading(true);

  //   final email = emailForm.getEmail();
  //   final response = await authRepository.recoveryPassword(email);

  //   changeLoading(false);

  //   if (response.error || response.data != true) {
  //     Get.snackbar(
  //       'Erro',
  //       response.message,
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Get.theme.colorScheme.error,
  //       colorText: Get.theme.colorScheme.onError,
  //     );
  //   } else {
  //     Get.snackbar(
  //       'Sucesso',
  //       'Email de recuperação enviado! Verifique sua caixa de entrada.',
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Get.theme.colorScheme.primary,
  //       colorText: Get.theme.colorScheme.onPrimary,
  //     );
  //     Get.back();
  //   }
  // }
}
