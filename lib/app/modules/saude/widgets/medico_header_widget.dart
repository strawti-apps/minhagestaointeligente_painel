import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minha_gestao_inteligente_painel/app/themes/app_colors.dart';

import '../../../shared/widgets/app_button_default.dart';
import '../saude_controller.dart';

class MedicoHeaderWidget extends StatelessWidget {
  const MedicoHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SaudeController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Gerenciar Médicos',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: AppButtonDefault(
                        onTap: controller.goToPlantoes,
                        icon: Icons.access_time,
                        text: 'Ver Plantões',
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
                        text: 'ver Hospitais',
                        paddingVertical: 5,
                        isValid: true,
                        usingJustPadding: false,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: AppButtonDefault(
                        onTap: controller.goToCreateMedico,
                        icon: Icons.add,
                        text: 'Novo Médico',
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
          const SizedBox(height: 16),
          // Estatísticas dos dados mockados
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                _buildStatCard(
                  icon: Icons.people,
                  title: 'Total de Médicos',
                  value: controller.medicos.length.toString(),
                  color: Colors.black,
                ),
                const SizedBox(width: 16),
                _buildStatCard(
                  icon: Icons.local_hospital,
                  title: 'Hospitais',
                  value: controller.hospitais.length.toString(),
                  color: Colors.black,
                ),
                const SizedBox(width: 16),
                _buildStatCard(
                  icon: Icons.access_time,
                  title: 'Plantões',
                  value: controller.plantoes.length.toString(),
                  color: Colors.black,
                ),
                const SizedBox(width: 16),
                _buildStatCard(
                  icon: Icons.medical_services,
                  title: 'Especialidades',
                  value:
                      controller.medicos
                          .map((m) => m.especialidade)
                          .toSet()
                          .length
                          .toString(),
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ],
      ),
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
