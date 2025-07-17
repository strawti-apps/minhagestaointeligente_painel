import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../themes/app_colors.dart';
import '../classes_controller.dart';

class ClassSearchField extends StatelessWidget {
  const ClassSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClassesController>(
      builder: (controller) {
        if (!controller.isSearchMode) {
          return const SizedBox.shrink();
        }

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: TextField(
            controller: controller.searchController,
            onChanged: controller.searchClasses,
            decoration: InputDecoration(
              hintText: 'Buscar turmas...',
              prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.textSecondary),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.primaryDark),
              ),
            ),
          ),
        );
      },
    );
  }
} 