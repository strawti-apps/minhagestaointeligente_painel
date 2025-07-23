import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/navbar/navbar_desktop_widget.dart';
import '../../../../themes/app_colors.dart';
import '../controllers/material_escolar_controller.dart';
import '../widgets/material_escolar_widget.dart';

class MaterialEscolarPage extends StatelessWidget {
  static const route = '/professor/material_escolar';
  const MaterialEscolarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MaterialEscolarController());

    return Scaffold(
      body: Row(
        children: [
          const NavbarDesktopWidget(),
          Expanded(
            child: Column(
              children: [
                // Cabeçalho da página
                Container(
                  width: double.infinity,
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
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Material',
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
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: 250,
                              minWidth: 100,
                            ),
                            child: TextField(
                              controller: controller.searchController,
                              onChanged: controller.searchMateriais,
                              decoration: InputDecoration(
                                hintText: 'Buscar por título ou disciplina...',
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
                          // Botão de filtro por categoria
                          PopupMenuButton<String>(
                            onSelected: controller.filterByCategoria,
                            itemBuilder:
                                (context) => [
                                  const PopupMenuItem(
                                    value: 'todos',
                                    child: Text('Todas as categorias'),
                                  ),
                                  const PopupMenuItem(
                                    value: 'apostila',
                                    child: Text('Apostila'),
                                  ),
                                  const PopupMenuItem(
                                    value: 'exercícios',
                                    child: Text('Exercícios'),
                                  ),
                                  const PopupMenuItem(
                                    value: 'resumo',
                                    child: Text('Resumo'),
                                  ),
                                  const PopupMenuItem(
                                    value: 'apresentação',
                                    child: Text('Apresentação'),
                                  ),
                                  const PopupMenuItem(
                                    value: 'avaliação',
                                    child: Text('Avaliação'),
                                  ),
                                  const PopupMenuItem(
                                    value: 'mapa mental',
                                    child: Text('Mapa Mental'),
                                  ),
                                  const PopupMenuItem(
                                    value: 'vocabulário',
                                    child: Text('Vocabulário'),
                                  ),
                                  const PopupMenuItem(
                                    value: 'experimento',
                                    child: Text('Experimento'),
                                  ),
                                  const PopupMenuItem(
                                    value: 'técnica',
                                    child: Text('Técnica'),
                                  ),
                                  const PopupMenuItem(
                                    value: 'fórmulas',
                                    child: Text('Fórmulas'),
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
                    ],
                  ),
                ),

                // Conteúdo principal
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    color: Colors.grey.shade50,
                    child: GetBuilder<MaterialEscolarController>(
                      builder: (controller) {
                        if (controller.filteredMateriais.isEmpty) {
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
                                  'Nenhum material encontrado',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Tente ajustar os filtros ou a busca',
                                  style: TextStyle(
                                    fontSize: 14,
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
                              spacing: 10,
                              runSpacing: 10,
                              children:
                                  controller.filteredMateriais.map((material) {
                                    return MaterialEscolarWidget(
                                      materialData: material,
                                      onTap:
                                          () => controller.showMaterialDetails(
                                            material,
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
    );
  }
}
