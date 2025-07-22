import 'package:flutter/material.dart';
import 'package:minha_gestao_inteligente_painel/app/themes/app_colors.dart';

class BoletimStatsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> boletins;

  const BoletimStatsWidget({super.key, required this.boletins});

  @override
  Widget build(BuildContext context) {
    final stats = _calculateStats();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Estatísticas da Turma',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  title: 'Total de Alunos',
                  value: stats['totalAlunos'].toString(),
                  icon: Icons.people,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  title: 'Média da Turma',
                  value: stats['mediaTurma'].toStringAsFixed(2),
                  icon: Icons.trending_up,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  title: 'Melhor Média',
                  value: stats['melhorMedia'].toStringAsFixed(2),
                  icon: Icons.star,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  title: 'Menor Média',
                  value: stats['menorMedia'].toStringAsFixed(2),
                  icon: Icons.warning,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Distribuição por Desempenho',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _PerformanceBar(
                  label: 'Excelente',
                  count: stats['excelente'],
                  total: stats['totalAlunos'],
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _PerformanceBar(
                  label: 'Bom',
                  count: stats['bom'],
                  total: stats['totalAlunos'],
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _PerformanceBar(
                  label: 'Regular',
                  count: stats['regular'],
                  total: stats['totalAlunos'],
                  color: Colors.orange,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _PerformanceBar(
                  label: 'Baixo',
                  count: stats['baixo'],
                  total: stats['totalAlunos'],
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _calculateStats() {
    if (boletins.isEmpty) {
      return {
        'totalAlunos': 0,
        'mediaTurma': 0.0,
        'melhorMedia': 0.0,
        'menorMedia': 0.0,
        'excelente': 0,
        'bom': 0,
        'regular': 0,
        'baixo': 0,
      };
    }

    double somaMedias = 0;
    double melhorMedia = 0;
    double menorMedia = 10;
    int excelente = 0;
    int bom = 0;
    int regular = 0;
    int baixo = 0;

    for (final boletim in boletins) {
      final mediaGeral = _calculateMediaGeral(boletim);
      somaMedias += mediaGeral;

      if (mediaGeral > melhorMedia) melhorMedia = mediaGeral;
      if (mediaGeral < menorMedia) menorMedia = mediaGeral;

      if (mediaGeral >= 9.0) {
        excelente++;
      } else if (mediaGeral >= 7.0) {
        bom++;
      } else if (mediaGeral >= 6.0) {
        regular++;
      } else {
        baixo++;
      }
    }

    return {
      'totalAlunos': boletins.length,
      'mediaTurma': somaMedias / boletins.length,
      'melhorMedia': melhorMedia,
      'menorMedia': menorMedia,
      'excelente': excelente,
      'bom': bom,
      'regular': regular,
      'baixo': baixo,
    };
  }

  double _calculateMediaGeral(Map<String, dynamic> boletim) {
    final Map<String, dynamic> materias = boletim['boletim'];
    double somaMedias = 0;
    int totalMaterias = 0;

    materias.forEach((materia, dados) {
      if (dados is Map && dados['media'] != null) {
        somaMedias += dados['media'];
        totalMaterias++;
      }
    });

    return totalMaterias > 0 ? somaMedias / totalMaterias : 0;
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(fontSize: 12, color: color.withValues(alpha: 0.8)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _PerformanceBar extends StatelessWidget {
  final String label;
  final int count;
  final int total;
  final Color color;

  const _PerformanceBar({
    required this.label,
    required this.count,
    required this.total,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = total > 0 ? count / total : 0.0;

    return Column(
      children: [
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(4),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: percentage,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '$label\n($count)',
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
