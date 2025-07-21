import 'package:flutter/material.dart';

import '../saude_controller.dart';

class MedicosListWidget extends StatelessWidget {
  final SaudeController controller;
  const MedicosListWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    if (controller.filteredMedicos.isEmpty) {
      return const Center(child: Text('Nenhum médico encontrado.'));
    }
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Align(
        alignment: Alignment.topLeft,
        child: Wrap(
          alignment: WrapAlignment.start,
          children:
              controller.filteredMedicos.map((medico) {
                return ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 320,
                    maxWidth: 380,
                  ),
                  child: Card(
                    elevation: 2,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            medico.nome,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            medico.especialidade,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'CRM: ${medico.crm}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blueAccent,
                                ),
                                onPressed:
                                    () => controller.goToEditMedico(medico),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ),
                                onPressed:
                                    () => controller.deleteMedico(medico),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}
