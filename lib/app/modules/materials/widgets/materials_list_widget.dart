import 'package:flutter/material.dart';

import '../../../shared/widgets/generic_grid_widget.dart';
import '../materials_controller.dart';
import 'material_card_widget.dart';

class MaterialsListWidget extends StatelessWidget {
  final MaterialsController controller;
  const MaterialsListWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GenericGridWidget(
        items: controller.filteredMaterials,
        aspectRatioCalculator: (baseRatio, items) {
          return 3.5;
        },
        itemBuilder: (material) {
          return MaterialCardWidget(material: material, controller: controller);
        },
      ),
    );
  }
} 