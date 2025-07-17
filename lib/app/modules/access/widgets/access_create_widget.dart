import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infra/models/user_model.dart';
import '../../../infra/models/class_model.dart';
import '../../../shared/widgets/expandable_dropdown_widget.dart';
import '../../../shared/widgets/app_button_default.dart';
import '../../../themes/app_colors.dart';
import '../access_controller.dart';
import 'selected_user_card_widget.dart';

class AccessCreateWidget extends StatelessWidget {
  const AccessCreateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccessController>(
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
                    onPressed: () => controller.selectSubModule('list'),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CADASTRAR ACESSOS',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Adicione usuários a uma turma para dar acesso ao curso',
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Dropdown de Usuários
                      ExpandableDropdownWidget<UserModel>(
                        title: 'Usuário (Aluno ou Professor) *',
                        hintText: 'Selecione um usuário',
                        searchHintText: 'Buscar usuário...',
                        prefixIcon: Icons.person,
                        selectedItem: null, // Sempre null pois não queremos mostrar selecionado
                        items: controller.users
                            .where((user) => !controller.selectedUsers.any((selected) => selected.id == user.id))
                            .toList(),
                        getItemTitle: (user) => '${user.firstName} ${user.lastName ?? ''} (${user.role == 'teacher' ? 'Professor' : 'Aluno'})',
                        getItemId: (user) => user.id.toString(),
                        onItemSelected: (user) {
                          controller.addSelectedUser(user);
                        },
                        isLoading: controller.users.isEmpty,
                        emptyMessage: 'Nenhum usuário disponível',
                      ),

                      const SizedBox(height: 20),

                      // Lista de usuários selecionados
                      if (controller.selectedUsers.isNotEmpty) ...[
                        Text(
                          'Usuários selecionados:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        
                        // Grid de cards de usuários selecionados
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: controller.selectedUsers.map((user) {
                            return SelectedUserCardWidget(
                              user: user,
                              onRemove: () => controller.removeSelectedUser(user),
                            );
                          }).toList(),
                        ),
                        
                        const SizedBox(height: 20),
                      ],

                      // Dropdown de Turmas
                      ExpandableDropdownWidget<ClassModel>(
                        title: 'Turma *',
                        hintText: 'Selecione uma turma',
                        searchHintText: 'Buscar turma...',
                        prefixIcon: Icons.class_,
                        selectedItem: controller.selectedClass,
                        items: controller.classes,
                        getItemTitle: (classModel) => classModel.title,
                        getItemId: (classModel) => classModel.id.toString(),
                        onItemSelected: (classModel) {
                          controller.selectClass(classModel);
                        },
                        isLoading: controller.classes.isEmpty,
                        emptyMessage: 'Nenhuma turma encontrada',
                      ),

                      const SizedBox(height: 32),

                      // Botão de criação
                      SizedBox(
                        width: double.infinity,
                        child: AppButtonDefault(
                          text: 'Cadastrar',
                          onTap: controller.isLoadingCreating 
                              ? null 
                              : () => controller.createAccess(),
                          isLoading: controller.isLoadingCreating,
                        ),
                      ),
                    ],
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