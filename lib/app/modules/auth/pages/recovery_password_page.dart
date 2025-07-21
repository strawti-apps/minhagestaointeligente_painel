import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/app_button_default.dart';
import '../../../shared/widgets/app_text_form_field.dart';
import '../../../themes/app_colors.dart';
import '../controllers/recovery_password_controller.dart';

class RecoveryPasswordPage extends StatelessWidget {
  const RecoveryPasswordPage({super.key});

  static const route = '/recovery_password';

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
                width: isMobile ? double.infinity : 400,
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
                child: GetBuilder<RecoveryPasswordController>(
                  builder: (controller) {
                    return Form(
                      key: controller.emailForm.formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Column(
                            children: [
                              Icon(
                                Icons.lock_reset,
                                size: 64,
                                color: Colors.black,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Recuperar Senha',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey[900],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          Text(
                            'Informe o e-mail cadastrado para receber o link de recuperação.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blueGrey[700],
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 24),
                          AppTextFormField(
                            controller: controller.emailForm.emailController,
                            enabled: !controller.isLoading,
                            keyboardType: TextInputType.emailAddress,
                            title: 'E-mail',
                            prefixIcon: const Icon(Icons.email),
                            radius: 14,
                            fillColor: Colors.grey[100],
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 20,
                            ),
                            validator: controller.emailForm.validateEmail,
                          ),
                          const SizedBox(height: 28),
                          AppButtonDefault(
                            textColor: AppColors.background,
                            buttonColor: AppColors.primaryDark,
                            isLoading: controller.isLoading,
                            paddingVertical: 10,
                            onTap:
                                controller.isLoading
                                    ? null
                                    : () {
                                      if (controller.emailForm.validate()) {
                                        // controller.recoveryPassword();
                                      }
                                    },
                            text: 'ENVIAR LINK',
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () => Get.back(),
                                child: const Text(
                                  'Voltar para login',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
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
