import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minha_gestao_inteligente_painel/app/themes/app_colors.dart';

import '../../shared/navbar/navbar_desktop_widget.dart';
import 'educacao_controller.dart';
import 'widgets/alunos_list_widget.dart';
import 'widgets/escolas_list_widget.dart';
import 'widgets/professor_view_widget.dart';
import 'widgets/professores_list_widget.dart';

class EducacaoPage extends StatelessWidget {
  static const String route = '/escolas';
  const EducacaoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: const NavbarMobileWidget(),
      body: Row(
        children: [
          const NavbarDesktopWidget(),
          Expanded(
            child: GetBuilder<EducacaoController>(
              builder: (controller) {
                if (controller.professorVisualizando != null) {
                  return ProfessorViewWidget(
                    professor: controller.professorVisualizando!,
                  );
                }
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          TextButton(
                            onPressed: controller.irParaEscolas,
                            child: Text(
                              'Escolas e Creches',
                              style: TextStyle(
                                fontWeight:
                                    controller.subPage == 0
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                color: AppColors.textPrimary,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          TextButton(
                            onPressed: controller.irParaProfessores,
                            child: Text(
                              'Professores',
                              style: TextStyle(
                                fontWeight:
                                    controller.subPage == 1
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                color: AppColors.textPrimary,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          TextButton(
                            onPressed: controller.irParaAlunos,
                            child: Text(
                              'Alunos',
                              style: TextStyle(
                                fontWeight:
                                    controller.subPage == 2
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                fontSize: 16,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Builder(
                        builder: (_) {
                          if (controller.subPage == 0) {
                            return EscolasListWidget();
                          } else if (controller.subPage == 1) {
                            return ProfessoresListWidget();
                          } else {
                            return AlunosListWidget();
                          }
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
