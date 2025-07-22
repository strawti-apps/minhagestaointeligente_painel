import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minha_gestao_inteligente_painel/app/themes/app_colors.dart';

import '../../../../shared/navbar/navbar_desktop_widget.dart';
import '../controllers/boletins_controller.dart';
import '../widgets/boletim_stats_widget.dart';
import '../widgets/boletim_widget.dart';

class BoletinsPage extends StatelessWidget {
  static const route = '/professor/boletins';
  const BoletinsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BoletinsController());

    return Scaffold(
      body: Row(
        children: [
          const NavbarDesktopWidget(),
          Expanded(
            child: Column(
              children: [
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
                        'Boletins Escolares',
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
                          onChanged: controller.searchBoletins,
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
                      // Botão de filtro
                      PopupMenuButton<String>(
                        onSelected: controller.filterByMedia,
                        itemBuilder:
                            (context) => [
                              const PopupMenuItem(
                                value: 'todos',
                                child: Text('Todos os alunos'),
                              ),
                              const PopupMenuItem(
                                value: 'excelente',
                                child: Text('Excelente (9.0+)'),
                              ),
                              const PopupMenuItem(
                                value: 'bom',
                                child: Text('Bom (7.0-8.9)'),
                              ),
                              const PopupMenuItem(
                                value: 'regular',
                                child: Text('Regular (6.0-6.9)'),
                              ),
                              const PopupMenuItem(
                                value: 'baixo',
                                child: Text('Baixo (<6.0)'),
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
                    child: GetBuilder<BoletinsController>(
                      builder: (controller) {
                        if (controller.filteredBoletins.isEmpty) {
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
                                  'Nenhum boletim encontrado',
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Widget de estatísticas
                              BoletimStatsWidget(
                                boletins: controller.filteredBoletins,
                              ),
                              const SizedBox(height: 24),
                              const Text(
                                'Boletins Individuais',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),

                              const SizedBox(height: 16),
                              Wrap(
                                spacing: 16,
                                runSpacing: 16,
                                children:
                                    controller.filteredBoletins.map((boletim) {
                                      return BoletimWidget(
                                        boletimData: boletim,
                                        onTap:
                                            () => controller.showBoletimDetails(
                                              boletim,
                                            ),
                                      );
                                    }).toList(),
                              ),
                            ],
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
    );
  }
}
