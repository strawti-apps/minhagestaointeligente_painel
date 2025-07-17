import 'package:flutter/material.dart';

class GenericGridWidget<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(T item) itemBuilder;
  final double? minItemWidth;
  final double? maxItemWidth;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final EdgeInsets padding;
  final double Function(double baseRatio, List<T> items)? aspectRatioCalculator;

  const GenericGridWidget({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.minItemWidth = 280,
    this.maxItemWidth = 400,
    this.crossAxisSpacing = 10,
    this.mainAxisSpacing = 10,
    this.padding = const EdgeInsets.only(bottom: 4),
    this.aspectRatioCalculator,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount;
        double childAspectRatio;

        if (constraints.maxWidth > 1400) {
          crossAxisCount = 4;
          childAspectRatio = 2.0;
        } else if (constraints.maxWidth > 1100) {
          crossAxisCount = 3;
          childAspectRatio = 1.5;
        } else if (constraints.maxWidth > 800) {
          crossAxisCount = 2;
          childAspectRatio = 1.1;
        } else if (constraints.maxWidth > 600) {
          crossAxisCount = 2;
          childAspectRatio = 0.9;
        } else {
          crossAxisCount = 1;
          childAspectRatio = 1.3;
        }

        final finalAspectRatio =
            aspectRatioCalculator != null
                ? aspectRatioCalculator!(childAspectRatio, items)
                : childAspectRatio;

        return GridView.builder(
          padding: padding,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: finalAspectRatio,
            crossAxisSpacing: crossAxisSpacing,
            mainAxisSpacing: mainAxisSpacing,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return itemBuilder(item);
          },
        );
      },
    );
  }
}
