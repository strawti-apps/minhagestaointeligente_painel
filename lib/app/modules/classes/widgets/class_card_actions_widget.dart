import 'package:flutter/material.dart';

import '../../../infra/models/class_model.dart';
import '../../../themes/app_colors.dart';
import '../classes_controller.dart';

class ClassCardActionsWidget extends StatelessWidget {
  final ClassModel item;
  final ClassesController controller;

  const ClassCardActionsWidget({
    super.key,
    required this.item,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
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
      itemBuilder:
          (context) => [
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
        controller.showDeleteClassConfirmation(item);
        break;
    }
  }
} 