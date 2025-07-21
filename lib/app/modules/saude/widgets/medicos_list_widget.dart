import 'package:flutter/material.dart';

import '../saude_controller.dart';

class MedicosListWidget extends StatelessWidget {
  final SaudeController controller;
  const MedicosListWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    if (controller.filteredMedicos.isEmpty) {
      return const Center(child: Text('Nenhum médico encontrado.'));
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: controller.filteredMedicos.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final medico = controller.filteredMedicos[index];
        return Card(
          child: ListTile(
            title: Text(medico.nome),
            subtitle: Text('${medico.especialidade} | CRM: ${medico.crm}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => controller.goToEditMedico(medico),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => controller.deleteMedico(medico),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
