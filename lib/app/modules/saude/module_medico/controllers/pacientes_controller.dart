import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/mixins/loader_manager.dart';
import '../../../../themes/app_colors.dart';

class PacientesController extends GetxController with LoaderManager {
  final searchController = TextEditingController();
  final filterController = TextEditingController();

  List<Map<String, dynamic>> pacientes = [];
  List<Map<String, dynamic>> filteredPacientes = [];

  String selectedFilter = 'Todas as Especialidades';
  List<String> especialidades = ['Todas as Especialidades'];

  @override
  void onInit() {
    super.onInit();
    _initializePacientes();
    _applyFilters();
  }

  void _initializePacientes() {
    pacientes = [
      {
        'image':
            'https://api.dicebear.com/7.x/avataaars/svg?seed=Maria&backgroundColor=ffd5dc',
        'nome': 'Maria Silva Santos',
        'idade': 45,
        'especialidade': 'Cardiologia',
        'ultimaConsulta': '2024-01-15',
        'proximaConsulta': '2024-02-20',
        'status': 'Ativo',
        'telefone': '(11) 99999-1111',
        'email': 'maria.silva@email.com',
        'endereco': 'Rua das Flores, 123 - São Paulo/SP',
        'historico': [
          {
            'data': '2024-01-15',
            'tipo': 'Consulta',
            'descricao': 'Avaliação cardiológica de rotina',
          },
          {
            'data': '2023-12-10',
            'tipo': 'Exame',
            'descricao': 'Eletrocardiograma',
          },
          {
            'data': '2023-11-05',
            'tipo': 'Consulta',
            'descricao': 'Retorno - Ajuste de medicação',
          },
        ],
      },
      {
        'image':
            'https://api.dicebear.com/7.x/avataaars/svg?seed=Joao&backgroundColor=b6e3f4',
        'nome': 'João Carlos Oliveira',
        'idade': 62,
        'especialidade': 'Ortopedia',
        'ultimaConsulta': '2024-01-20',
        'proximaConsulta': '2024-02-25',
        'status': 'Ativo',
        'telefone': '(11) 99999-2222',
        'email': 'joao.oliveira@email.com',
        'endereco': 'Av. Paulista, 456 - São Paulo/SP',
        'historico': [
          {
            'data': '2024-01-20',
            'tipo': 'Consulta',
            'descricao': 'Avaliação pós-cirurgia do joelho',
          },
          {
            'data': '2023-12-15',
            'tipo': 'Cirurgia',
            'descricao': 'Artroscopia do joelho direito',
          },
          {
            'data': '2023-11-20',
            'tipo': 'Consulta',
            'descricao': 'Pré-operatório',
          },
        ],
      },
      {
        'image':
            'https://api.dicebear.com/7.x/avataaars/svg?seed=Ana&backgroundColor=ffdfbf',
        'nome': 'Ana Paula Costa',
        'idade': 28,
        'especialidade': 'Ginecologia',
        'ultimaConsulta': '2024-01-18',
        'proximaConsulta': '2024-03-15',
        'status': 'Ativo',
        'telefone': '(11) 99999-3333',
        'email': 'ana.costa@email.com',
        'endereco': 'Rua Augusta, 789 - São Paulo/SP',
        'historico': [
          {
            'data': '2024-01-18',
            'tipo': 'Consulta',
            'descricao': 'Consulta de rotina',
          },
          {
            'data': '2023-12-20',
            'tipo': 'Exame',
            'descricao': 'Ultrassom pélvico',
          },
          {
            'data': '2023-11-25',
            'tipo': 'Consulta',
            'descricao': 'Avaliação de exames',
          },
        ],
      },
      {
        'image':
            'https://api.dicebear.com/7.x/avataaars/svg?seed=Pedro&backgroundColor=c0aede',
        'nome': 'Pedro Henrique Lima',
        'idade': 35,
        'especialidade': 'Dermatologia',
        'ultimaConsulta': '2024-01-22',
        'proximaConsulta': '2024-02-28',
        'status': 'Ativo',
        'telefone': '(11) 99999-4444',
        'email': 'pedro.lima@email.com',
        'endereco': 'Rua Oscar Freire, 321 - São Paulo/SP',
        'historico': [
          {
            'data': '2024-01-22',
            'tipo': 'Consulta',
            'descricao': 'Avaliação de lesão cutânea',
          },
          {
            'data': '2023-12-25',
            'tipo': 'Procedimento',
            'descricao': 'Remoção de verruga',
          },
          {
            'data': '2023-11-30',
            'tipo': 'Consulta',
            'descricao': 'Primeira consulta',
          },
        ],
      },
      {
        'image':
            'https://api.dicebear.com/7.x/avataaars/svg?seed=Lucia&backgroundColor=ffd5dc',
        'nome': 'Lúcia Ferreira',
        'idade': 55,
        'especialidade': 'Endocrinologia',
        'ultimaConsulta': '2024-01-25',
        'proximaConsulta': '2024-03-10',
        'status': 'Ativo',
        'telefone': '(11) 99999-5555',
        'email': 'lucia.ferreira@email.com',
        'endereco': 'Rua Pamplona, 654 - São Paulo/SP',
        'historico': [
          {
            'data': '2024-01-25',
            'tipo': 'Consulta',
            'descricao': 'Controle de diabetes',
          },
          {
            'data': '2023-12-30',
            'tipo': 'Exame',
            'descricao': 'Hemograma completo',
          },
          {
            'data': '2023-12-05',
            'tipo': 'Consulta',
            'descricao': 'Ajuste de insulina',
          },
        ],
      },
      {
        'image':
            'https://api.dicebear.com/7.x/avataaars/svg?seed=Roberto&backgroundColor=b6e3f4',
        'nome': 'Roberto Almeida',
        'idade': 40,
        'especialidade': 'Neurologia',
        'ultimaConsulta': '2024-01-28',
        'proximaConsulta': '2024-03-05',
        'status': 'Ativo',
        'telefone': '(11) 99999-6666',
        'email': 'roberto.almeida@email.com',
        'endereco': 'Av. Brigadeiro Faria Lima, 987 - São Paulo/SP',
        'historico': [
          {
            'data': '2024-01-28',
            'tipo': 'Consulta',
            'descricao': 'Avaliação de cefaleia',
          },
          {
            'data': '2024-01-10',
            'tipo': 'Exame',
            'descricao': 'Ressonância magnética',
          },
          {
            'data': '2023-12-15',
            'tipo': 'Consulta',
            'descricao': 'Primeira consulta',
          },
        ],
      },
    ];

    // Extrair especialidades únicas
    final especialidadesUnicas =
        pacientes
            .map((paciente) => paciente['especialidade'] as String)
            .toSet()
            .toList();
    especialidades.addAll(especialidadesUnicas);
  }

  void _applyFilters() {
    filteredPacientes =
        pacientes.where((paciente) {
          final nome = (paciente['nome'] as String).toLowerCase();
          final especialidade =
              (paciente['especialidade'] as String).toLowerCase();
          final searchTerm = searchController.text.toLowerCase();
          final filterTerm = selectedFilter.toLowerCase();

          final matchesSearch =
              searchTerm.isEmpty ||
              nome.contains(searchTerm) ||
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

  void showPacienteDetails(Map<String, dynamic> paciente) {
    final String image = paciente['image'];
    final String nome = paciente['nome'];
    final int idade = paciente['idade'];
    final String especialidade = paciente['especialidade'];
    final String ultimaConsulta = paciente['ultimaConsulta'];
    final String proximaConsulta = paciente['proximaConsulta'];
    final String status = paciente['status'];
    final String telefone = paciente['telefone'];
    final String email = paciente['email'];
    final String endereco = paciente['endereco'];
    final List<Map<String, dynamic>> historico =
        List<Map<String, dynamic>>.from(paciente['historico']);

    Get.dialog(
      Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600, maxHeight: 700),
          child: Container(
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
                      'Detalhes do Paciente',
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

                // Conteúdo scrollável
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Informações básicas
                        Row(
                          children: [
                            ClipOval(
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
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '$idade anos • $especialidade',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.textSecondary,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          status == 'Ativo'
                                              ? AppColors.success.withValues(
                                                alpha: 0.1,
                                              )
                                              : AppColors.error.withValues(
                                                alpha: 0.1,
                                              ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      status,
                                      style: TextStyle(
                                        color:
                                            status == 'Ativo'
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

                        // Informações de contato
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
                                'Informações de Contato',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 12),
                              _buildContactRow(
                                Icons.phone,
                                'Telefone',
                                telefone,
                              ),
                              const SizedBox(height: 8),
                              _buildContactRow(Icons.email, 'Email', email),
                              const SizedBox(height: 8),
                              _buildContactRow(
                                Icons.location_on,
                                'Endereço',
                                endereco,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Próximas consultas
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
                                'Consultas',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 12),
                              _buildContactRow(
                                Icons.calendar_today,
                                'Última Consulta',
                                ultimaConsulta,
                              ),
                              const SizedBox(height: 8),
                              _buildContactRow(
                                Icons.event,
                                'Próxima Consulta',
                                proximaConsulta,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Histórico médico
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
                                'Histórico Médico',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 12),
                              ...historico.map(
                                (item) => Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: AppColors.background,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getTipoColor(
                                            item['tipo'],
                                          ).withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Text(
                                          item['tipo'],
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: _getTipoColor(item['tipo']),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item['data'],
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: AppColors.textSecondary,
                                              ),
                                            ),
                                            Text(
                                              item['descricao'],
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: AppColors.textPrimary,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getTipoColor(String tipo) {
    switch (tipo) {
      case 'Consulta':
        return AppColors.primaryDark;
      case 'Exame':
        return AppColors.success;
      case 'Cirurgia':
        return AppColors.error;
      case 'Procedimento':
        return Colors.orange;
      default:
        return AppColors.textSecondary;
    }
  }

  Widget _buildContactRow(IconData icon, String label, String value) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: AppColors.textSecondary),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              '$label: ',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 14, color: AppColors.textPrimary),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void onClose() {
    searchController.dispose();
    filterController.dispose();
    super.onClose();
  }
}
