import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../saude_controller.dart';

class PlantaoSearchField extends StatelessWidget {
  const PlantaoSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SaudeController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: controller.plantaoSearchController,
        decoration: const InputDecoration(
          labelText: 'Buscar plantão',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
        onChanged: controller.searchPlantoes,
      ),
    );
  }
}
