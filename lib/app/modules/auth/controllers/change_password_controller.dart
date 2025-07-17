import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infra/repositories/user_repository.dart';
import '../../../infra/services/auth_service.dart';
import '../../../shared/mixins/loader_manager.dart';
import '../../../shared/utils/app_snackbar.dart';

class ChangePasswordController extends GetxController with LoaderManager {
  late final UserRepository _userRepository;
  late final AuthService _authService;

  // Controllers dos campos
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // Controle de visibilidade das senhas
  bool showCurrentPassword = false;
  bool showNewPassword = false;
  bool showConfirmPassword = false;

  @override
  void onInit() {
    super.onInit();
    _userRepository = UserRepository();
    _authService = Get.find<AuthService>();
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  // Toggle visibilidade das senhas
  void toggleCurrentPasswordVisibility() {
    showCurrentPassword = !showCurrentPassword;
    update();
  }

  void toggleNewPasswordVisibility() {
    showNewPassword = !showNewPassword;
    update();
  }

  void toggleConfirmPasswordVisibility() {
    showConfirmPassword = !showConfirmPassword;
    update();
  }

  // Validações
  String? validateCurrentPassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Senha atual é obrigatória';
    }
    return null;
  }

  String? validateNewPassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nova senha é obrigatória';
    }
    if (value.length < 6) {
      return 'Nova senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Confirmação de senha é obrigatória';
    }
    if (value != newPasswordController.text) {
      return 'Senhas não coincidem';
    }
    return null;
  }

  // Alterar senha
  Future<void> changePassword() async {
    if (!formKey.currentState!.validate()) return;

    changeLoadingCreating(true);

    try {
      // Alterar senha no Supabase Auth
      final changePasswordResponse = await _userRepository.changeUserPassword(
        newPasswordController.text.trim(),
      );

      if (!changePasswordResponse.success) {
        AppSnackbar.to.error('Erro ao alterar senha: ${changePasswordResponse.message}');
        changeLoadingCreating(false);
        return;
      }

      // Marcar que a senha foi alterada e redirecionar
      await _authService.completePasswordChange();
      
      AppSnackbar.to.success('Senha alterada com sucesso!');
      
    } catch (e) {
      AppSnackbar.to.error('Erro inesperado ao alterar senha');
    } finally {
      changeLoadingCreating(false);
    }
  }


} 