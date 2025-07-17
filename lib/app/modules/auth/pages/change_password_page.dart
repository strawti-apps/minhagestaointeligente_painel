import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/app_text_form_field.dart';
import '../../../shared/widgets/app_button_default.dart';
import '../../../themes/app_colors.dart';
import '../controllers/change_password_controller.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  static const String route = '/change-password';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;
          return Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 0,
                vertical: 32,
              ),
              child: Container(
                width: isMobile ? double.infinity : 500,
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: GetBuilder<ChangePasswordController>(
                  builder: (controller) {
                    return Form(
                      key: controller.formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Header com ícone e título
                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.orange.withValues(alpha: 0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.lock_reset,
                                  size: 48,
                                  color: Colors.orange.shade600,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Alterar Senha',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Por segurança, você precisa alterar sua senha antes de continuar',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.textSecondary,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 32),

                          // Info sobre senha atual
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.blue.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.blue.withValues(alpha: 0.1),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  color: Colors.blue.shade600,
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Sua senha atual é composta pelas 3 primeiras letras do seu nome + "2025"',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.blue.shade700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Campo Senha Atual
                          AppTextFormField(
                            controller: controller.currentPasswordController,
                            enabled: !controller.isLoadingCreating,
                            title: 'Senha Atual',
                            hintText: 'Digite sua senha atual',
                            isPassword: !controller.showCurrentPassword,
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              onPressed:
                                  controller.toggleCurrentPasswordVisibility,
                              icon: Icon(
                                controller.showCurrentPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                            validator: controller.validateCurrentPassword,
                          ),

                          const SizedBox(height: 20),

                          // Campo Nova Senha
                          AppTextFormField(
                            controller: controller.newPasswordController,
                            enabled: !controller.isLoadingCreating,
                            title: 'Nova Senha',
                            hintText:
                                'Digite sua nova senha (mín. 6 caracteres)',
                            isPassword: !controller.showNewPassword,
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: controller.toggleNewPasswordVisibility,
                              icon: Icon(
                                controller.showNewPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                            validator: controller.validateNewPassword,
                          ),

                          const SizedBox(height: 20),

                          // Campo Confirmar Senha
                          AppTextFormField(
                            controller: controller.confirmPasswordController,
                            enabled: !controller.isLoadingCreating,
                            title: 'Confirmar Nova Senha',
                            hintText: 'Digite novamente sua nova senha',
                            isPassword: !controller.showConfirmPassword,
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed:
                                  controller.toggleConfirmPasswordVisibility,
                              icon: Icon(
                                controller.showConfirmPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                            validator: controller.validateConfirmPassword,
                          ),

                          const SizedBox(height: 32),

                          // Botão Alterar Senha
                          AppButtonDefault(
                            text: 'Alterar Senha',
                            onTap:
                                controller.isLoadingCreating
                                    ? null
                                    : controller.changePassword,
                            isLoading: controller.isLoadingCreating,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
