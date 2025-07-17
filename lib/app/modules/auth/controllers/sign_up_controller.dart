import 'package:get/get.dart';

import '../../../shared/mixins/loader_manager.dart';
import '../forms/sign_up_form.dart';

class SignUpController extends GetxController with LoaderManager {
  // final authRepository = AuthRepository();
  final signUpForm = SignUpForm();

  @override
  void onReady() {
    super.onReady();
    final email = Get.parameters['email'] ?? '';
    if (email.isNotEmpty) {
      signUpForm.emailController.text = email;
    }
  }

  @override
  void dispose() {
    signUpForm.dispose();
    super.dispose();
  }

  // Future<void> signUp() async {
  //   if (!signUpForm.validate()) return;

  //   changeLoading(true);

  //   final user = UserModel(
  //     authUserId: '',
  //     firstName: signUpForm.getFirstName(),
  //     lastName: signUpForm.getLastName(),
  //     email: signUpForm.getEmail(),
  //     role: 'student',
  //   );

  //   final password = signUpForm.getPassword();
  //   final response = await authRepository.signUp(user, password);

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
  //       'Conta criada com sucesso! Verifique seu email para confirmar.',
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Get.theme.colorScheme.primary,
  //       colorText: Get.theme.colorScheme.onPrimary,
  //     );
  //     Get.back();
  //   }
  // }
}
