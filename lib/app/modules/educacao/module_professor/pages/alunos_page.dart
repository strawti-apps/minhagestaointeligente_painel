import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/alunos_controller.dart';

class AlunosPage extends StatelessWidget {
  static const route = '/professor/alunos';
  const AlunosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AlunosController());
    return Scaffold(
      appBar: AppBar(title: const Text('Alunos')),
      body: ListView.builder(
        itemCount: controller.alunos.length,
        itemBuilder: (context, index) {
          final aluno = controller.alunos[index];
          return ListTile(
            leading: const Icon(Icons.person),
            title: Text(aluno['nome'] ?? ''),
            subtitle: Text('Turma: ${aluno['turma'] ?? ''}'),
          );
        },
      ),
    );
  }
}
