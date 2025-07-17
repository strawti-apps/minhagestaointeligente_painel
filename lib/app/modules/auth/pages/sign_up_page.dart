import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/app_text_form_field.dart';
import '../controllers/sign_up_controller.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static const route = '/sign_up';

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
                child: GetBuilder<SignUpController>(
                  builder: (controller) {
                    return Form(
                      key: controller.signUpForm.formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Column(
                            children: [
                              Icon(
                                Icons.person_add,
                                size: 64,
                                color: Colors.blueAccent,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Criar Conta',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey[900],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          AppTextFormField(
                            controller:
                                controller.signUpForm.firstNameController,
                            enabled: !controller.isLoading,
                            title: 'Nome',
                            prefixIcon: const Icon(Icons.person),
                            radius: 14,
                            fillColor: Colors.grey[100],
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 20,
                            ),
                            validator: controller.signUpForm.validateFirstName,
                          ),
                          const SizedBox(height: 20),
                          AppTextFormField(
                            controller:
                                controller.signUpForm.lastNameController,
                            enabled: !controller.isLoading,
                            title: 'Sobrenome',
                            prefixIcon: const Icon(Icons.person_outline),
                            radius: 14,
                            fillColor: Colors.grey[100],
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 20,
                            ),
                            validator: controller.signUpForm.validateLastName,
                          ),
                          const SizedBox(height: 20),
                          AppTextFormField(
                            controller: controller.signUpForm.emailController,
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
                            validator: controller.signUpForm.validateEmail,
                          ),
                          const SizedBox(height: 20),
                          AppTextFormField(
                            controller:
                                controller.signUpForm.passwordController,
                            enabled: !controller.isLoading,
                            isPassword: true,
                            title: 'Senha',
                            prefixIcon: const Icon(Icons.lock),
                            radius: 14,
                            fillColor: Colors.grey[100],
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 20,
                            ),
                            validator: controller.signUpForm.validatePassword,
                          ),
                          const SizedBox(height: 28),
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  letterSpacing: 1,
                                ),
                              ),
                              onPressed:
                                  controller.isLoading
                                      ? null
                                      : () {
                                        if (controller.signUpForm.validate()) {
                                          // controller.signUp();
                                        }
                                      },
                              child:
                                  controller.isLoading
                                      ? const CircularProgressIndicator()
                                      : const Text('REGISTRAR'),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Já tem uma conta?',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(width: 4),
                              TextButton(
                                onPressed: () => Get.back(),
                                child: const Text(
                                  'Entrar',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
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
