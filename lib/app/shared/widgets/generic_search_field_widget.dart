import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';

class GenericSearchFieldWidget extends StatelessWidget {
  final bool isSearchMode;
  final TextEditingController searchController;
  final Function(String) onSearchChanged;
  final String hintText;
  final VoidCallback? onClear;

  const GenericSearchFieldWidget({
    super.key,
    required this.isSearchMode,
    required this.searchController,
    required this.onSearchChanged,
    required this.hintText,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      height: isSearchMode ? 80 : 0,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 100),
        opacity: isSearchMode ? 1.0 : 0.0,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: AppColors.textSecondary.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
          ),
          child: TextField(
            controller: searchController,
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
              suffixIcon:
                  searchController.text.isNotEmpty
                      ? IconButton(
                        icon: Icon(Icons.clear, color: AppColors.textSecondary),
                        onPressed:
                            onClear ??
                            () {
                              searchController.clear();
                              onSearchChanged('');
                            },
                      )
                      : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.textSecondary),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.textSecondary),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.primaryDark, width: 2),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
