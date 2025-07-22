import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/mixins/loader_manager.dart';
import '../../../../themes/app_colors.dart';

class FrequenciaAlunoController extends GetxController with LoaderManager {
  final searchController = TextEditingController();
  final filterController = TextEditingController();

  List<Map<String, dynamic>> alunos = [];
  List<Map<String, dynamic>> filteredAlunos = [];

  String selectedFilter = 'Todas as Turmas';
  List<String> turmas = ['Todas as Turmas'];

  @override
  void onInit() {
    super.onInit();
    _initializeAlunos();
    _applyFilters();
  }

  void _initializeAlunos() {
    alunos = [
      {
        'image':
            'https://tse3.mm.bing.net/th/id/OIP.lXIsTLMkqShuTbbW2jQKegHaHa?rs=1&pid=ImgDetMain&o=7&rm=3',
        'nome': 'Lucas Martins',
        'turma': '5º Ano A',
        'presente': true,
        'faltas': 2,
        'presencas': 18,
      },
      {
        'image':
            'https://tse4.mm.bing.net/th/id/OIP.nKB_3t2gQF-NOLCzp2M9vwAAAA?w=358&h=626&rs=1&pid=ImgDetMain&o=7&rm=3',
        'nome': 'Julia Rocha',
        'turma': '4º Ano B',
        'presente': false,
        'faltas': 5,
        'presencas': 15,
      },
      {
        'image':
            'https://tse4.mm.bing.net/th/id/OIP.dEhIq6xfut-aue6lZMHSXAHaHa?w=626&h=626&rs=1&pid=ImgDetMain&o=7&rm=3',
        'nome': 'Pedro Henrique',
        'turma': '3º Ano C',
        'presente': true,
        'faltas': 1,
        'presencas': 19,
      },
      {
        'image':
            'https://tse3.mm.bing.net/th/id/OIP.vxAd-FRBhU0KhqLMgy8CEAHaNJ?rs=1&pid=ImgDetMain&o=7&rm=3',
        'nome': 'Ana Beatriz',
        'turma': '5º Ano A',
        'presente': false,
        'faltas': 3,
        'presencas': 17,
      },
      {
        'image':
            'https://th.bing.com/th/id/OIP.9fcs_Xvf2H4Qh058C4xcsAAAAA?o=7rm=3&rs=1&pid=ImgDetMain&o=7&rm=3',
        'nome': 'Mariana Silva',
        'turma': '1º Ano C',
        'presente': false,
        'faltas': 4,
        'presencas': 16,
      },
      {
        'image':
            'https://media.istockphoto.com/id/474947550/pt/foto/menino-de-cinco-anos-de-idade.jpg?s=612x612&w=0&k=20&c=q0xh4Pe7qC_PSfGbop3zWZM2fqWqsAs2jFlevkrduCE=',
        'nome': 'Rafael Lima',
        'turma': '3º Ano B',
        'presente': true,
        'faltas': 1,
        'presencas': 19,
      },
      {
        'image':
            'https://tse4.mm.bing.net/th/id/OIP.DWrtPjqB5mJIVoG5a4EjJQHaE8?w=626&h=418&rs=1&pid=ImgDetMain&o=7&rm=3',
        'nome': 'Isabela Fernandes',
        'turma': '4º Ano A',
        'presente': true,
        'faltas': 2,
        'presencas': 18,
      },
      {
        'image':
            'https://tse2.mm.bing.net/th/id/OIP.rpQ2kvyeoNebXgZOMN3LkAHaE7?rs=1&pid=ImgDetMain&o=7&rm=3',
        'nome': 'João Pedro',
        'turma': '5º Ano B',
        'presente': false,
        'faltas': 6,
        'presencas': 14,
      },
      {
        'nome': 'Laura Mendes',
        'turma': '2º Ano C',
        'presente': true,
        'faltas': 1,
        'presencas': 19,
      },
    ];

    // Extrair turmas únicas
    final turmasUnicas =
        alunos.map((aluno) => aluno['turma'] as String).toSet().toList();
    turmas.addAll(turmasUnicas);
  }

  void _applyFilters() {
    filteredAlunos =
        alunos.where((aluno) {
          final nome = (aluno['nome'] as String).toLowerCase();
          final turma = (aluno['turma'] as String).toLowerCase();
          final searchTerm = searchController.text.toLowerCase();
          final filterTerm = selectedFilter.toLowerCase();

          final matchesSearch =
              searchTerm.isEmpty ||
              nome.contains(searchTerm) ||
              turma.contains(searchTerm);

          final matchesFilter =
              selectedFilter == 'Todas as Turmas' || turma.contains(filterTerm);

          return matchesSearch && matchesFilter;
        }).toList();

    update();
  }

  void onSearchChanged(String value) {
    _applyFilters();
  }

  void onFilterChanged(String? value) {
    if (value != null) {
      selectedFilter = value;
      _applyFilters();
    }
  }

  void togglePresenca(int index) {
    final alunoIndex = alunos.indexWhere(
      (aluno) => aluno['nome'] == filteredAlunos[index]['nome'],
    );

    if (alunoIndex != -1) {
      final isPresente = alunos[alunoIndex]['presente'] as bool;
      alunos[alunoIndex]['presente'] = !isPresente;

      if (isPresente) {
        alunos[alunoIndex]['faltas'] =
            (alunos[alunoIndex]['faltas'] as int) + 1;
        alunos[alunoIndex]['presencas'] =
            (alunos[alunoIndex]['presencas'] as int) - 1;
      } else {
        alunos[alunoIndex]['faltas'] =
            (alunos[alunoIndex]['faltas'] as int) - 1;
        alunos[alunoIndex]['presencas'] =
            (alunos[alunoIndex]['presencas'] as int) + 1;
      }

      _applyFilters();
    }
  }

  void showAlunoDetails(Map<String, dynamic> aluno) {
    final String image = aluno['image'];
    final String nome = aluno['nome'];
    final String turma = aluno['turma'];
    final bool presente = aluno['presente'] as bool;
    final int faltas = aluno['faltas'] as int;
    final int presencas = aluno['presencas'] as int;
    final int total = presencas + faltas;
    final double frequencia = total > 0 ? (presencas / total * 100) : 0;

    Get.dialog(
      Dialog(
        child: Container(
          width: 400,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Cabeçalho
              Row(
                children: [
                  Icon(Icons.person, color: AppColors.primaryDark, size: 24),
                  const SizedBox(width: 8),
                  const Text(
                    'Detalhes do Aluno',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Foto e informações básicas
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: presente ? AppColors.success : AppColors.error,
                        width: 3,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.network(
                        image,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: AppColors.primaryDark.withValues(
                                alpha: 0.1,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.person,
                              size: 40,
                              color: AppColors.primaryDark,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nome,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          turma,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 8),
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
                            presente ? 'Presente Hoje' : 'Ausente Hoje',
                            style: TextStyle(
                              color:
                                  presente
                                      ? AppColors.success
                                      : AppColors.error,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Estatísticas detalhadas
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _DetailStat(
                            icon: Icons.check_circle,
                            label: 'Presenças',
                            value: presencas.toString(),
                            color: AppColors.success,
                          ),
                        ),
                        Expanded(
                          child: _DetailStat(
                            icon: Icons.cancel,
                            label: 'Faltas',
                            value: faltas.toString(),
                            color: AppColors.error,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _DetailStat(
                            icon: Icons.calendar_today,
                            label: 'Total de Aulas',
                            value: total.toString(),
                            color: AppColors.primaryDark,
                          ),
                        ),
                        Expanded(
                          child: _DetailStat(
                            icon: Icons.percent,
                            label: 'Frequência',
                            value: '${frequencia.round()}%',
                            color: AppColors.primaryDark,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Barra de progresso da frequência
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Taxa de Frequência',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: frequencia / 100,
                    backgroundColor: AppColors.textSecondary.withValues(
                      alpha: 0.2,
                    ),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      frequencia >= 80
                          ? AppColors.success
                          : frequencia >= 60
                          ? Colors.orange
                          : AppColors.error,
                    ),
                    minHeight: 8,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '0%',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        '${frequencia.round()}%',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryDark,
                        ),
                      ),
                      Text(
                        '100%',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> getEstatisticas() {
    final totalAlunos = filteredAlunos.length;
    final presentes =
        filteredAlunos.where((aluno) => aluno['presente'] as bool).length;
    final ausentes = totalAlunos - presentes;
    final percentualPresenca =
        totalAlunos > 0 ? (presentes / totalAlunos * 100) : 0.0;

    return {
      'totalAlunos': totalAlunos,
      'presentes': presentes,
      'ausentes': ausentes,
      'percentualPresenca': percentualPresenca,
    };
  }

  @override
  void onClose() {
    searchController.dispose();
    filterController.dispose();
    super.onClose();
  }
}

class _DetailStat extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _DetailStat({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Text(
          label,
          style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
