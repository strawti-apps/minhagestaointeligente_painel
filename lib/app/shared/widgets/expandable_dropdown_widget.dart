import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';

class ExpandableDropdownWidget<T> extends StatefulWidget {
  final String title;
  final String hintText;
  final String searchHintText;
  final IconData prefixIcon;
  final T? selectedItem;
  final List<T> items;
  final String Function(T) getItemTitle;
  final String Function(T) getItemId;
  final void Function(T?) onItemSelected;
  final bool isLoading;
  final bool isRequired;
  final String? emptyMessage;

  const ExpandableDropdownWidget({
    super.key,
    required this.title,
    required this.hintText,
    required this.searchHintText,
    required this.prefixIcon,
    required this.selectedItem,
    required this.items,
    required this.getItemTitle,
    required this.getItemId,
    required this.onItemSelected,
    this.isLoading = false,
    this.isRequired = false,
    this.emptyMessage,
  });

  @override
  State<ExpandableDropdownWidget<T>> createState() =>
      _ExpandableDropdownWidgetState<T>();
}

class _ExpandableDropdownWidgetState<T>
    extends State<ExpandableDropdownWidget<T>> {
  bool _isDropdownExpanded = false;
  final TextEditingController _searchController = TextEditingController();
  List<T> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterItems);
    _filteredItems = widget.items;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterItems() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems =
          widget.items
              .where(
                (item) =>
                    widget.getItemTitle(item).toLowerCase().contains(query),
              )
              .toList();
    });
  }

  void _updateFilteredItems() {
    final query = _searchController.text.toLowerCase();
    _filteredItems =
        widget.items
            .where(
              (item) => widget.getItemTitle(item).toLowerCase().contains(query),
            )
            .toList();
  }

  @override
  Widget build(BuildContext context) {
    // Atualiza a lista filtrada quando os itens mudam
    if (widget.items.isNotEmpty && _searchController.text.isEmpty) {
      _filteredItems = widget.items;
    } else if (widget.items.isNotEmpty) {
      _updateFilteredItems();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color:
                  widget.isRequired && widget.selectedItem == null
                      ? Colors.red.shade300
                      : Colors.grey.withValues(alpha:0.3),
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    _isDropdownExpanded = !_isDropdownExpanded;
                  });
                },
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        widget.prefixIcon,
                        size: 20,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          widget.selectedItem != null
                              ? widget.getItemTitle(widget.selectedItem as T)
                              : widget.hintText,
                          style: TextStyle(
                            fontSize: 14,
                            color:
                                widget.selectedItem != null
                                    ? Colors.black87
                                    : Colors.grey.shade600,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      AnimatedRotation(
                        turns: _isDropdownExpanded ? 0.5 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: _isDropdownExpanded ? null : 0,
                child:
                    _isDropdownExpanded
                        ? Container(
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Colors.grey.withValues(alpha:0.3),
                                width: 1,
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: TextField(
                                  controller: _searchController,
                                  decoration: InputDecoration(
                                    hintText: widget.searchHintText,
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixIcon: const Icon(
                                      Icons.search,
                                      size: 20,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide(
                                        color: Colors.grey.withValues(alpha:0.3),
                                        width: 1.5,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide(
                                        color: Colors.grey.withValues(alpha:0.3),
                                        width: 1.5,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide(
                                        color: const Color(0xFF1976D2).withValues(alpha:0.5),
                                        width: 1.5,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 16,
                                    ),
                                  ),
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),

                              if (widget.isLoading)
                                const Padding(
                                  padding: EdgeInsets.all(20),
                                  child: CircularProgressIndicator(),
                                )
                              else if (_filteredItems.isEmpty)
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    widget.emptyMessage ??
                                        'Nenhum item encontrado',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 14,
                                    ),
                                  ),
                                )
                              else
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxHeight: 200,
                                  ),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: _filteredItems.length,
                                    itemBuilder: (context, index) {
                                      final item = _filteredItems[index];
                                      final isSelected =
                                          widget.selectedItem != null &&
                                          widget.getItemId(
                                                widget.selectedItem as T,
                                              ) ==
                                              widget.getItemId(item);

                                      return InkWell(
                                        onTap: () {
                                          widget.onItemSelected(item);
                                          setState(() {
                                            _isDropdownExpanded = false;
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 12,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                isSelected
                                                    ? const Color(0xFF1976D2)
                                                        .withValues(alpha:0.1)
                                                    : Colors.transparent,
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 18,
                                                height: 18,
                                                decoration: BoxDecoration(
                                                  color:
                                                      isSelected
                                                          ? AppColors
                                                              .primaryDark
                                                          : Colors.transparent,
                                                  border: Border.all(
                                                    color:
                                                        isSelected
                                                            ? AppColors
                                                                .primaryDark
                                                            : AppColors
                                                                .textPrimary,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                ),
                                                child:
                                                    isSelected
                                                        ? const Icon(
                                                          Icons.check,
                                                          size: 14,
                                                          color: Colors.white,
                                                        )
                                                        : null,
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Text(
                                                  widget.getItemTitle(item),
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color:
                                                        AppColors.textPrimary,
                                                    fontWeight:
                                                        isSelected
                                                            ? FontWeight.w600
                                                            : FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                            ],
                          ),
                        )
                        : const SizedBox.shrink(),
              ),
            ],
          ),
        ),

        if (widget.isRequired && widget.selectedItem == null)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 12),
            child: Text(
              'Campo obrigatório',
              style: TextStyle(color: Colors.red.shade600, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
