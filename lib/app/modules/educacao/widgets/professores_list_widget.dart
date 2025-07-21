import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../educacao_controller.dart';

class ProfessoresListWidget extends StatelessWidget {
  const ProfessoresListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EducacaoController>();
    if (controller.professores.isEmpty) {
      return const Center(child: Text('Nenhum professor encontrado.'));
    }
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Align(
        alignment: Alignment.topLeft,
        child: Wrap(
          children:
              controller.professores.map((prof) {
                return ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 320,
                    maxWidth: 380,
                  ),
                  child: Card(
                    elevation: 0,
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
                            prof.nome,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Disciplina: ${prof.disciplina}',
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Email: ${prof.email}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton.icon(
                                onPressed:
                                    () => controller.visualizarComoProfessor(
                                      prof,
                                    ),
                                icon: const Icon(Icons.visibility),
                                label: const Text('Visualizar como'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  foregroundColor: Colors.white,
                                ),
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
