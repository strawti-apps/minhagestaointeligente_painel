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
            constraints: const BoxConstraints(maxWidth: 600),
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

                // Nome do hospital
                AppTextFormField(
                  controller: controller.hospitalNomeController,
                  hintText: 'Nome do hospital',
                ),
                const SizedBox(height: 16),

                // Endereço
                AppTextFormField(
                  controller: controller.hospitalEnderecoController,
                  hintText: 'Endereço completo',
                ),
                const SizedBox(height: 16),

                // Telefone e Email
                Row(
                  children: [
                    Expanded(
                      child: AppTextFormField(
                        controller: controller.hospitalTelefoneController,
                        hintText: 'Telefone',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: AppTextFormField(
                        controller: controller.hospitalEmailController,
                        hintText: 'Email',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Tipo e Capacidade
                Row(
                  children: [
                    Expanded(
                      child: AppTextFormField(
                        controller: controller.hospitalTipoController,
                        hintText: 'Tipo (Público, Privado, Filantrópico)',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: AppTextFormField(
                        controller: controller.hospitalCapacidadeController,
                        hintText: 'Capacidade (número de leitos)',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // URL da imagem
                AppTextFormField(
                  controller: controller.hospitalImagemController,
                  hintText: 'URL da imagem do hospital (opcional)',
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
