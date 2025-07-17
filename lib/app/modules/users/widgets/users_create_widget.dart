import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/app_text_form_field.dart';
import '../../../shared/widgets/expandable_dropdown_widget.dart';
import '../../../shared/widgets/app_button_default.dart';
import '../../../themes/app_colors.dart';
import '../users_controller.dart';

class UsersCreateWidget extends StatelessWidget {
  const UsersCreateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UsersController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  IconButton(
                    onPressed: () => controller.selectSubModule('users_list'),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CADASTRAR USUÁRIO',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Cadastre novos usuários no sistema com acesso completo',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Formulário
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: controller.createUserFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Campo Nome
                        AppTextFormField(
                          controller: controller.firstNameController,
                          enabled: !controller.isLoadingCreating,
                          title: 'Nome *',
                          hintText: 'Digite o nome',
                          prefixIcon: const Icon(Icons.person),
                          validator: controller.validateFirstName,
                        ),

                        const SizedBox(height: 20),

                        // Campo Sobrenome
                        AppTextFormField(
                          controller: controller.lastNameController,
                          enabled: !controller.isLoadingCreating,
                          title: 'Sobrenome',
                          hintText: 'Digite o sobrenome (opcional)',
                          prefixIcon: const Icon(Icons.person_outline),
                        ),

                        const SizedBox(height: 20),

                        // Campo Email
                        AppTextFormField(
                          controller: controller.emailController,
                          enabled: !controller.isLoadingCreating,
                          title: 'Email *',
                          hintText: 'Digite o email',
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: const Icon(Icons.email),
                          validator: controller.validateEmail,
                        ),

                        const SizedBox(height: 20),

                        // Dropdown Tipo de Usuário
                        ExpandableDropdownWidget<Map<String, String>>(
                          title: 'Tipo de Usuário *',
                          items: controller.roleOptions,
                          selectedItem: controller.roleOptions.firstWhere(
                            (role) => role['value'] == controller.selectedRole,
                          ),
                          onItemSelected: (role) {
                            if (role != null) {
                              controller.selectedRole = role['value']!;
                              controller.update();
                            }
                          },
                          getItemTitle: (role) => role['label']!,
                          getItemId: (role) => role['value']!,
                          hintText: 'Selecione o tipo de usuário',
                          searchHintText: 'Buscar tipo de usuário...',
                          prefixIcon: Icons.person,
                        ),

                        const SizedBox(height: 24),

                        // Info sobre senha
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.blue.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.blue.withValues(alpha: 0.1),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: Colors.blue.shade600,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'A senha padrão será: primeiras 3 letras do nome + "2025". Ex: João → "joa2025"',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.blue.shade700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Botão de criação
                        SizedBox(
                          width: double.infinity,
                          child: AppButtonDefault(
                            text: 'Cadastrar Usuário',
                            onTap: controller.isLoadingCreating 
                                ? null 
                                : () => controller.createUser(),
                            isLoading: controller.isLoadingCreating,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
} 