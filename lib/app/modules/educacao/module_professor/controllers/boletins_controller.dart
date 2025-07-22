import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../themes/app_colors.dart';

class BoletinsController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredBoletins = [];
  String _currentFilter = 'todos';
  String _searchQuery = '';

  List<Map<String, dynamic>> get filteredBoletins => _filteredBoletins;

  final boletins = [
    {
      'image':
          'https://tse3.mm.bing.net/th/id/OIP.lXIsTLMkqShuTbbW2jQKegHaHa?rs=1&pid=ImgDetMain&o=7&rm=3',
      'aluno': 'Lucas Martins',
      'boletim': {
        'Matemática': {
          'notas': [8.0, 7.5, 9.0, 8.5],
          'media': 8.25,
        },
        'Português': {
          'notas': [9.0, 8.5, 9.5, 9.0],
          'media': 9.0,
        },
        'História': {
          'notas': [7.0, 6.5, 8.0, 7.5],
          'media': 7.25,
        },
        'Geografia': {
          'notas': [8.5, 9.0, 8.0, 9.5],
          'media': 8.75,
        },
        'Ciências': {
          'notas': [9.0, 8.8, 8.5, 9.0],
          'media': 8.83,
        },
      },
    },
    {
      'image':
          'https://tse4.mm.bing.net/th/id/OIP.nKB_3t2gQF-NOLCzp2M9vwAAAA?w=358&h=626&rs=1&pid=ImgDetMain&o=7&rm=3',
      'aluno': 'Julia Rocha',
      'boletim': {
        'Matemática': {
          'notas': [9.5, 9.0, 8.5, 9.0],
          'media': 9.0,
        },
        'Português': {
          'notas': [8.5, 9.0, 9.5, 10.0],
          'media': 9.25,
        },
        'História': {
          'notas': [7.5, 8.0, 7.0, 8.5],
          'media': 7.75,
        },
        'Geografia': {
          'notas': [9.0, 9.0, 9.0, 9.0],
          'media': 9.0,
        },
        'Ciências': {
          'notas': [8.0, 8.5, 9.0, 8.5],
          'media': 8.5,
        },
      },
    },
    {
      'image':
          'https://tse4.mm.bing.net/th/id/OIP.dEhIq6xfut-aue6lZMHSXAHaHa?w=626&h=626&rs=1&pid=ImgDetMain&o=7&rm=3',
      'aluno': 'Pedro Henrique',
      'boletim': {
        'Matemática': {
          'notas': [6.5, 7.0, 6.0, 7.5],
          'media': 6.75,
        },
        'Português': {
          'notas': [7.0, 6.5, 7.5, 8.0],
          'media': 7.25,
        },
        'História': {
          'notas': [5.5, 6.0, 6.5, 7.0],
          'media': 6.25,
        },
        'Geografia': {
          'notas': [6.0, 6.5, 7.0, 6.5],
          'media': 6.5,
        },
        'Ciências': {
          'notas': [7.5, 7.0, 8.0, 7.5],
          'media': 7.5,
        },
      },
    },
    {
      'image':
          'https://tse3.mm.bing.net/th/id/OIP.vxAd-FRBhU0KhqLMgy8CEAHaNJ?rs=1&pid=ImgDetMain&o=7&rm=3',
      'aluno': 'Ana Beatriz',
      'boletim': {
        'Matemática': {
          'notas': [10.0, 9.5, 9.0, 10.0],
          'media': 9.625,
        },
        'Português': {
          'notas': [9.5, 9.0, 9.5, 9.0],
          'media': 9.25,
        },
        'História': {
          'notas': [8.5, 9.0, 9.0, 9.5],
          'media': 9.0,
        },
        'Geografia': {
          'notas': [9.5, 9.0, 9.5, 10.0],
          'media': 9.5,
        },
        'Ciências': {
          'notas': [10.0, 10.0, 9.5, 9.0],
          'media': 9.625,
        },
      },
    },
    {
      'aluno': 'Carlos Eduardo',
      'boletim': {
        'Matemática': {
          'notas': [6.0, 5.5, 6.5, 6.0],
          'media': 6.0,
        },
        'Português': {
          'notas': [6.5, 7.0, 6.0, 6.5],
          'media': 6.5,
        },
        'História': {
          'notas': [5.0, 6.0, 5.5, 6.0],
          'media': 5.625,
        },
        'Geografia': {
          'notas': [6.5, 7.0, 6.5, 7.0],
          'media': 6.75,
        },
        'Ciências': {
          'notas': [7.0, 6.5, 7.5, 6.0],
          'media': 6.75,
        },
      },
    },
    {
      'image':
          'https://th.bing.com/th/id/OIP.9fcs_Xvf2H4Qh058C4xcsAAAAA?o=7rm=3&rs=1&pid=ImgDetMain&o=7&rm=3',
      'aluno': 'Mariana Silva',
      'boletim': {
        'Matemática': {
          'notas': [9.0, 9.0, 9.0, 9.0],
          'media': 9.0,
        },
        'Português': {
          'notas': [8.0, 8.5, 9.0, 9.5],
          'media': 8.75,
        },
        'História': {
          'notas': [7.0, 7.5, 8.0, 8.5],
          'media': 7.75,
        },
        'Geografia': {
          'notas': [8.0, 8.5, 8.0, 8.5],
          'media': 8.25,
        },
        'Ciências': {
          'notas': [9.0, 9.0, 9.0, 9.0],
          'media': 9.0,
        },
      },
    },
    {
      'image':
          'https://media.istockphoto.com/id/474947550/pt/foto/menino-de-cinco-anos-de-idade.jpg?s=612x612&w=0&k=20&c=q0xh4Pe7qC_PSfGbop3zWZM2fqWqsAs2jFlevkrduCE=',
      'aluno': 'Rafael Lima',
      'boletim': {
        'Matemática': {
          'notas': [7.0, 7.0, 6.5, 7.5],
          'media': 7.0,
        },
        'Português': {
          'notas': [8.0, 7.5, 8.0, 8.5],
          'media': 8.0,
        },
        'História': {
          'notas': [6.5, 7.0, 6.0, 7.0],
          'media': 6.625,
        },
        'Geografia': {
          'notas': [7.5, 7.0, 7.5, 8.0],
          'media': 7.5,
        },
        'Ciências': {
          'notas': [8.0, 8.5, 8.0, 8.0],
          'media': 8.125,
        },
      },
    },
    {
      'image':
          'https://tse4.mm.bing.net/th/id/OIP.DWrtPjqB5mJIVoG5a4EjJQHaE8?w=626&h=418&rs=1&pid=ImgDetMain&o=7&rm=3',
      'aluno': 'Isabela Fernandes',
      'boletim': {
        'Matemática': {
          'notas': [9.0, 9.0, 9.5, 9.5],
          'media': 9.25,
        },
        'Português': {
          'notas': [9.0, 9.5, 9.5, 10.0],
          'media': 9.5,
        },
        'História': {
          'notas': [8.5, 9.0, 9.0, 9.5],
          'media': 9.0,
        },
        'Geografia': {
          'notas': [9.5, 10.0, 10.0, 9.5],
          'media': 9.75,
        },
        'Ciências': {
          'notas': [9.0, 9.0, 9.5, 10.0],
          'media': 9.375,
        },
      },
    },
    {
      'image':
          'https://tse2.mm.bing.net/th/id/OIP.rpQ2kvyeoNebXgZOMN3LkAHaE7?rs=1&pid=ImgDetMain&o=7&rm=3',
      'aluno': 'João Pedro',
      'boletim': {
        'Matemática': {
          'notas': [8.0, 8.5, 8.5, 9.0],
          'media': 8.5,
        },
        'Português': {
          'notas': [7.5, 8.0, 7.5, 8.5],
          'media': 7.875,
        },
        'História': {
          'notas': [7.0, 7.0, 7.5, 7.0],
          'media': 7.125,
        },
        'Geografia': {
          'notas': [8.0, 7.5, 8.5, 8.0],
          'media': 8.0,
        },
        'Ciências': {
          'notas': [8.5, 9.0, 8.5, 9.0],
          'media': 8.75,
        },
      },
    },
    {
      'aluno': 'Laura Mendes',
      'boletim': {
        'Matemática': {
          'notas': [6.5, 7.0, 6.0, 7.0],
          'media': 6.625,
        },
        'Português': {
          'notas': [6.0, 6.5, 7.0, 6.5],
          'media': 6.5,
        },
        'História': {
          'notas': [6.0, 6.5, 6.0, 6.5],
          'media': 6.25,
        },
        'Geografia': {
          'notas': [7.0, 6.5, 7.0, 6.5],
          'media': 6.75,
        },
        'Ciências': {
          'notas': [7.5, 7.0, 7.5, 8.0],
          'media': 7.5,
        },
      },
    },
    {
      'aluno': 'Gabriel Souza',
      'boletim': {
        'Matemática': {
          'notas': [8.0, 7.5, 8.0, 8.5],
          'media': 8.0,
        },
        'Português': {
          'notas': [7.5, 8.0, 7.5, 8.5],
          'media': 7.875,
        },
        'História': {
          'notas': [7.0, 6.5, 7.0, 6.5],
          'media': 6.75,
        },
        'Geografia': {
          'notas': [8.0, 7.5, 8.0, 7.5],
          'media': 7.75,
        },
        'Ciências': {
          'notas': [8.5, 8.0, 8.5, 8.5],
          'media': 8.375,
        },
      },
    },
    {
      'aluno': 'Beatriz Costa',
      'boletim': {
        'Matemática': {
          'notas': [9.0, 9.5, 9.0, 10.0],
          'media': 9.375,
        },
        'Português': {
          'notas': [10.0, 10.0, 9.5, 10.0],
          'media': 9.875,
        },
        'História': {
          'notas': [9.0, 9.5, 9.0, 9.5],
          'media': 9.25,
        },
        'Geografia': {
          'notas': [9.5, 9.0, 9.5, 10.0],
          'media': 9.5,
        },
        'Ciências': {
          'notas': [10.0, 10.0, 9.5, 9.5],
          'media': 9.75,
        },
      },
    },
  ];

  @override
  void onInit() {
    super.onInit();
    _filteredBoletins = List.from(boletins);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  /// Buscar boletins por nome do aluno
  void searchBoletins(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilters();
  }

  /// Filtrar boletins por média
  void filterByMedia(String filter) {
    _currentFilter = filter;
    _applyFilters();
  }

  /// Aplicar filtros de busca e média
  void _applyFilters() {
    _filteredBoletins =
        boletins.where((boletim) {
          final aluno = boletim['aluno'].toString().toLowerCase();
          final mediaGeral = _calculateMediaGeral(boletim);

          // Aplicar filtro de busca
          final matchesSearch =
              _searchQuery.isEmpty || aluno.contains(_searchQuery);

          // Aplicar filtro de média
          bool matchesFilter = true;
          switch (_currentFilter) {
            case 'excelente':
              matchesFilter = mediaGeral >= 9.0;
              break;
            case 'bom':
              matchesFilter = mediaGeral >= 7.0 && mediaGeral < 9.0;
              break;
            case 'regular':
              matchesFilter = mediaGeral >= 6.0 && mediaGeral < 7.0;
              break;
            case 'baixo':
              matchesFilter = mediaGeral < 6.0;
              break;
            case 'todos':
            default:
              matchesFilter = true;
              break;
          }

          return matchesSearch && matchesFilter;
        }).toList();

    update();
  }

  /// Calcular média geral do boletim
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

  /// Mostrar detalhes do boletim
  void showBoletimDetails(Map<String, dynamic> boletim) {
    final String aluno = boletim['aluno'];
    final Map<String, dynamic> materias = boletim['boletim'];
    final double mediaGeral = _calculateMediaGeral(boletim);

    Get.dialog(
      Dialog(
        child: Container(
          width: 600,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(15),
          ),

          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabeçalho
              Row(
                children: [
                  const Icon(Icons.assignment, size: 32, color: Colors.blue),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Boletim de $aluno',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Média Geral: ${mediaGeral.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16,
                            color: _getMediaColor(mediaGeral),
                            fontWeight: FontWeight.w600,
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

              const SizedBox(height: 20),

              // Tabela de notas
              Flexible(
                child: SingleChildScrollView(
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Matéria')),
                      DataColumn(label: Text('Notas')),
                      DataColumn(label: Text('Média')),
                      DataColumn(label: Text('Status')),
                    ],
                    rows:
                        materias.entries.map((entry) {
                          final String materia = entry.key;
                          final Map<String, dynamic> dados = entry.value;
                          final List<double> notas = List<double>.from(
                            dados['notas'] ?? [],
                          );
                          final double media = dados['media'] ?? 0.0;

                          return DataRow(
                            cells: [
                              DataCell(Text(materia)),
                              DataCell(
                                Text(
                                  notas
                                      .map((n) => n.toStringAsFixed(1))
                                      .join(', '),
                                ),
                              ),
                              DataCell(
                                Text(
                                  media.toStringAsFixed(2),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: _getMediaColor(media),
                                  ),
                                ),
                              ),
                              DataCell(
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getMediaColor(media),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    _getStatusText(media),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Botões de ação
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text(
                      'Fechar',
                      style: TextStyle(color: AppColors.textPrimary),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Aqui você pode implementar a impressão ou exportação
                      Get.snackbar(
                        'Sucesso',
                        'Boletim exportado com sucesso!',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                    icon: const Icon(Icons.print),
                    label: const Text(
                      'Imprimir',
                      style: TextStyle(color: AppColors.textPrimary),
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

  Color _getMediaColor(double media) {
    if (media >= 9.0) return Colors.green;
    if (media >= 7.0) return Colors.blue;
    if (media >= 6.0) return Colors.orange;
    return Colors.red;
  }

  String _getStatusText(double media) {
    if (media >= 9.0) return 'Excelente';
    if (media >= 7.0) return 'Bom';
    if (media >= 6.0) return 'Regular';
    return 'Baixo';
  }
}
