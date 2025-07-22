import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/navbar/navbar_desktop_widget.dart';
import '../../../../themes/app_colors.dart';
import '../controllers/frequencia_aluno_controller.dart';

class FrequenciaAlunoPage extends StatelessWidget {
  static const route = '/professor/frequencia_aluno';
  const FrequenciaAlunoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FrequenciaAlunoController());
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const NavbarDesktopWidget(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Wrap(
                children:
                    controller.alunos.asMap().entries.map((entry) {
                      final index = entry.key;
                      final aluno = entry.value;

                      return Card(
                        elevation: 2,
                        color: AppColors.card,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 380),
                          child: ListTile(
                            leading: Checkbox(
                              activeColor: AppColors.success,
                              value: aluno['presente'] as bool? ?? false,
                              onChanged:
                                  (val) => controller.togglePresenca(index),
                            ),
                            title: Text(aluno['nome'] as String? ?? ''),
                            subtitle: Text(
                              'Turma: ${aluno['turma'] as String? ?? ''}',
                            ),
                            trailing: Text(
                              (aluno['presente'] as bool? ?? false)
                                  ? 'Presente'
                                  : 'Faltou',
                              style: TextStyle(
                                color:
                                    (aluno['presente'] as bool? ?? false)
                                        ? AppColors.success
                                        : AppColors.error,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
