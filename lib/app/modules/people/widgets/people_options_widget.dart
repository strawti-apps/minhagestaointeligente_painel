import 'package:flutter/material.dart';

import '../../../shared/widgets/generic_grid_widget.dart';
import '../people_controller.dart';

class PeopleOptionsWidget extends StatelessWidget {
  final PeopleController controller;

  const PeopleOptionsWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GenericGridWidget(
        items: controller.options,
        aspectRatioCalculator: (baseRatio, items) => 1.0,
        itemBuilder: (item) => item,
      ),
    );
  }
}
