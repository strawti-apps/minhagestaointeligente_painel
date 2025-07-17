import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/app_text_form_field.dart';
import '../../../themes/app_colors.dart';
import '../main_courses_controller.dart';

class MainCourseSearchField extends StatelessWidget {
  const MainCourseSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainCoursesController>(
      builder: (controller) {
        if (!controller.isSearchMode) {
          return const SizedBox.shrink();
        }

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: AppColors.textSecondary.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
          ),
          child: AppTextFormField(
            controller: controller.searchController,
            onChanged: controller.searchMainCourses,
            hintText: 'Buscar cursos...',
            autoValidateMode: AutovalidateMode.disabled,
            autofocus: true,
          ),
        );
      },
    );
  }
}
