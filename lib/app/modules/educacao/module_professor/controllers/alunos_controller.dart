import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../themes/app_colors.dart';

class AlunosController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredAlunos = [];
  String _currentFilter = 'todas';
  String _searchQuery = '';

  List<Map<String, dynamic>> get filteredAlunos => _filteredAlunos;

  final alunos = [
    {
      'nome': 'Lucas Martins',
      'turma': '5º Ano A',
      'idade': 10,
      'matricula': '2023A001',
    },
    {
      'nome': 'Julia Rocha',
      'turma': '4º Ano B',
      'idade': 9,
      'matricula': '2023B002',
    },
    {
      'nome': 'Pedro Henrique',
      'turma': '3º Ano C',
      'idade': 8,
      'matricula': '2023C003',
    },
    {
      'nome': 'Ana Beatriz',
      'turma': '5º Ano A',
      'idade': 10,
      'matricula': '2023A004',
    },
    {
      'nome': 'Carlos Eduardo',
      'turma': '2º Ano D',
      'idade': 7,
      'matricula': '2023D005',
    },
    {
      'nome': 'Mariana Silva',
      'turma': '1º Ano C',
      'idade': 6,
      'matricula': '2023C006',
    },
    {
      'nome': 'Rafael Lima',
      'turma': '3º Ano B',
      'idade': 8,
      'matricula': '2023B007',
    },
    {
      'nome': 'Isabela Fernandes',
      'turma': '4º Ano A',
      'idade': 9,
      'matricula': '2023A008',
    },
    {
      'nome': 'João Pedro',
      'turma': '5º Ano B',
      'idade': 10,
      'matricula': '2023B009',
    },
    {
      'nome': 'Laura Mendes',
      'turma': '2º Ano C',
      'idade': 7,
      'matricula': '2023C010',
    },
  ];

  @override
  void onInit() {
    super.onInit();
    _filteredAlunos = List.from(alunos);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  /// Buscar alunos por nome
  void searchAlunos(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilters();
  }

  /// Filtrar alunos por turma
  void filterByTurma(String filter) {
    _currentFilter = filter;
    _applyFilters();
  }

  /// Aplicar filtros de busca e turma
  void _applyFilters() {
    _filteredAlunos =
        alunos.where((aluno) {
          final nome = aluno['nome'].toString().toLowerCase();
          final turma = aluno['turma'].toString();

          // Aplicar filtro de busca
          final matchesSearch =
              _searchQuery.isEmpty || nome.contains(_searchQuery);

          // Aplicar filtro de turma
          bool matchesFilter = true;
          if (_currentFilter != 'todas') {
            matchesFilter = turma.contains(_currentFilter);
          }

          return matchesSearch && matchesFilter;
        }).toList();

    update();
  }

  /// Mostrar detalhes do aluno
  void showAlunoDetails(Map<String, dynamic> aluno) {
    final String nome = aluno['nome'];
    final String turma = aluno['turma'];
    final int idade = aluno['idade'];
    final String matricula = aluno['matricula'];

    Get.dialog(
      Dialog(
        child: Container(
          width: 500,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Cabeçalho com foto
              Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primaryDark.withValues(alpha: 0.3),
                        width: 4,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        _getAlunoFoto(nome),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: AppColors.primaryDark.withValues(
                                alpha: 0.1,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.person,
                              size: 50,
                              color: AppColors.primaryDark,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nome,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryDark.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            turma,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.primaryDark,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Informações detalhadas
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    _DetailRow(
                      label: 'Nome Completo:',
                      value: nome,
                      icon: Icons.person,
                    ),
                    const SizedBox(height: 12),
                    _DetailRow(
                      label: 'Turma:',
                      value: turma,
                      icon: Icons.school,
                      valueColor: AppColors.primaryDark,
                    ),
                    const SizedBox(height: 12),
                    _DetailRow(
                      label: 'Idade:',
                      value: '$idade anos',
                      icon: Icons.cake,
                    ),
                    const SizedBox(height: 12),
                    _DetailRow(
                      label: 'Matrícula:',
                      value: matricula,
                      icon: Icons.badge,
                      valueColor: Colors.grey.shade700,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Status do aluno
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.green.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Status: Ativo',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Aluno regularmente matriculado e frequentando as aulas.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.green.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Botões de ação
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Get.back();
                        // Navegar para o boletim do aluno
                        Get.snackbar(
                          'Boletim',
                          'Abrindo boletim de $nome...',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                      icon: const Icon(Icons.assignment),
                      label: const Text('Ver Boletim'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryDark,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Get.back();
                        // Navegar para a frequência do aluno
                        Get.snackbar(
                          'Frequência',
                          'Abrindo frequência de $nome...',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                      icon: const Icon(Icons.check_circle_outline),
                      label: const Text('Ver Frequência'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Get.back();
                        // Abrir contato do responsável
                        Get.snackbar(
                          'Contato',
                          'Abrindo contato do responsável de $nome...',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                      icon: const Icon(Icons.message),
                      label: const Text('Contato'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
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

  String _getAlunoFoto(String nome) {
    // Mapeamento de nomes para fotos de crianças
    final fotosMap = {
      'Lucas Martins': 'assets/images/children/child1.jpg',
      'Julia Rocha': 'assets/images/children/child2.jpg',
      'Pedro Henrique': 'assets/images/children/child3.jpg',
      'Ana Beatriz': 'assets/images/children/child4.jpg',
      'Carlos Eduardo': 'assets/images/children/child5.jpg',
      'Mariana Silva': 'assets/images/children/child6.jpg',
      'Rafael Lima': 'assets/images/children/child7.jpg',
      'Isabela Fernandes': 'assets/images/children/child8.jpg',
      'João Pedro': 'assets/images/children/child9.jpg',
      'Laura Mendes': 'assets/images/children/child10.jpg',
    };

    return fotosMap[nome] ?? 'assets/images/children/default_child.jpg';
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color? valueColor;

  const _DetailRow({
    required this.label,
    required this.value,
    required this.icon,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey.shade600),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: valueColor ?? AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
