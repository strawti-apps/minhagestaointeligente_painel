import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/app_button_default.dart';
import '../../../shared/widgets/app_text_form_field.dart';
import '../../../themes/app_colors.dart';
import '../educacao_controller.dart';

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
                  AppTextFormField(
                    controller: controller.alunoNomeController,
                    hintText: 'Nome do aluno',
                  ),
                  const SizedBox(height: 16),
                  AppTextFormField(
                    controller: controller.alunoTurmaController,
                    hintText: 'Turma',
                  ),
                  const SizedBox(height: 16),
                  AppTextFormField(
                    controller: controller.alunoResponsavelController,
                    hintText: 'Responsável',
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
                  : SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        children:
                            controller.filteredAlunos.map((aluno) {
                              return ConstrainedBox(
                                constraints: const BoxConstraints(
                                  minWidth: 320,
                                  maxWidth: 380,
                                ),
                                child: Card(
                                  elevation: 2,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                aluno.nome,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.edit,
                                                    color: Colors.blue,
                                                  ),
                                                  onPressed:
                                                      () => controller
                                                          .openEditAluno(aluno),
                                                  tooltip: 'Editar',
                                                ),
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ),
                                                  onPressed:
                                                      () => controller
                                                          .deleteAluno(aluno),
                                                  tooltip: 'Remover',
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Turma: ${aluno.turma}',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.deepPurple,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Responsável: ${aluno.responsavel}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 24),
                                        const Icon(
                                          Icons.badge_rounded,
                                          size: 32,
                                          color: Colors.blueAccent,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                      ),
                    ),
                  ),
        ),
      ],
    );
  }
}
