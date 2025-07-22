import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/app_button_default.dart';
import '../../../themes/app_colors.dart';
import '../saude_controller.dart';

class PlantaoHeaderWidget extends StatelessWidget {
  const PlantaoHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SaudeController>(
      builder: (controller) {
        // Calcular estatísticas dos plantões
        final totalPlantoes = controller.plantoes.length;
        final plantoesDiurnos =
            controller.plantoes
                .where((p) => p.horario.startsWith('08:00'))
                .length;
        final plantoesNoturnos =
            controller.plantoes
                .where((p) => p.horario.startsWith('18:00'))
                .length;
        final medicosUnicos =
            controller.plantoes.map((p) => p.medicoNome).toSet().length;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Gerenciar Plantões',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: AppButtonDefault(
                            onTap: controller.goToMedicos,
                            icon: Icons.people,
                            text: 'Ver Médicos',
                            paddingVertical: 5,
                            isValid: true,
                            usingJustPadding: false,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: AppButtonDefault(
                            onTap: controller.goToHospitais,
                            icon: Icons.local_hospital,
                            text: 'Ver Hospitais',
                            paddingVertical: 5,
                            isValid: true,
                            usingJustPadding: false,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: AppButtonDefault(
                            onTap: controller.goToCreatePlantao,
                            icon: Icons.add,
                            text: 'Novo Plantão',
                            paddingVertical: 5,
                            isValid: true,
                            usingJustPadding: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  children: [
                    _buildStatCard(
                      icon: Icons.access_time,
                      title: 'Total de Plantões',
                      value: totalPlantoes.toString(),
                      color: AppColors.primaryDark,
                    ),
                    const SizedBox(width: 16),
                    _buildStatCard(
                      icon: Icons.wb_sunny,
                      title: 'Plantões Diurnos',
                      value: plantoesDiurnos.toString(),
                      color: Colors.orange,
                    ),
                    const SizedBox(width: 16),
                    _buildStatCard(
                      icon: Icons.nightlight,
                      title: 'Plantões Noturnos',
                      value: plantoesNoturnos.toString(),
                      color: Colors.indigo,
                    ),
                    const SizedBox(width: 16),
                    _buildStatCard(
                      icon: Icons.people,
                      title: 'Médicos em Plantão',
                      value: medicosUnicos.toString(),
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
