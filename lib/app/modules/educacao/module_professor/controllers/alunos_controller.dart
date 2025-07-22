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
      'image':
          'https://tse3.mm.bing.net/th/id/OIP.lXIsTLMkqShuTbbW2jQKegHaHa?rs=1&pid=ImgDetMain&o=7&rm=3',
      'nome': 'Lucas Martins',
      'turma': '5º Ano A',
      'idade': 10,
      'matricula': '2023A001',
    },
    {
      'image':
          'https://tse4.mm.bing.net/th/id/OIP.nKB_3t2gQF-NOLCzp2M9vwAAAA?w=358&h=626&rs=1&pid=ImgDetMain&o=7&rm=3',
      'nome': 'Julia Rocha',
      'turma': '4º Ano B',
      'idade': 9,
      'matricula': '2023B002',
    },
    {
      'image':
          'https://tse4.mm.bing.net/th/id/OIP.dEhIq6xfut-aue6lZMHSXAHaHa?w=626&h=626&rs=1&pid=ImgDetMain&o=7&rm=3',
      'nome': 'Pedro Henrique',
      'turma': '3º Ano C',
      'idade': 8,
      'matricula': '2023C003',
    },
    {
      'image':
          'https://tse3.mm.bing.net/th/id/OIP.vxAd-FRBhU0KhqLMgy8CEAHaNJ?rs=1&pid=ImgDetMain&o=7&rm=3',
      'nome': 'Ana Beatriz',
      'turma': '5º Ano A',
      'idade': 10,
      'matricula': '2023A004',
    },
    {
      'image': '',
      'nome': 'Carlos Eduardo',
      'turma': '2º Ano D',
      'idade': 7,
      'matricula': '2023D005',
    },
    {
      'image':
          'https://th.bing.com/th/id/OIP.9fcs_Xvf2H4Qh058C4xcsAAAAA?o=7rm=3&rs=1&pid=ImgDetMain&o=7&rm=3',
      'nome': 'Mariana Silva',
      'turma': '1º Ano C',
      'idade': 6,
      'matricula': '2023C006',
    },
    {
      'image':
          'https://media.istockphoto.com/id/474947550/pt/foto/menino-de-cinco-anos-de-idade.jpg?s=612x612&w=0&k=20&c=q0xh4Pe7qC_PSfGbop3zWZM2fqWqsAs2jFlevkrduCE=',
      'nome': 'Rafael Lima',
      'turma': '3º Ano B',
      'idade': 8,
      'matricula': '2023B007',
    },
    {
      'image':
          'https://tse4.mm.bing.net/th/id/OIP.DWrtPjqB5mJIVoG5a4EjJQHaE8?w=626&h=418&rs=1&pid=ImgDetMain&o=7&rm=3',
      'nome': 'Isabela Fernandes',
      'turma': '4º Ano A',
      'idade': 9,
      'matricula': '2023A008',
    },
    {
      'image':
          'https://tse2.mm.bing.net/th/id/OIP.rpQ2kvyeoNebXgZOMN3LkAHaE7?rs=1&pid=ImgDetMain&o=7&rm=3',
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
    final String image = aluno['image'];
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
                      child: Image.network(
                        image,
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

  //   String _getAlunoFoto(String nome) {
  //     // Mapeamento de nomes para fotos de crianças usando URLs confiáveis
  //     final fotosMap = {
  //       'Lucas Martins':
  //           'https://api.dicebear.com/7.x/avataaars/svg?seed=Lucas&backgroundColor=b6e3f4',
  //       'Julia Rocha':
  //           'https://api.dicebear.com/7.x/avataaars/svg?seed=Julia&backgroundColor=ffdfbf',
  //       'Pedro Henrique':
  //           'https://api.dicebear.com/7.x/avataaars/svg?seed=Pedro&backgroundColor=c0aede',
  //       'Ana Beatriz':
  //           'https://api.dicebear.com/7.x/avataaars/svg?seed=Ana&backgroundColor=ffd5dc',
  //       'Carlos Eduardo':
  //           'https://api.dicebear.com/7.x/avataaars/svg?seed=Carlos&backgroundColor=b6e3f4',
  //       'Mariana Silva':
  //           'https://api.dicebear.com/7.x/avataaars/svg?seed=Mariana&backgroundColor=ffdfbf',
  //       'Rafael Lima':
  //           'https://api.dicebear.com/7.x/avataaars/svg?seed=Rafael&backgroundColor=c0aede',
  //       'Isabela Fernandes':
  //           'https://api.dicebear.com/7.x/avataaars/svg?seed=Isabela&backgroundColor=ffd5dc',
  //       'João Pedro':
  //           'https://api.dicebear.com/7.x/avataaars/svg?seed=Joao&backgroundColor=b6e3f4',
  //       'Laura Mendes':
  //           'https://api.dicebear.com/7.x/avataaars/svg?seed=Laura&backgroundColor=ffdfbf',
  //     };

  //     return fotosMap[nome] ??
  //         'https://api.dicebear.com/7.x/avataaars/svg?seed=Default&backgroundColor=b6e3f4';
  //   }
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
