import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/app_text_form_field.dart';
import '../../../themes/app_colors.dart';
import '../materials_controller.dart';

class MaterialSearchField extends StatelessWidget {
  const MaterialSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MaterialsController>(
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
            onChanged: controller.searchMaterials,
            hintText: 'Buscar materiais...',
            autoValidateMode: AutovalidateMode.disabled,
            autofocus: true,
          ),
        );
      },
    );
  }
} 