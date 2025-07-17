import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infra/services/user_service.dart';
import '../../../shared/constants/app_constants.dart';
import '../../../themes/app_colors.dart';
import '../main_courses_controller.dart';

class MainCourseHeaderWidget extends StatelessWidget {
  const MainCourseHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainCoursesController>(
      builder: (controller) {
        final currentUser = UserService.currentUser;
        final canCreateCourse = currentUser != null && 
            AppConstants.hasPermission(currentUser.role, 'create_course');

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
                      'Cursos',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${controller.filteredMainCourses.length} curso(s) encontrado(s)',
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
                    onPressed: controller.toggleSearchMode,
                    icon: Icon(
                      controller.isSearchMode ? Icons.close : Icons.search,
                      color: AppColors.primaryDark,
                    ),
                    tooltip:
                        controller.isSearchMode ? 'Fechar busca' : 'Buscar',
                  ),

                  if (canCreateCourse) ...[
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: controller.goToCreateCourse,
                      icon: const Icon(Icons.add, size: 20),
                      label: const Text('Novo Curso'),
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
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
