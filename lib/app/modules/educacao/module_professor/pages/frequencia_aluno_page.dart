import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/frequencia_aluno_controller.dart';

class FrequenciaAlunoPage extends StatelessWidget {
  static const route = '/professor/frequencia_aluno';
  const FrequenciaAlunoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FrequenciaAlunoController());
    return Scaffold(
      appBar: AppBar(title: const Text('Frequência do Aluno')),
      body: ListView.builder(
        itemCount: controller.alunos.length,
        itemBuilder: (context, index) {
          final aluno = controller.alunos[index];
          return ListTile(
            leading: Checkbox(
              value: aluno['presente'] as bool? ?? false,
              onChanged: (val) => controller.togglePresenca(index),
            ),
            title: Text(aluno['nome'] as String? ?? ''),
            subtitle: Text('Turma: ${aluno['turma'] as String? ?? ''}'),
            trailing: Text(
              (aluno['presente'] as bool? ?? false) ? 'Presente' : 'Faltou',
            ),
          );
        },
      ),
    );
  }
}
