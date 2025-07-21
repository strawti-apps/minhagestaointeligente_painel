import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minha_gestao_inteligente_painel/app/shared/widgets/app_text_form_field.dart';
import 'package:minha_gestao_inteligente_painel/app/themes/app_colors.dart';

import '../../../shared/widgets/app_button_default.dart';
import '../saude_controller.dart';

class MedicoCreateEditWidget extends StatelessWidget {
  final bool isEditing;
  const MedicoCreateEditWidget({super.key, required this.isEditing});

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
                  isEditing ? 'Editar Médico' : 'Novo Médico',
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                AppTextFormField(
                  controller: controller.medicoNomeController,
                  hintText: 'Nome',
                ),
                const SizedBox(height: 16),
                AppTextFormField(
                  controller: controller.medicoEspecialidadeController,
                  hintText: 'Especialidade',
                ),
                const SizedBox(height: 16),
                AppTextFormField(
                  controller: controller.medicoCrmController,
                  hintText: 'CRM',
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: AppButtonDefault(
                        text: 'Cancelar',
                        onTap: controller.backToMedicosList,
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
                                ? controller.updateMedico
                                : controller.createMedico,
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
