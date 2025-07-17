import 'package:flutter/material.dart';

import 'generic_list_states_widget.dart';

class GenericListWidget<T> extends StatelessWidget {
  final bool isLoading;
  final bool hasError;
  final String errorMessage;
  final List<T> items;
  final List<T> displayedItems;
  final bool isSearchMode;
  final Widget Function() headerBuilder;
  final Widget Function() gridBuilder;
  final VoidCallback? onRefresh;
  final VoidCallback? onCreateFirst;
  final String loadingMessage;
  final String errorTitle;
  final String emptyTitle;
  final String emptyDescription;
  final String createButtonText;
  final String noResultsTitle;
  final String noResultsDescription;
  final VoidCallback? onClearSearch;

  const GenericListWidget({
    super.key,
    required this.isLoading,
    required this.hasError,
    required this.errorMessage,
    required this.items,
    required this.displayedItems,
    required this.isSearchMode,
    required this.headerBuilder,
    required this.gridBuilder,
    this.onRefresh,
    this.onCreateFirst,
    required this.loadingMessage,
    required this.errorTitle,
    required this.emptyTitle,
    required this.emptyDescription,
    required this.createButtonText,
    required this.noResultsTitle,
    required this.noResultsDescription,
    this.onClearSearch,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return GenericListLoadingWidget(message: loadingMessage);
    }

    if (hasError) {
      return GenericListErrorWidget(
        title: errorTitle,
        message: errorMessage,
        onRetry: onRefresh,
      );
    }

    if (items.isEmpty) {
      return GenericListEmptyWidget(
        title: emptyTitle,
        description: emptyDescription,
        buttonText: createButtonText,
        onCreateFirst: onCreateFirst,
      );
    }

    if (isSearchMode && displayedItems.isEmpty) {
      return _buildNoResultsWidget();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headerBuilder(),
        const SizedBox(height: 24),
        Expanded(child: gridBuilder()),
      ],
    );
  }

  Widget _buildNoResultsWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            noResultsTitle,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            noResultsDescription,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          ),
          if (onClearSearch != null) ...[
            const SizedBox(height: 24),
            TextButton.icon(
              onPressed: onClearSearch,
              icon: const Icon(Icons.clear),
              label: const Text('Limpar pesquisa'),
            ),
          ],
        ],
      ),
    );
  }
}
