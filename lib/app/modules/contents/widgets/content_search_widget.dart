import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../themes/app_colors.dart';
import '../contents_controller.dart';

class ContentSearchField extends StatelessWidget {
  const ContentSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContentsController>(
      builder: (controller) {
        if (!controller.isSearchMode) {
          return const SizedBox.shrink();
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            controller: controller.searchController,
            onChanged: controller.searchCourses,
            decoration: InputDecoration(
              hintText: 'Buscar por nome do curso...',
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.textSecondary,
              ),
              suffixIcon: controller.searchController.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        controller.searchController.clear();
                        controller.searchCourses('');
                      },
                      icon: Icon(
                        Icons.clear,
                        color: AppColors.textSecondary,
                      ),
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.textLight),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.textLight),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.primaryDark),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        );
      },
    );
  }
}