import 'package:flutter/material.dart';

import '../../../themes/app_colors.dart';
import '../contents_controller.dart';

class ContentListWidget extends StatelessWidget {
  final ContentsController controller;

  const ContentListWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    if (controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.filteredCourses.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.school_outlined, size: 64, color: AppColors.textLight),
            const SizedBox(height: 16),
            Text(
              'Nenhum curso encontrado',
              style: TextStyle(
                fontSize: 18,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Comece criando seu primeiro conteúdo',
              style: TextStyle(fontSize: 14, color: AppColors.textLight),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.all(10),
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
      child: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: controller.filteredCourses.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final course = controller.filteredCourses[index];
          final modulesCount = controller.getModulesCount(course.id);

          return ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            leading: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.school, color: AppColors.primaryDark, size: 24),
            ),
            title: Text(
              course.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            subtitle: Text(
              '$modulesCount módulo(s)',
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => controller.goToEditContent(course),
                  icon: const Icon(Icons.edit, size: 20),
                  tooltip: 'Editar',
                  color: AppColors.primaryDark,
                ),
                const SizedBox(width: 8),
                PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert, color: AppColors.textSecondary),
                  onSelected: (value) {
                    switch (value) {
                      case 'edit':
                        controller.goToEditContent(course);
                        break;
                      case 'delete':
                        _showDeleteDialog(context, course.title, () {});
                        break;
                    }
                  },
                  itemBuilder:
                      (context) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: ListTile(
                            leading: Icon(Icons.edit, size: 20),
                            title: Text('Editar'),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: ListTile(
                            leading: Icon(Icons.delete, size: 20),
                            title: Text('Excluir'),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showDeleteDialog(
    BuildContext context,
    String title,
    VoidCallback onConfirm,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmar exclusão'),
          content: Text('Tem certeza que deseja excluir o conteúdo "$title"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm();
              },
              style: TextButton.styleFrom(foregroundColor: AppColors.error),
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );
  }
}
