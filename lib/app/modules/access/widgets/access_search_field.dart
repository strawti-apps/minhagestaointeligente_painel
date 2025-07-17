import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/app_text_form_field.dart';
import '../../../themes/app_colors.dart';
import '../access_controller.dart';

class AccessSearchField extends StatelessWidget {
  const AccessSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccessController>(
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
            onChanged: controller.searchEnrollments,
            hintText: 'Buscar por nome do usuário ou turma...',
            autoValidateMode: AutovalidateMode.disabled,
            autofocus: true,
            prefixIcon: const Icon(Icons.search),
          ),
        );
      },
    );
  }
} 