import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';

class GenericHeaderActionsWidget extends StatelessWidget {
  final bool isInListMode;
  final bool isSearchMode;
  final VoidCallback onToggleSearch;
  final VoidCallback onCreateNew;
  final VoidCallback? onGoBack;
  final String createButtonText;
  final IconData createButtonIcon;
  final String searchTooltipOpen;
  final String searchTooltipClose;
  final String backButtonText;
  final Color? createButtonColor;

  const GenericHeaderActionsWidget({
    super.key,
    required this.isInListMode,
    required this.isSearchMode,
    required this.onToggleSearch,
    required this.onCreateNew,
    this.onGoBack,
    required this.createButtonText,
    this.createButtonIcon = Icons.add,
    required this.searchTooltipOpen,
    required this.searchTooltipClose,
    this.backButtonText = 'Voltar',
    this.createButtonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (isInListMode) ...[
          // Ícone de pesquisa
          IconButton(
            onPressed: onToggleSearch,
            icon: Icon(
              isSearchMode ? Icons.close : Icons.search,
              color: isSearchMode ? AppColors.primary : AppColors.textPrimary,
            ),
            tooltip: isSearchMode ? searchTooltipClose : searchTooltipOpen,
            style: IconButton.styleFrom(
              backgroundColor:
                  isSearchMode
                      ? AppColors.primary.withValues(alpha: 0.1)
                      : AppColors.textSecondary.withValues(alpha: 0.3),
              padding: const EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),

          const SizedBox(width: 12),

          ElevatedButton.icon(
            onPressed: onCreateNew,
            icon: Icon(createButtonIcon),
            label: Text(createButtonText),
            style: ElevatedButton.styleFrom(
              backgroundColor: createButtonColor ?? AppColors.primaryDark,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 2,
            ),
          ),
        ],

        if (!isInListMode && onGoBack != null) ...[
          const SizedBox(width: 12),

          OutlinedButton.icon(
            onPressed: onGoBack,
            icon: const Icon(Icons.arrow_back),
            label: Text(backButtonText),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.textSecondary,
              side: BorderSide(color: AppColors.textSecondary),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
