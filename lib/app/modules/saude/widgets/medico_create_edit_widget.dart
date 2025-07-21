import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../saude_controller.dart';

class MedicoCreateEditWidget extends StatelessWidget {
  final bool isEditing;
  const MedicoCreateEditWidget({super.key, required this.isEditing});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SaudeController>();
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                isEditing ? 'Editar Médico' : 'Novo Médico',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              TextField(
                controller: controller.medicoNomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller.medicoEspecialidadeController,
                decoration: const InputDecoration(labelText: 'Especialidade'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller.medicoCrmController,
                decoration: const InputDecoration(labelText: 'CRM'),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: controller.backToMedicosList,
                    child: const Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed:
                        isEditing
                            ? controller.updateMedico
                            : controller.createMedico,
                    child: Text(isEditing ? 'Salvar' : 'Criar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
