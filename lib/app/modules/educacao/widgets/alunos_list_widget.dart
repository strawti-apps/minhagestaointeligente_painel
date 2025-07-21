import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../educacao_controller.dart';

class AlunosListWidget extends StatelessWidget {
  const AlunosListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EducacaoController>();
    if (controller.alunos.isEmpty) {
      return const Center(child: Text('Nenhum aluno encontrado.'));
    }
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Align(
        alignment: Alignment.topLeft,
        child: Wrap(
          alignment: WrapAlignment.start,
          children:
              controller.alunos.map((aluno) {
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
                            aluno.nome,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Turma: ${aluno.turma}',
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.deepPurple,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Responsável: ${aluno.responsavel}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Icon(
                            Icons.badge_rounded,
                            size: 32,
                            color: Colors.blueAccent,
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
