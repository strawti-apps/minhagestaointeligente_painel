import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minha_gestao_inteligente_painel/app/shared/widgets/app_button_default.dart';

import '../../../../shared/mixins/loader_manager.dart';
import '../../../../themes/app_colors.dart';

class ReceitasController extends GetxController with LoaderManager {
  final searchController = TextEditingController();
  final filterController = TextEditingController();

  List<Map<String, dynamic>> receitas = [];
  List<Map<String, dynamic>> filteredReceitas = [];

  String selectedFilter = 'Todas as Especialidades';
  List<String> especialidades = ['Todas as Especialidades'];

  @override
  void onInit() {
    super.onInit();
    _initializeReceitas();
    _applyFilters();
  }

  void _initializeReceitas() {
    receitas = [
      {
        'id': 'REC001',
        'data': '2024-01-15',
        'paciente': {
          'nome': 'Maria Silva Santos',
          'idade': 45,
          'especialidade': 'Cardiologia',
          'image':
              'https://api.dicebear.com/7.x/avataaars/svg?seed=Maria&backgroundColor=ffd5dc',
        },
        'medicamentos': [
          {'nome': 'Atenolol 50mg', 'posologia': '1 comprimido 2x ao dia'},
          {'nome': 'Losartana 50mg', 'posologia': '1 comprimido 1x ao dia'},
        ],
        'observacoes':
            'Tomar os medicamentos sempre no mesmo horário. Retornar em 30 dias.',
        'status': 'Ativa',
      },
      {
        'id': 'REC002',
        'data': '2024-01-20',
        'paciente': {
          'nome': 'João Carlos Oliveira',
          'idade': 62,
          'especialidade': 'Ortopedia',
          'image':
              'https://st2.depositphotos.com/1075946/7097/i/600/depositphotos_70978195-stock-photo-attractive-50-year-old-man.jpg',
        },
        'medicamentos': [
          {
            'nome': 'Dipirona 500mg',
            'posologia': '1 comprimido 4x ao dia se dor',
          },
          {'nome': 'Ibuprofeno 600mg', 'posologia': '1 comprimido 3x ao dia'},
        ],
        'observacoes':
            'Medicamentos para controle da dor pós-operatória. Usar gelo local.',
        'status': 'Ativa',
      },
      {
        'id': 'REC003',
        'data': '2024-01-18',
        'paciente': {
          'nome': 'Ana Paula Costa',
          'idade': 28,
          'especialidade': 'Ginecologia',
          'image':
              'https://tse3.mm.bing.net/th/id/OIP.aJ4VKK2ohav-CmqsHPcq-wAAAA?rs=1&pid=ImgDetMain&o=7&rm=3',
        },
        'medicamentos': [
          {'nome': 'Ácido Fólico 5mg', 'posologia': '1 comprimido 1x ao dia'},
          {'nome': 'Vitamina D 1000UI', 'posologia': '1 cápsula 1x ao dia'},
        ],
        'observacoes':
            'Suplementação vitamínica. Manter alimentação balanceada.',
        'status': 'Ativa',
      },
      {
        'id': 'REC004',
        'data': '2024-01-22',
        'paciente': {
          'nome': 'Pedro Henrique Lima',
          'idade': 35,
          'especialidade': 'Dermatologia',
          'image':
              'https://cdn.folhape.com.br/upload/dn_arquivo/2023/10/priscila-enquadramento-capa_2.jpg',
        },
        'medicamentos': [
          {'nome': 'Pomada Betametasona', 'posologia': 'Aplicar 2x ao dia'},
          {'nome': 'Cetoconazol 200mg', 'posologia': '1 comprimido 1x ao dia'},
        ],
        'observacoes': 'Manter a área limpa e seca. Evitar exposição solar.',
        'status': 'Ativa',
      },
      {
        'id': 'REC005',
        'data': '2024-01-25',
        'paciente': {
          'nome': 'Lúcia Ferreira',
          'idade': 55,
          'especialidade': 'Endocrinologia',
          'image':
              'https://tse2.mm.bing.net/th/id/OIP.1Qu77Ol87z6l-UWtYN73owAAAA?rs=1&pid=ImgDetMain&o=7&rm=3',
        },
        'medicamentos': [
          {'nome': 'Metformina 850mg', 'posologia': '1 comprimido 2x ao dia'},
          {'nome': 'Glicazida 80mg', 'posologia': '1 comprimido 1x ao dia'},
        ],
        'observacoes':
            'Controlar glicemia regularmente. Manter dieta hipoglicêmica.',
        'status': 'Ativa',
      },
    ];

    // Extrair especialidades únicas
    final especialidadesUnicas =
        receitas
            .map((receita) => receita['paciente']['especialidade'] as String)
            .toSet()
            .toList();
    especialidades.addAll(especialidadesUnicas);
  }

  void _applyFilters() {
    filteredReceitas =
        receitas.where((receita) {
          final nomePaciente =
              (receita['paciente']['nome'] as String).toLowerCase();
          final especialidade =
              (receita['paciente']['especialidade'] as String).toLowerCase();
          final searchTerm = searchController.text.toLowerCase();
          final filterTerm = selectedFilter.toLowerCase();

          final matchesSearch =
              searchTerm.isEmpty ||
              nomePaciente.contains(searchTerm) ||
              especialidade.contains(searchTerm);

          final matchesFilter =
              selectedFilter == 'Todas as Especialidades' ||
              especialidade.contains(filterTerm);

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

  void gerarSegundaVia(Map<String, dynamic> receita) {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.background,
        title: const Text('Segunda Via'),
        content: Text(
          'Deseja gerar uma segunda via da receita ${receita['id']}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'Cancelar',
              style: TextStyle(color: AppColors.textPrimary),
            ),
          ),
          AppButtonDefault(
            onTap: () {
              Get.back();
              _mostrarReceita(receita);
            },
            text: 'Gerar',
            width: 90,
          ),
        ],
      ),
    );
  }

  void _mostrarReceita(Map<String, dynamic> receita) {
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
              // Cabeçalho da receita
              Row(
                children: [
                  Icon(
                    Icons.medical_services,
                    color: AppColors.primaryDark,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'RECEITA MÉDICA',
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

              // Informações da receita
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipOval(
                          child: Image.network(
                            receita['paciente']['image'],
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryDark.withValues(
                                    alpha: 0.1,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.person,
                                  size: 25,
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
                                receita['paciente']['nome'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                '${receita['paciente']['idade']} anos • ${receita['paciente']['especialidade']}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Receita: ${receita['id']}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          'Data: ${_formatDate(receita['data'])}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Medicamentos
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Medicamentos',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...List<Map<String, dynamic>>.from(
                      receita['medicamentos'],
                    ).map(
                      (med) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              med['nome'],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              med['posologia'],
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Observações
              if (receita['observacoes'].isNotEmpty) ...[
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Observações',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        receita['observacoes'],
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Botões de ação
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text(
                      'Fechar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Aqui seria implementada a impressão/PDF
                      Get.snackbar(
                        'Sucesso',
                        'Receita impressa com sucesso!',
                        backgroundColor: AppColors.success,
                        colorText: Colors.white,
                      );
                    },
                    icon: const Icon(Icons.print),
                    label: const Text(
                      'Imprimir',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
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

  void showReceitaDetails(Map<String, dynamic> receita) {
    _mostrarReceita(receita);
  }

  String _formatDate(String date) {
    if (date.isEmpty) return 'N/A';
    try {
      final parts = date.split('-');
      if (parts.length == 3) {
        return '${parts[2]}/${parts[1]}/${parts[0]}';
      }
      return date;
    } catch (e) {
      return date;
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    filterController.dispose();
    super.onClose();
  }
}
