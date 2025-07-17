import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';

class GenericListHeaderWidget extends StatelessWidget {
  final String title;
  final String description;
  final int totalItems;
  final IconData headerIcon;

  const GenericListHeaderWidget({
    super.key,
    required this.title,
    required this.description,
    required this.totalItems,
    this.headerIcon = Icons.list_alt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primaryDark.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(headerIcon, color: AppColors.primaryDark, size: 20),
      ),
    );
  }
}
