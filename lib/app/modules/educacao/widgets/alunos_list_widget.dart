import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/app_button_default.dart';
import '../../../shared/widgets/app_text_form_field.dart';
import '../../../themes/app_colors.dart';
import '../educacao_controller.dart';
import 'aluno_card_widget.dart';

class AlunosListWidget extends StatelessWidget {
  const AlunosListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EducacaoController>();
    if (controller.creatingEditing == 'aluno') {
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
                    controller.isEditing ? 'Editar Aluno' : 'Novo Aluno',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),

                  // Nome do aluno
                  AppTextFormField(
                    controller: controller.alunoNomeController,
                    hintText: 'Nome do aluno',
                  ),
                  const SizedBox(height: 16),

                  // Turma
                  AppTextFormField(
                    controller: controller.alunoTurmaController,
                    hintText: 'Turma',
                  ),
                  const SizedBox(height: 16),

                  // Responsável
                  AppTextFormField(
                    controller: controller.alunoResponsavelController,
                    hintText: 'Responsável',
                  ),
                  const SizedBox(height: 16),

                  // Idade e Escola
                  Row(
                    children: [
                      Expanded(
                        child: AppTextFormField(
                          controller: controller.alunoIdadeController,
                          hintText: 'Idade',
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: AppTextFormField(
                          controller: controller.alunoEscolaController,
                          hintText: 'Escola',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Telefone e Imagem
                  Row(
                    children: [
                      Expanded(
                        child: AppTextFormField(
                          controller: controller.alunoTelefoneController,
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
                          controller: controller.alunoImagemController,
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
                                  ? controller.updateAluno
                                  : controller.createAluno,
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
                  hintText: 'Pesquisar Aluno',
                  prefixIcon: Icon(Icons.search),
                  optional: true,
                  onChanged: controller.searchAlunos,
                ),
              ),
              SizedBox(width: 40),
              AppButtonDefault(
                width: 120,
                usingJustPadding: false,
                onTap: controller.openCreateAluno,
                icon: Icons.add,
                text: 'Novo Aluno',
              ),
            ],
          ),
        ),
        Expanded(
          child:
              controller.filteredAlunos.isEmpty
                  ? const Center(child: Text('Nenhum aluno encontrado.'))
                  : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: controller.filteredAlunos.length,
                    itemBuilder: (context, index) {
                      final aluno = controller.filteredAlunos[index];
                      return AlunoCardWidget(
                        aluno: aluno,
                        controller: controller,
                      );
                    },
                  ),
        ),
      ],
    );
  }
}
