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
        return Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Plantões',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${controller.filteredPlantoes.length} plantão(ões) encontrado(s)',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: controller.goToMedicos,
                    icon: Icon(Icons.close, color: AppColors.primaryDark),
                    tooltip: 'Voltar',
                  ),
                  const SizedBox(width: 8),
                  AppButtonDefault(
                    onTap: controller.goToCreatePlantao,
                    icon: Icons.add,
                    text: 'Novo Plantão',
                    paddingVertical: 5,
                    isValid: true,
                    width: 150,
                    usingJustPadding: false,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
