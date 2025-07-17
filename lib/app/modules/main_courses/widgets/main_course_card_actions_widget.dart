import 'package:flutter/material.dart';

import '../../../infra/models/course_model.dart';
import '../../../infra/services/user_service.dart';
import '../../../shared/constants/app_constants.dart';
import '../../../themes/app_colors.dart';
import '../main_courses_controller.dart';

class MainCourseCardActionsWidget extends StatelessWidget {
  final CourseModel item;
  final MainCoursesController controller;

  const MainCourseCardActionsWidget({
    super.key,
    required this.item,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final currentUser = UserService.currentUser;
    
    // Se não é admin, não mostra ações
    if (currentUser == null || !AppConstants.hasPermission(currentUser.role, 'edit_course')) {
      return const SizedBox.shrink();
    }

    return PopupMenuButton<String>(
      icon: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Icon(Icons.more_vert, color: AppColors.textSecondary, size: 16),
      ),
      onSelected: (value) => _handleAction(context, value),
      itemBuilder: (context) => [
        if (AppConstants.hasPermission(currentUser.role, 'edit_course'))
          const PopupMenuItem(
            value: 'edit',
            child: Row(
              children: [
                Icon(Icons.edit, size: 16),
                SizedBox(width: 8),
                Text('Editar'),
              ],
            ),
          ),
        if (AppConstants.hasPermission(currentUser.role, 'delete_course'))
          const PopupMenuItem(
            value: 'delete',
            child: Row(
              children: [
                Icon(Icons.delete, size: 16, color: Colors.red),
                SizedBox(width: 8),
                Text('Excluir', style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
      ],
    );
  }

  void _handleAction(BuildContext context, String action) {
    switch (action) {
      case 'edit':
        controller.goToEditItem(item);
        break;
      case 'delete':
        controller.goToDeleteItem(item);
        break;
    }
  }
}
