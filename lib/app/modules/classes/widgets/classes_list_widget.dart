import 'package:flutter/material.dart';

import '../../../shared/widgets/generic_grid_widget.dart';
import '../classes_controller.dart';
import 'class_card_widget.dart';

class ClassesListWidget extends StatelessWidget {
  final ClassesController controller;

  const ClassesListWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    if (controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.filteredClasses.isEmpty) {
      return const Center(child: Text('Nenhuma turma encontrada'));
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GenericGridWidget(
        items: controller.filteredClasses,
        itemBuilder: (classItem) {
          return ClassCardWidget(classItem: classItem, controller: controller);
        },
      ),
    );
  }
}
