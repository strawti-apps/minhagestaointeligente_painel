import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../themes/app_colors.dart';
import '../quizzes_controller.dart';

class QuizHeaderWidget extends StatelessWidget {
  const QuizHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizzesController>(
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
              // Título e contador
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Questionários',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${controller.filteredQuizzes.length} questionário(s) encontrado(s)',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              // Ações
              Row(
                children: [
                  // Botão de pesquisa
                  IconButton(
                    onPressed: () {
                      // Implementar toggle search mode
                      controller.isSearchMode = !controller.isSearchMode;
                      if (!controller.isSearchMode) {
                        controller.searchController.clear();
                        controller.searchQuizzes('');
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
                    onPressed: controller.goToCreateQuiz,
                    icon: const Icon(Icons.add, size: 20),
                    label: const Text('Novo Questionário'),
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