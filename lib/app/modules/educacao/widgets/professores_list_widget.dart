import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/app_button_default.dart';
import '../../../shared/widgets/app_text_form_field.dart';
import '../../../themes/app_colors.dart';
import '../educacao_controller.dart';
import 'professor_card_widget.dart';

class ProfessoresListWidget extends StatelessWidget {
  const ProfessoresListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EducacaoController>();
    if (controller.creatingEditing == 'professor') {
      return Center(
        child: Card(
          elevation: 0.5,
          color: AppColors.card,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    controller.isEditing
                        ? 'Editar Professor'
                        : 'Novo Professor',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),

                  // Nome do professor
                  AppTextFormField(
                    controller: controller.professorNomeController,
                    hintText: 'Nome do professor',
                  ),
                  const SizedBox(height: 16),

                  // Disciplina
                  AppTextFormField(
                    controller: controller.professorDisciplinaController,
                    hintText: 'Disciplina',
                  ),
                  const SizedBox(height: 16),

                  // Email
                  AppTextFormField(
                    controller: controller.professorEmailController,
                    hintText: 'Email',
                  ),
                  const SizedBox(height: 16),

                  // Telefone e Escola
                  Row(
                    children: [
                      Expanded(
                        child: AppTextFormField(
                          controller: controller.professorTelefoneController,
                          hintText: 'Telefone',
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            TelefoneInputFormatter(),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: AppTextFormField(
                          controller: controller.professorEscolaController,
                          hintText: 'Escola',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Especialidade e Imagem
                  Row(
                    children: [
                      Expanded(
                        child: AppTextFormField(
                          controller:
                              controller.professorEspecialidadeController,
                          hintText: 'Especialidade',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: AppTextFormField(
                          controller: controller.professorImagemController,
                          hintText: 'URL da imagem (opcional)',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: AppButtonDefault(
                          text: 'Cancelar',
                          onTap: controller.closeForm,
                          borderColor: AppColors.textPrimary,
                          buttonColor: AppColors.card,
                          textColor: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: AppButtonDefault(
                          text: controller.isEditing ? 'Salvar' : 'Criar',
                          onTap:
                              controller.isEditing
                                  ? controller.updateProfessor
                                  : controller.createProfessor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AppTextFormField(
                  hintText: 'Pesquisar Professor',
                  prefixIcon: Icon(Icons.search),
                  onChanged: controller.searchProfessores,
                  optional: true,
                ),
              ),
              SizedBox(width: 40),
              AppButtonDefault(
                width: 150,
                usingJustPadding: false,
                onTap: controller.openCreateProfessor,
                icon: Icons.add,
                text: 'Novo Professor',
              ),
            ],
          ),
        ),
        Expanded(
          child:
              controller.filteredProfessores.isEmpty
                  ? const Center(child: Text('Nenhum professor encontrado.'))
                  : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: controller.filteredProfessores.length,
                    itemBuilder: (context, index) {
                      final prof = controller.filteredProfessores[index];
                      return ProfessorCardWidget(
                        professor: prof,
                        controller: controller,
                      );
                    },
                  ),
        ),
      ],
    );
  }
}
