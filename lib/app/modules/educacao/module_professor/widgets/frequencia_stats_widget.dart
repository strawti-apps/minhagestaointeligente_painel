import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';

class FrequenciaStatsWidget extends StatelessWidget {
  final Map<String, dynamic> estatisticas;

  const FrequenciaStatsWidget({super.key, required this.estatisticas});

  @override
  Widget build(BuildContext context) {
    final totalAlunos = estatisticas['totalAlunos'] as int;
    final presentes = estatisticas['presentes'] as int;
    final ausentes = estatisticas['ausentes'] as int;
    final percentualPresenca = estatisticas['percentualPresenca'] as double;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.people, color: AppColors.primaryDark, size: 24),
              const SizedBox(width: 8),
              const Text(
                'Estatísticas de Frequência',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  icon: Icons.people,
                  label: 'Total de Alunos',
                  value: totalAlunos.toString(),
                  color: AppColors.primaryDark,
                ),
              ),
              SizedBox(width: 2),
              Expanded(
                child: _StatCard(
                  icon: Icons.check_circle,
                  label: 'Presentes',
                  value: presentes.toString(),
                  color: AppColors.success,
                ),
              ),
              SizedBox(width: 2),
              Expanded(
                child: _StatCard(
                  icon: Icons.cancel,
                  label: 'Ausentes',
                  value: ausentes.toString(),
                  color: AppColors.error,
                ),
              ),
              SizedBox(width: 2),
              Expanded(
                child: _StatCard(
                  icon: Icons.percent,
                  label: 'Frequência Geral',
                  value: '${percentualPresenca.round()}%',
                  color: AppColors.primaryDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Barra de progresso da frequência
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Taxa de Frequência',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    '${percentualPresenca.round()}%',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: percentualPresenca / 100,
                backgroundColor: AppColors.textSecondary.withValues(alpha: 0.2),
                valueColor: AlwaysStoppedAnimation<Color>(
                  percentualPresenca >= 80
                      ? AppColors.success
                      : percentualPresenca >= 60
                      ? Colors.orange
                      : AppColors.error,
                ),
                minHeight: 8,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _PerformanceIndicator(
                    label: 'Excelente',
                    color: AppColors.success,
                    threshold: 80,
                    current: percentualPresenca,
                  ),
                  _PerformanceIndicator(
                    label: 'Boa',
                    color: Colors.orange,
                    threshold: 60,
                    current: percentualPresenca,
                  ),
                  _PerformanceIndicator(
                    label: 'Baixa',
                    color: AppColors.error,
                    threshold: 0,
                    current: percentualPresenca,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _PerformanceIndicator extends StatelessWidget {
  final String label;
  final Color color;
  final double threshold;
  final double current;

  const _PerformanceIndicator({
    required this.label,
    required this.color,
    required this.threshold,
    required this.current,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = current >= threshold;

    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color:
                isActive
                    ? color
                    : AppColors.textSecondary.withValues(alpha: 0.3),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color:
                isActive
                    ? color
                    : AppColors.textSecondary.withValues(alpha: 0.5),
            fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
