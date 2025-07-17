import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../themes/app_colors.dart';
import '../contents_controller.dart';

class ContentHeaderWidget extends StatelessWidget {
  const ContentHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContentsController>(
      builder: (controller) {
        return Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Conteúdos',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${controller.filteredCourses.length} curso(s) encontrado(s)',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              
              Row(
                children: [
                  
                  IconButton(
                    onPressed: () {
                      controller.isSearchMode = !controller.isSearchMode;
                      if (!controller.isSearchMode) {
                        controller.searchController.clear();
                        controller.searchCourses('');
                      }
                      controller.update();
                    },
                    icon: Icon(
                      controller.isSearchMode ? Icons.close : Icons.search,
                      color: AppColors.primaryDark,
                    ),
                    tooltip:
                        controller.isSearchMode ? 'Fechar busca' : 'Buscar',
                  ),

                  const SizedBox(width: 8),

                  ElevatedButton.icon(
                    onPressed: controller.goToCreateContent,
                    icon: const Icon(Icons.add, size: 20),
                    label: const Text('Novo Conteúdo'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryDark,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
