import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';

class FrequenciaWidget extends StatelessWidget {
  final Map<String, dynamic> alunoData;
  final VoidCallback onTap;
  final VoidCallback onTogglePresenca;

  const FrequenciaWidget({
    super.key,
    required this.alunoData,
    required this.onTap,
    required this.onTogglePresenca,
  });

  @override
  Widget build(BuildContext context) {
    final String image = alunoData['image'] ?? '';
    final String nome = alunoData['nome'] ?? '';
    final String turma = alunoData['turma'] ?? '';
    final bool presente = alunoData['presente'] as bool? ?? false;
    final int faltas = alunoData['faltas'] as int? ?? 0;
    final int presencas = alunoData['presencas'] as int? ?? 0;

    return Card(
      elevation: 2,
      color: AppColors.card,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Foto do aluno
                  ClipOval(
                    child: Image.network(
                      image,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: AppColors.primaryDark.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.person,
                            size: 30,
                            color: AppColors.primaryDark,
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nome,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          turma,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Checkbox de presença
                  Checkbox(
                    activeColor: AppColors.success,
                    value: presente,
                    onChanged: (val) => onTogglePresenca(),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Status de presença
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color:
                      presente
                          ? AppColors.success.withValues(alpha: 0.1)
                          : AppColors.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  presente ? 'Presente' : 'Ausente',
                  style: TextStyle(
                    color: presente ? AppColors.success : AppColors.error,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Estatísticas de frequência
              Row(
                children: [
                  Expanded(
                    child: _StatItem(
                      icon: Icons.check_circle,
                      label: 'Presenças',
                      value: presencas.toString(),
                      color: AppColors.success,
                    ),
                  ),
                  Expanded(
                    child: _StatItem(
                      icon: Icons.cancel,
                      label: 'Faltas',
                      value: faltas.toString(),
                      color: AppColors.error,
                    ),
                  ),
                  Expanded(
                    child: _StatItem(
                      icon: Icons.percent,
                      label: 'Frequência',
                      value: '${_calcularFrequencia(presencas, faltas)}%',
                      color: AppColors.primaryDark,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _calcularFrequencia(int presencas, int faltas) {
    final total = presencas + faltas;
    if (total == 0) return 0;
    return ((presencas / total) * 100).round();
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
