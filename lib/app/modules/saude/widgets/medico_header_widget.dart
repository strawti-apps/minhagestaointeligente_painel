import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/app_button_default.dart';
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
    );
  }
}
