import 'package:flutter/material.dart';
import 'package:minha_gestao_inteligente_painel/app/themes/app_colors.dart';

import '../saude_controller.dart';

class PlantoesListWidget extends StatelessWidget {
  final SaudeController controller;
  const PlantoesListWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    if (controller.filteredPlantoes.isEmpty) {
      return const Center(child: Text('Nenhum plantão encontrado.'));
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: controller.filteredPlantoes.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final plantao = controller.filteredPlantoes[index];
        return Card(
          elevation: 1,
          color: AppColors.card,
          child: ListTile(
            title: Text(plantao.medicoNome),
            subtitle: Text(
              'Data: ${plantao.data} | Horário: ${plantao.horario}',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: AppColors.success),
                  onPressed: () => controller.goToEditPlantao(plantao),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: AppColors.error),
                  onPressed: () => controller.deletePlantao(plantao),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
