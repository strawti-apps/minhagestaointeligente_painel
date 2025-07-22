import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/navbar/navbar_desktop_widget.dart';
import '../../../../shared/navbar/navbar_mobile_widget.dart';
import '../../../../themes/app_colors.dart';
import '../controllers/alunos_controller.dart';
import '../widgets/aluno_widget.dart';

class AlunosPage extends StatelessWidget {
  static const route = '/professor/alunos';
  const AlunosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AlunosController());

    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const NavbarDesktopWidget(),
          Expanded(
            child: Column(
              children: [
                // Cabeçalho da página
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Text(
                        'Alunos',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      // Campo de busca
                      SizedBox(
                        width: 300,
                        child: TextField(
                          controller: controller.searchController,
                          onChanged: controller.searchAlunos,
                          decoration: InputDecoration(
                            hintText: 'Buscar por aluno...',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Botão de filtro por turma
                      PopupMenuButton<String>(
                        onSelected: controller.filterByTurma,
                        itemBuilder:
                            (context) => [
                              const PopupMenuItem(
                                value: 'todas',
                                child: Text('Todas as turmas'),
                              ),
                              const PopupMenuItem(
                                value: '1º Ano',
                                child: Text('1º Ano'),
                              ),
                              const PopupMenuItem(
                                value: '2º Ano',
                                child: Text('2º Ano'),
                              ),
                              const PopupMenuItem(
                                value: '3º Ano',
                                child: Text('3º Ano'),
                              ),
                              const PopupMenuItem(
                                value: '4º Ano',
                                child: Text('4º Ano'),
                              ),
                              const PopupMenuItem(
                                value: '5º Ano',
                                child: Text('5º Ano'),
                              ),
                            ],
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryDark,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.filter_list,
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Filtrar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Conteúdo principal
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    color: Colors.grey.shade50,
                    child: GetBuilder<AlunosController>(
                      builder: (controller) {
                        if (controller.filteredAlunos.isEmpty) {
                          return const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search_off,
                                  size: 64,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Nenhum aluno encontrado',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return SingleChildScrollView(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Wrap(
                              spacing: 16,
                              runSpacing: 16,
                              children:
                                  controller.filteredAlunos.map((aluno) {
                                    return AlunoWidget(
                                      alunoData: aluno,
                                      onTap:
                                          () => controller.showAlunoDetails(
                                            aluno,
                                          ),
                                    );
                                  }).toList(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const NavbarMobileWidget(),
    );
  }
}
