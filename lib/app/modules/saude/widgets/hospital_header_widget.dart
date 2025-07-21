import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/app_button_default.dart';
import '../../../shared/widgets/app_text_form_field.dart';
import '../../../themes/app_colors.dart';
import '../saude_controller.dart';

class HospitalHeaderWidget extends StatelessWidget {
  const HospitalHeaderWidget({super.key});

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
                'Gerenciar Hospitais',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: controller.goToMedicos,
                    icon: Icon(Icons.close, color: AppColors.primaryDark),
                    tooltip: 'Voltar',
                  ),
                  SizedBox(width: 10),
                  AppButtonDefault(
                    paddingVertical: 5,
                    onTap: controller.goToCreateHospital,
                    icon: Icons.add,
                    text: 'Novo Hospital',
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          AppTextFormField(
            hintText: 'Buscar hospital',
            onChanged: controller.searchHospitais,
          ),
        ],
      ),
    );
  }
}
