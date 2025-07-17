import 'package:flutter/material.dart';

import '../../../infra/models/course_model.dart';
import '../../../themes/app_colors.dart';
import '../main_courses_controller.dart';
import 'main_course_card_actions_widget.dart';

class MainCourseCardWidget extends StatelessWidget {
  final CourseModel course;
  final MainCoursesController controller;

  const MainCourseCardWidget({
    super.key,
    required this.course,
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
            CourseBackgroundImageWidget(course: course),
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
            CourseContentOverlayWidget(course: course),
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: MainCourseCardActionsWidget(
                  item: course,
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

class CourseBackgroundImageWidget extends StatelessWidget {
  final CourseModel course;

  const CourseBackgroundImageWidget({super.key, required this.course});

  bool get _hasImage => course.coverImageUrl?.isNotEmpty == true;

  @override
  Widget build(BuildContext context) {
    if (_hasImage) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          course.coverImageUrl!,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          errorBuilder:
              (context, error, stackTrace) => CourseDefaultBackgroundWidget(),
        ),
      );
    }
    return CourseDefaultBackgroundWidget();
  }
}

class CourseDefaultBackgroundWidget extends StatelessWidget {
  const CourseDefaultBackgroundWidget({super.key});

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
      child: const Icon(Icons.image, color: Colors.white, size: 48),
    );
  }
}

class CourseContentOverlayWidget extends StatelessWidget {
  final CourseModel course;

  const CourseContentOverlayWidget({super.key, required this.course});

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
            course.title,
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
            'Criado em ${_formatDate(course.createdAt)}',
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
