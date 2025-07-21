import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../saude_controller.dart';

class MedicoHeaderWidget extends StatelessWidget {
  const MedicoHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SaudeController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Gerenciar Médicos',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: controller.goToPlantoes,
                icon: const Icon(Icons.access_time),
                label: const Text('Ver Plantões'),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: controller.goToCreateMedico,
                icon: const Icon(Icons.add),
                label: const Text('Novo Médico'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
