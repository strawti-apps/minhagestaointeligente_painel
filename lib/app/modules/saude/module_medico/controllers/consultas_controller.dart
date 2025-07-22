import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/mixins/loader_manager.dart';
import '../../../../themes/app_colors.dart';

class ConsultasController extends GetxController with LoaderManager {
  final searchController = TextEditingController();
  final filterController = TextEditingController();

  List<Map<String, dynamic>> consultas = [];
  List<Map<String, dynamic>> filteredConsultas = [];

  String selectedFilter = 'Todas as Especialidades';
  List<String> especialidades = ['Todas as Especialidades'];

  @override
  void onInit() {
    super.onInit();
    _initializeConsultas();
    _applyFilters();
  }

  void _initializeConsultas() {
    consultas = [
      {
        'id': 'CON001',
        'data': '2024-01-15',
        'hora': '14:00',
        'tipo': 'Consulta de Rotina',
        'status': 'Realizada',
        'paciente': {
          'nome': 'Maria Silva Santos',
          'image': '',
          'idade': 45,
          'especialidade': 'Cardiologia',
        },
        'anamnese': {
          'queixaPrincipal': 'Dor no peito há 3 dias',
          'historiaAtual':
              'Paciente relata dor em aperto no peito, irradiando para braço esquerdo',
          'antecedentes': 'Hipertensão arterial, diabetes tipo 2',
          'medicamentos': 'Atenolol 50mg, Metformina 850mg',
          'exameFisico': 'PA: 140/90 mmHg, FC: 88 bpm, Sat: 98%',
          'hipoteseDiagnostica': 'Angina pectoris',
          'conduta': 'Solicitar eletrocardiograma e enzimas cardíacas',
        },
        'prontuario': [
          {
            'data': '2024-01-15',
            'tipo': 'Consulta',
            'descricao': 'Avaliação cardiológica',
          },
          {
            'data': '2023-12-10',
            'tipo': 'Exame',
            'descricao': 'Eletrocardiograma normal',
          },
          {
            'data': '2023-11-05',
            'tipo': 'Consulta',
            'descricao': 'Retorno - Ajuste de medicação',
          },
        ],
      },
      {
        'id': 'CON002',
        'data': '2024-01-20',
        'hora': '09:30',
        'tipo': 'Retorno',
        'status': 'Agendada',
        'paciente': {
          'nome': 'João Carlos Oliveira',
          'idade': 62,
          'especialidade': 'Ortopedia',
          'image':
              'https://st2.depositphotos.com/1075946/7097/i/600/depositphotos_70978195-stock-photo-attractive-50-year-old-man.jpg',
        },
        'anamnese': {
          'queixaPrincipal': 'Avaliação pós-cirurgia do joelho',
          'historiaAtual':
              'Paciente operado há 2 semanas, evolução satisfatória',
          'antecedentes': 'Artrose do joelho direito',
          'medicamentos': 'Dipirona 500mg, Ibuprofeno 600mg',
          'exameFisico':
              'Cicatriz operatória bem cicatrizada, amplitude de movimento preservada',
          'hipoteseDiagnostica': 'Pós-operatório de artroscopia',
          'conduta': 'Manter fisioterapia e retorno em 30 dias',
        },
        'prontuario': [
          {
            'data': '2024-01-20',
            'tipo': 'Consulta',
            'descricao': 'Retorno pós-operatório',
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
        'id': 'CON003',
        'data': '2024-01-18',
        'hora': '16:00',
        'tipo': 'Primeira Consulta',
        'status': 'Realizada',
        'paciente': {
          'nome': 'Ana Paula Costa',
          'idade': 28,
          'especialidade': 'Ginecologia',
          'image':
              'https://tse3.mm.bing.net/th/id/OIP.aJ4VKK2ohav-CmqsHPcq-wAAAA?rs=1&pid=ImgDetMain&o=7&rm=3',
        },
        'anamnese': {
          'queixaPrincipal': 'Consulta de rotina',
          'historiaAtual':
              'Paciente assintomática, busca orientação sobre planejamento familiar',
          'antecedentes': 'Sem antecedentes patológicos',
          'medicamentos': 'Nenhum',
          'exameFisico': 'Exame ginecológico normal',
          'hipoteseDiagnostica': 'Paciente saudável',
          'conduta':
              'Solicitar exames de rotina e orientar sobre métodos contraceptivos',
        },
        'prontuario': [
          {
            'data': '2024-01-18',
            'tipo': 'Consulta',
            'descricao': 'Primeira consulta ginecológica',
          },
          {
            'data': '2023-12-20',
            'tipo': 'Exame',
            'descricao': 'Ultrassom pélvico normal',
          },
        ],
      },
      {
        'id': 'CON004',
        'data': '2024-01-22',
        'hora': '11:00',
        'tipo': 'Consulta de Urgência',
        'status': 'Realizada',
        'paciente': {
          'nome': 'Pedro Henrique Lima',
          'idade': 35,
          'especialidade': 'Dermatologia',
          'image':
              'https://cdn.folhape.com.br/upload/dn_arquivo/2023/10/priscila-enquadramento-capa_2.jpg',
        },
        'anamnese': {
          'queixaPrincipal': 'Lesão cutânea no braço direito',
          'historiaAtual':
              'Paciente relata aparecimento de lesão há 1 semana, com prurido',
          'antecedentes': 'Sem antecedentes dermatológicos',
          'medicamentos': 'Nenhum',
          'exameFisico': 'Lesão eritematosa, descamativa, bem delimitada',
          'hipoteseDiagnostica': 'Dermatite de contato',
          'conduta': 'Prescrever corticóide tópico e orientar sobre cuidados',
        },
        'prontuario': [
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
        ],
      },
      {
        'id': 'CON005',
        'data': '2024-01-25',
        'hora': '15:30',
        'tipo': 'Retorno',
        'status': 'Agendada',
        'paciente': {
          'nome': 'Lúcia Ferreira',
          'idade': 55,
          'especialidade': 'Endocrinologia',
          'image':
              'https://tse2.mm.bing.net/th/id/OIP.1Qu77Ol87z6l-UWtYN73owAAAA?rs=1&pid=ImgDetMain&o=7&rm=3',
        },
        'anamnese': {
          'queixaPrincipal': 'Controle de diabetes',
          'historiaAtual':
              'Paciente com diabetes tipo 2, glicemias controladas',
          'antecedentes': 'Diabetes tipo 2, hipertensão arterial',
          'medicamentos': 'Metformina 850mg, Glicazida 80mg',
          'exameFisico': 'PA: 130/85 mmHg, peso: 68kg, altura: 1.65m',
          'hipoteseDiagnostica': 'Diabetes tipo 2 controlada',
          'conduta': 'Manter medicação atual e retorno em 3 meses',
        },
        'prontuario': [
          {
            'data': '2024-01-25',
            'tipo': 'Consulta',
            'descricao': 'Controle de diabetes',
          },
          {
            'data': '2023-12-30',
            'tipo': 'Exame',
            'descricao': 'Hemograma normal',
          },
          {
            'data': '2023-12-05',
            'tipo': 'Consulta',
            'descricao': 'Ajuste de insulina',
          },
        ],
      },
    ];

    // Extrair especialidades únicas
    final especialidadesUnicas =
        consultas
            .map((consulta) => consulta['paciente']['especialidade'] as String)
            .toSet()
            .toList();
    especialidades.addAll(especialidadesUnicas);
  }

  void _applyFilters() {
    filteredConsultas =
        consultas.where((consulta) {
          final nomePaciente =
              (consulta['paciente']['nome'] as String).toLowerCase();
          final especialidade =
              (consulta['paciente']['especialidade'] as String).toLowerCase();
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

  void showConsultaDetails(Map<String, dynamic> consulta) {
    final String id = consulta['id'];
    final String data = consulta['data'];
    final String hora = consulta['hora'];
    final String tipo = consulta['tipo'];
    final String status = consulta['status'];
    final Map<String, dynamic> paciente = consulta['paciente'];
    final Map<String, dynamic> anamnese = consulta['anamnese'];
    final List<Map<String, dynamic>> prontuario =
        List<Map<String, dynamic>>.from(consulta['prontuario']);

    Get.dialog(
      Dialog(
        child: Container(
          width: 800,
          height: 600,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Cabeçalho
              Row(
                children: [
                  Icon(
                    Icons.medical_services,
                    color: AppColors.primaryDark,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Detalhes da Consulta',
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

              // Informações da consulta
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    ClipOval(
                      child: Image.network(
                        paciente['image'],
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: AppColors.primaryDark.withValues(
                                alpha: 0.1,
                              ),
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
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            paciente['nome'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            '${paciente['idade']} anos • ${paciente['especialidade']}',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Consulta $id',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          '${_formatDate(data)} às $hora',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color:
                                status == 'Realizada'
                                    ? AppColors.success.withValues(alpha: 0.1)
                                    : AppColors.primaryDark.withValues(
                                      alpha: 0.1,
                                    ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            status,
                            style: TextStyle(
                              color:
                                  status == 'Realizada'
                                      ? AppColors.success
                                      : AppColors.primaryDark,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.card,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const TabBar(
                          tabs: [
                            Tab(text: 'Anamnese'),
                            Tab(text: 'Prontuário'),
                          ],
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: TabBarView(
                          children: [
                            // Tab Anamnese
                            _buildAnamneseTab(anamnese),
                            // Tab Prontuário
                            _buildProntuarioTab(prontuario),
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
    );
  }

  Widget _buildAnamneseTab(Map<String, dynamic> anamnese) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildAnamneseSection(
            'Queixa Principal',
            anamnese['queixaPrincipal'],
          ),
          _buildAnamneseSection('História Atual', anamnese['historiaAtual']),
          _buildAnamneseSection('Antecedentes', anamnese['antecedentes']),
          _buildAnamneseSection('Medicamentos', anamnese['medicamentos']),
          _buildAnamneseSection('Exame Físico', anamnese['exameFisico']),
          _buildAnamneseSection(
            'Hipótese Diagnóstica',
            anamnese['hipoteseDiagnostica'],
          ),
          _buildAnamneseSection('Conduta', anamnese['conduta']),
        ],
      ),
    );
  }

  Widget _buildAnamneseSection(String title, String content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildProntuarioTab(List<Map<String, dynamic>> prontuario) {
    return ListView.builder(
      itemCount: prontuario.length,
      itemBuilder: (context, index) {
        final item = prontuario[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getTipoColor(item['tipo']).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
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
