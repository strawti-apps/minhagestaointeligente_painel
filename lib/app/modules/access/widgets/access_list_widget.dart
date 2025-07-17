import 'package:flutter/material.dart';

import '../../../shared/widgets/generic_grid_widget.dart';
import '../access_controller.dart';
import 'access_card_widget.dart';

class AccessListWidget extends StatelessWidget {
  final AccessController controller;

  const AccessListWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    if (controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.filteredEnrollments.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.quiz_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Nenhum acesso encontrado',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GenericGridWidget(
        items: controller.filteredEnrollments,
        aspectRatioCalculator: (baseRatio, items) => 2.0,
        itemBuilder: (enrollment) {
          return AccessCardWidget(
            enrollment: enrollment,
            controller: controller,
          );
        },
      ),
    );
  }
}
