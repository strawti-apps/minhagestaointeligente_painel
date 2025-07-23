import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../themes/app_colors.dart';

class MaterialEscolarController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredMateriais = [];
  String _currentFilter = 'todos';
  String _searchQuery = '';

  List<Map<String, dynamic>> get filteredMateriais => _filteredMateriais;

  final materiais = [
    {
      'id': 1,
      'titulo': 'Apostila de Matemática - Álgebra',
      'descricao':
          'Material completo sobre equações do primeiro e segundo grau',
      'disciplina': 'Matemática',
      'categoria': 'Apostila',
      'tamanho': '2.5 MB',
      'dataCriacao': '2024-01-15',
      'downloads': 45,
      'visualizacoes': 120,
      'arquivo': 'apostila_algebra.pdf',
      'url':
          'https://drive.google.com/file/d/1uafLai-BVA58iHosDT6xyWLZ-KbOwtXo/view',
      'cor': Colors.blue,
    },
    {
      'id': 2,
      'titulo': 'Exercícios de Física - Mecânica',
      'descricao': 'Lista de exercícios sobre movimento uniforme e acelerado',
      'disciplina': 'Física',
      'categoria': 'Exercícios',
      'tamanho': '1.8 MB',
      'dataCriacao': '2024-01-20',
      'downloads': 38,
      'visualizacoes': 95,
      'arquivo': 'exercicios_mecanica.pdf',
      'url':
          'https://fisicacrns.files.wordpress.com/2015/05/movimento_uniformemente_variado_muv.pdf',
      'cor': Colors.red,
    },
    {
      'id': 3,
      'titulo': 'Resumo de História - Brasil Colonial',
      'descricao': 'Resumo dos principais acontecimentos do período colonial',
      'disciplina': 'História',
      'categoria': 'Resumo',
      'tamanho': '1.2 MB',
      'dataCriacao': '2024-01-18',
      'downloads': 52,
      'visualizacoes': 140,
      'arquivo': 'resumo_brasil_colonial.pdf',
      'url':
          'https://efabiopablo.files.wordpress.com/2014/05/resumo-brasil-colc3b4nia.pdf',
      'cor': Colors.orange,
    },
    {
      'id': 4,
      'titulo': 'Slides de Biologia - Células',
      'descricao': 'Apresentação sobre estrutura e função das células',
      'disciplina': 'Biologia',
      'categoria': 'Apresentação',
      'tamanho': '3.1 MB',
      'dataCriacao': '2024-01-22',
      'downloads': 41,
      'visualizacoes': 110,
      'arquivo': 'slides_celulas.pdf',
      'url':
          'https://www.colegioequipejf.com.br/site/uploads/arquivos_conteudo_aluno/1344/1587721118bsrFIfSx.pdf',
      'cor': Colors.green,
    },
    {
      'id': 5,
      'titulo': 'Prova de Literatura - Modernismo',
      'descricao': 'Avaliação sobre o movimento modernista brasileiro',
      'disciplina': 'Literatura',
      'categoria': 'Avaliação',
      'tamanho': '0.9 MB',
      'dataCriacao': '2024-01-25',
      'downloads': 35,
      'visualizacoes': 85,
      'arquivo': 'prova_modernismo.pdf',
      'url':
          'https://loucosaber.wordpress.com/wp-content/uploads/2015/12/exercicios_modernismo_literatura.pdf',
      'cor': Colors.purple,
    },
    {
      'id': 7,
      'titulo': 'Lista de Vocabulário - Inglês',
      'descricao': 'Vocabulário sobre família e profissões em inglês',
      'disciplina': 'Inglês',
      'categoria': 'Vocabulário',
      'tamanho': '0.7 MB',
      'dataCriacao': '2024-01-19',
      'downloads': 55,
      'visualizacoes': 150,
      'arquivo': 'vocabulario_familia.pdf',
      'url':
          'https://drive.google.com/file/d/1qh9U2WkgO_1bqehVPmyjUb0O22IK_5er/view',
      'cor': Colors.indigo,
    },
    {
      'id': 8,
      'titulo': 'Experimento de Química - Reações',
      'descricao': 'Guia prático para experimentos de reações químicas',
      'disciplina': 'Química',
      'categoria': 'Experimento',
      'tamanho': '2.8 MB',
      'dataCriacao': '2024-01-21',
      'downloads': 32,
      'visualizacoes': 75,
      'arquivo': 'experimento_reacoes.pdf',
      'url':
          'https://caxias.ifma.edu.br/wp-content/uploads/sites/27/2018/08/Apostila-QUIM_GERAL_EXP-I_v1.pdf',
      'cor': Colors.cyan,
    },
    {
      'id': 9,
      'titulo': 'Redação - Técnicas de Argumentação',
      'descricao': 'Material sobre como construir argumentos na redação',
      'disciplina': 'Português',
      'categoria': 'Técnica',
      'tamanho': '1.9 MB',
      'dataCriacao': '2024-01-17',
      'downloads': 60,
      'visualizacoes': 180,
      'arquivo': 'tecnicas_argumentacao.pdf',
      'url':
          'https://educapes.capes.gov.br/bitstream/capes/747970/2/A%20reda%c3%a7%c3%a3o%20do%20Enem%20em%20sala%20de%20aula.pdf',
      'cor': Colors.brown,
    },
    {
      'id': 10,
      'titulo': 'Fórmulas de Matemática - Trigonometria',
      'descricao': 'Compilação de fórmulas trigonométricas essenciais',
      'disciplina': 'Matemática',
      'categoria': 'Fórmulas',
      'tamanho': '1.1 MB',
      'dataCriacao': '2024-01-23',
      'downloads': 70,
      'visualizacoes': 200,
      'arquivo': 'formulas_trigonometria.pdf',
      'url': 'https://midia.atp.usp.br/plc/plc0001/impressos/plc0001_09.pdf',
      'cor': Colors.blue,
    },
  ];

  @override
  void onInit() {
    super.onInit();
    _filteredMateriais = List.from(materiais);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  /// Buscar materiais por título ou disciplina
  void searchMateriais(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilters();
  }

  /// Filtrar materiais por categoria
  void filterByCategoria(String filter) {
    _currentFilter = filter;
    _applyFilters();
  }

  /// Aplicar filtros de busca e categoria
  void _applyFilters() {
    _filteredMateriais =
        materiais.where((material) {
          final titulo = material['titulo'].toString().toLowerCase();
          final disciplina = material['disciplina'].toString().toLowerCase();
          final categoria = material['categoria'].toString().toLowerCase();

          // Aplicar filtro de busca
          final matchesSearch =
              _searchQuery.isEmpty ||
              titulo.contains(_searchQuery) ||
              disciplina.contains(_searchQuery);

          // Aplicar filtro de categoria
          bool matchesFilter = true;
          if (_currentFilter != 'todos') {
            matchesFilter = categoria == _currentFilter.toLowerCase();
          }

          return matchesSearch && matchesFilter;
        }).toList();

    update();
  }

  /// Visualizar PDF do material
  void visualizarPDF(Map<String, dynamic> material) async {
    final String titulo = material['titulo'];
    final String url = material['url'];

    try {
      // Incrementar contador de visualizações
      material['visualizacoes'] = (material['visualizacoes'] ?? 0) + 1;
      update();

      // Abrir PDF em nova aba
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        Get.snackbar(
          'PDF Aberto',
          'Visualizando $titulo em nova aba...',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue.withValues(alpha: 0.1),
          colorText: Colors.blue,
        );
      } else {
        Get.snackbar(
          'Erro',
          'Não foi possível abrir o PDF',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withValues(alpha: 0.1),
          colorText: Colors.red,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Erro',
        'Erro ao abrir o PDF: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.1),
        colorText: Colors.red,
      );
    }
  }

  /// Baixar material
  void baixarMaterial(Map<String, dynamic> material) async {
    final String titulo = material['titulo'];
    final String url = material['url'];
    final String arquivo = material['arquivo'];

    try {
      // Incrementar contador de downloads
      material['downloads'] = (material['downloads'] ?? 0) + 1;
      update();

      // Abrir URL diretamente para download
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        Get.snackbar(
          'Download Iniciado',
          'Baixando $titulo...',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withValues(alpha: 0.1),
          colorText: Colors.green,
        );
      } else {
        Get.snackbar(
          'Erro',
          'Não foi possível baixar o arquivo',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withValues(alpha: 0.1),
          colorText: Colors.red,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Erro',
        'Erro ao baixar o arquivo: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.1),
        colorText: Colors.red,
      );
    }
  }

  /// Mostrar detalhes do material
  void showMaterialDetails(Map<String, dynamic> material) {
    final String titulo = material['titulo'];
    final String descricao = material['descricao'];
    final String disciplina = material['disciplina'];
    final String categoria = material['categoria'];
    final String tamanho = material['tamanho'];
    final String dataCriacao = material['dataCriacao'];
    final int downloads = material['downloads'] ?? 0;
    final int visualizacoes = material['visualizacoes'] ?? 0;
    final Color cor = material['cor'] ?? Colors.grey;

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
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: cor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _getCategoriaIcon(categoria),
                      color: cor,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          titulo,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          disciplina,
                          style: TextStyle(
                            fontSize: 16,
                            color: cor,
                            fontWeight: FontWeight.w500,
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

              const SizedBox(height: 16),

              // Descrição
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Descrição:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      descricao,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

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
                      label: 'Categoria:',
                      value: categoria,
                      icon: Icons.category,
                    ),
                    const SizedBox(height: 12),
                    _DetailRow(
                      label: 'Tamanho:',
                      value: tamanho,
                      icon: Icons.storage,
                    ),
                    const SizedBox(height: 12),
                    _DetailRow(
                      label: 'Data de Criação:',
                      value: _formatDate(dataCriacao),
                      icon: Icons.calendar_today,
                    ),
                    const SizedBox(height: 12),
                    _DetailRow(
                      label: 'Downloads:',
                      value: downloads.toString(),
                      icon: Icons.download,
                      valueColor: Colors.green,
                    ),
                    const SizedBox(height: 12),
                    _DetailRow(
                      label: 'Visualizações:',
                      value: visualizacoes.toString(),
                      icon: Icons.visibility,
                      valueColor: Colors.blue,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

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
                    onPressed: () => visualizarPDF(material),
                    icon: const Icon(Icons.visibility),
                    label: const Text('Visualizar PDF'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () => baixarMaterial(material),
                    icon: const Icon(Icons.download),
                    label: const Text('Baixar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
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

  IconData _getCategoriaIcon(String categoria) {
    switch (categoria.toLowerCase()) {
      case 'apostila':
        return Icons.book;
      case 'exercícios':
      case 'exercicios':
        return Icons.assignment;
      case 'resumo':
        return Icons.summarize;
      case 'apresentação':
      case 'apresentacao':
        return Icons.slideshow;
      case 'avaliação':
      case 'avaliacao':
        return Icons.quiz;
      case 'mapa mental':
        return Icons.psychology;
      case 'vocabulário':
      case 'vocabulario':
        return Icons.translate;
      case 'experimento':
        return Icons.science;
      case 'técnica':
      case 'tecnica':
        return Icons.tips_and_updates;
      case 'fórmulas':
      case 'formulas':
        return Icons.functions;
      default:
        return Icons.school;
    }
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    } catch (e) {
      return dateString;
    }
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
