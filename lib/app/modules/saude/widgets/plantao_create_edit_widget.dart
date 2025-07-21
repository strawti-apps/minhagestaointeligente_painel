import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/utils/form_validators.dart';
import '../../../shared/utils/formatters.dart';
import '../../../shared/widgets/app_button_default.dart';
import '../../../shared/widgets/app_text_form_field.dart';
import '../../../themes/app_colors.dart';
import '../saude_controller.dart';

class PlantaoCreateEditWidget extends StatefulWidget {
  final bool isEditing;
  const PlantaoCreateEditWidget({super.key, required this.isEditing});

  @override
  State<PlantaoCreateEditWidget> createState() =>
      _PlantaoCreateEditWidgetState();
}

class _PlantaoCreateEditWidgetState extends State<PlantaoCreateEditWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SaudeController>();
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
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                IconButton(
                  onPressed: controller.backToPlantoesList,
                  icon: const Icon(Icons.arrow_back),
                  tooltip: 'Voltar',
                ),
                const SizedBox(width: 10),
                Text(
                  widget.isEditing ? 'Editar Plantão' : 'Novo Plantão',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            AppTextFormField(
              controller: controller.plantaoMedicoNomeController,
              title: 'Nome do Médico *',
              hintText: 'Digite o nome do médico',
              validator: FormValidators.required,
            ),
            const SizedBox(height: 20),
            AppTextFormField(
              controller: controller.plantaoDataController,
              title: 'Data do Plantão *',
              hintText: 'Selecione a data',
              readOnly: true,
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate:
                      controller.plantaoDataController.text.isNotEmpty
                          ? DateTime.tryParse(
                                controller.plantaoDataController.text,
                              ) ??
                              DateTime.now()
                          : DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                  locale: const Locale('pt', 'BR'),
                );
                if (picked != null) {
                  controller.plantaoDataController.text = Formatters.formatDate(
                    picked,
                  );
                  setState(() {});
                }
              },
              validator: FormValidators.required,
              suffixIcon: const Icon(Icons.calendar_today),
            ),
            const SizedBox(height: 20),
            AppTextFormField(
              controller: controller.plantaoHorarioInicioController,
              title: 'Hora de início *',
              hintText: 'Selecione a hora de início',
              readOnly: true,
              onTap: () async {
                final picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (picked != null) {
                  controller.plantaoHorarioInicioController.text = picked
                      .format(context);
                }
              },
            ),
            const SizedBox(height: 16),
            AppTextFormField(
              controller: controller.plantaoHorarioFimController,
              title: 'Hora de fim *',
              hintText: 'Selecione a hora de fim',
              readOnly: true,
              onTap: () async {
                final picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (picked != null) {
                  controller.plantaoHorarioFimController.text = picked.format(
                    context,
                  );
                }
              },
            ),
            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppButtonDefault(
                  text: 'Cancelar',
                  onTap: controller.backToPlantoesList,
                  borderColor: AppColors.textPrimary,
                  buttonColor: AppColors.card,
                  textColor: AppColors.textPrimary,
                ),
                const SizedBox(width: 15),
                AppButtonDefault(
                  text:
                      widget.isEditing ? 'Salvar Alterações' : 'Criar Plantão',
                  onTap: () {
                    if (_formKey.currentState?.validate() == true) {
                      widget.isEditing
                          ? controller.updatePlantao()
                          : controller.createPlantao();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
