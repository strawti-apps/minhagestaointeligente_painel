import 'package:flutter/material.dart';

import '../../../infra/models/class_model.dart';
import '../../../themes/app_colors.dart';
import '../classes_controller.dart';
import 'class_card_actions_widget.dart';

class ClassCardWidget extends StatelessWidget {
  final ClassModel classItem;
  final ClassesController controller;

  const ClassCardWidget({
    super.key,
    required this.classItem,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            ClassBackgroundImageWidget(classItem: classItem),
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topRight,
                  colors: [
                    Colors.black.withValues(alpha: 0.8),
                    Colors.black.withValues(alpha: 0.4),
                    AppColors.primaryDark.withValues(alpha: 0.2),
                  ],
                ),
              ),
            ),
            ClassContentOverlayWidget(classItem: classItem),
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClassCardActionsWidget(
                  item: classItem,
                  controller: controller,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ClassBackgroundImageWidget extends StatelessWidget {
  final ClassModel classItem;

  const ClassBackgroundImageWidget({super.key, required this.classItem});

  bool get _hasImage => classItem.thumbnailUrl?.isNotEmpty == true;

  @override
  Widget build(BuildContext context) {
    if (_hasImage) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          classItem.thumbnailUrl!,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          errorBuilder:
              (context, error, stackTrace) => ClassDefaultBackgroundWidget(),
        ),
      );
    }
    return ClassDefaultBackgroundWidget();
  }
}

class ClassDefaultBackgroundWidget extends StatelessWidget {
  const ClassDefaultBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryDark.withValues(alpha: 0.8),
            AppColors.primaryDark.withValues(alpha: 0.6),
          ],
        ),
      ),
      child: const Icon(Icons.group, color: Colors.white, size: 48),
    );
  }
}

class ClassContentOverlayWidget extends StatelessWidget {
  final ClassModel classItem;

  const ClassContentOverlayWidget({super.key, required this.classItem});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      right: 16,
      bottom: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Título
          Text(
            classItem.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 8),

          // Data de criação
          Text(
            'Criado em ${_formatDate(classItem.createdAt)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Data não disponível';

    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();

    return '$day/$month/$year';
  }
} 