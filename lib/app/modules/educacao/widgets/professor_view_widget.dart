import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../educacao_controller.dart';

class ProfessorViewWidget extends StatelessWidget {
  final Professor professor;
  const ProfessorViewWidget({super.key, required this.professor});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EducacaoController>();
    return Center(
      child: Card(
        margin: const EdgeInsets.all(32),
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.person, size: 60, color: Colors.blueAccent),
              const SizedBox(height: 16),
              Text(
                professor.nome,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Disciplina: ${professor.disciplina}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                'Email: ${professor.email}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: controller.voltarVisualizacaoProfessor,
                icon: const Icon(Icons.arrow_back),
                label: const Text('Voltar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
