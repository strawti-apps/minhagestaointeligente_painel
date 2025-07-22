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
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header com ícone
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.access_time,
                          color: AppColors.primaryDark,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          widget.isEditing ? 'Editar Plantão' : 'Novo Plantão',
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Campo médico
                  AppTextFormField(
                    controller: controller.plantaoMedicoNomeController,
                    title: 'Nome do Médico *',
                    hintText: 'Digite o nome do médico',
                    validator: FormValidators.required,
                    prefixIcon: Icon(Icons.person),
                  ),
                  const SizedBox(height: 20),

                  // Campo data
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
                        controller
                            .plantaoDataController
                            .text = Formatters.formatDate(picked);
                        setState(() {});
                      }
                    },
                    validator: FormValidators.required,
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  const SizedBox(height: 20),

                  // Seção de horários
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Horário do Plantão',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: AppTextFormField(
                                controller:
                                    controller.plantaoHorarioInicioController,
                                title: 'Início *',
                                hintText: 'Hora de início',
                                readOnly: true,
                                onTap: () async {
                                  final picked = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (picked != null) {
                                    controller
                                        .plantaoHorarioInicioController
                                        .text = picked.format(context);
                                  }
                                },
                                prefixIcon: Icon(Icons.schedule),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: AppTextFormField(
                                controller:
                                    controller.plantaoHorarioFimController,
                                title: 'Fim *',
                                hintText: 'Hora de fim',
                                readOnly: true,
                                onTap: () async {
                                  final picked = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (picked != null) {
                                    controller
                                        .plantaoHorarioFimController
                                        .text = picked.format(context);
                                  }
                                },
                                prefixIcon: Icon(Icons.schedule),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Botões de ação
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: AppButtonDefault(
                          text: 'Cancelar',
                          onTap: controller.backToPlantoesList,
                          borderColor: AppColors.textPrimary,
                          buttonColor: AppColors.card,
                          textColor: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: AppButtonDefault(
                          text: widget.isEditing ? 'Salvar' : 'Criar',
                          onTap: () {
                            if (_formKey.currentState?.validate() == true) {
                              widget.isEditing
                                  ? controller.updatePlantao()
                                  : controller.createPlantao();
                            }
                          },
                          buttonColor: AppColors.primaryDark,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
