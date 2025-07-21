import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/app_button_default.dart';
import '../../../shared/widgets/app_text_form_field.dart';
import '../../../themes/app_colors.dart';
import '../saude_controller.dart';

class HospitalCreateEditWidget extends StatelessWidget {
  final bool isEditing;
  const HospitalCreateEditWidget({super.key, required this.isEditing});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SaudeController>();
    return Center(
      child: Card(
        elevation: 0.5,
        color: AppColors.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  isEditing ? 'Editar Hospital' : 'Novo Hospital',
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                AppTextFormField(
                  controller: controller.hospitalNomeController,
                  hintText: 'Nome do hospital',
                ),
                const SizedBox(height: 16),
                AppTextFormField(
                  controller: controller.hospitalEnderecoController,
                  hintText: 'Endereço',
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: AppButtonDefault(
                        text: 'Cancelar',
                        onTap: controller.backToHospitaisList,
                        borderColor: AppColors.textPrimary,
                        buttonColor: AppColors.card,
                        textColor: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: AppButtonDefault(
                        text: isEditing ? 'Salvar' : 'Criar',
                        onTap:
                            isEditing
                                ? controller.updateHospital
                                : controller.createHospital,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
