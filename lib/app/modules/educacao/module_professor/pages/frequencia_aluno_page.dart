import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/navbar/navbar_desktop_widget.dart';
import '../../../../themes/app_colors.dart';
import '../controllers/frequencia_aluno_controller.dart';
import '../widgets/frequencia_stats_widget.dart';
import '../widgets/frequencia_widget.dart';

class FrequenciaAlunoPage extends StatelessWidget {
  static const route = '/professor/frequencia_aluno';
  const FrequenciaAlunoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FrequenciaAlunoController());

    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const NavbarDesktopWidget(),
          Expanded(
            child: Container(
              color: AppColors.background,
              child: GetBuilder<FrequenciaAlunoController>(
                builder: (controller) {
                  return Column(
                    children: [
                      // Cabeçalho da página
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.card,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Controle de Frequência',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),

                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Campo de busca
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: 250,
                                    minWidth: 100,
                                  ),
                                  child: TextField(
                                    controller: controller.searchController,
                                    onChanged: controller.onSearchChanged,
                                    decoration: InputDecoration(
                                      hintText: 'Buscar aluno...',
                                      prefixIcon: const Icon(Icons.search),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 8,
                                          ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                // Filtro por turma
                                PopupMenuButton<String>(
                                  onSelected: controller.onFilterChanged,
                                  itemBuilder:
                                      (context) =>
                                          controller.turmas
                                              .map(
                                                (turma) => PopupMenuItem(
                                                  value: turma,
                                                  child: Text(turma),
                                                ),
                                              )
                                              .toList(),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.textSecondary,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          controller.selectedFilter,
                                          style: TextStyle(
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        const Icon(Icons.arrow_drop_down),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Conteúdo principal
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              // Widget de estatísticas
                              FrequenciaStatsWidget(
                                estatisticas: controller.getEstatisticas(),
                              ),
                              const SizedBox(height: 20),

                              // Lista de alunos
                              Expanded(
                                child:
                                    controller.filteredAlunos.isEmpty
                                        ? Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.people_outline,
                                                size: 64,
                                                color: AppColors.textSecondary,
                                              ),
                                              const SizedBox(height: 16),
                                              Text(
                                                'Nenhum aluno encontrado',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color:
                                                      AppColors.textSecondary,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                        : SingleChildScrollView(
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Wrap(
                                              spacing: 16,
                                              runSpacing: 16,
                                              children:
                                                  controller.filteredAlunos
                                                      .asMap()
                                                      .entries
                                                      .map((entry) {
                                                        final index = entry.key;
                                                        final aluno =
                                                            entry.value;

                                                        return FrequenciaWidget(
                                                          alunoData: aluno,
                                                          onTap:
                                                              () => controller
                                                                  .showAlunoDetails(
                                                                    aluno,
                                                                  ),
                                                          onTogglePresenca:
                                                              () => controller
                                                                  .togglePresenca(
                                                                    index,
                                                                  ),
                                                        );
                                                      })
                                                      .toList(),
                                            ),
                                          ),
                                        ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
