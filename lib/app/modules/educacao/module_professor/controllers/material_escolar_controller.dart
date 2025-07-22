import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../themes/app_colors.dart';

class MaterialEscolarController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredMateriais = [];
  String _currentFilter = 'todos';
  String _searchQuery = '';

  List<Map<String, dynamic>> get filteredMateriais => _filteredMateriais;

  final materiais = [
    {
      'nome': 'Caderno',
      'quantidade': 30,
      'categoria': 'Papelaria',
      'fornecedor': 'Papel&Arte',
    },
    {
      'nome': 'Lápis',
      'quantidade': 50,
      'categoria': 'Papelaria',
      'fornecedor': 'EscritaFácil',
    },
    {
      'nome': 'Borracha',
      'quantidade': 25,
      'categoria': 'Papelaria',
      'fornecedor': 'Apagão',
    },
    {
      'nome': 'Caneta Azul',
      'quantidade': 40,
      'categoria': 'Papelaria',
      'fornecedor': 'EscritaFácil',
    },
    {
      'nome': 'Régua 30cm',
      'quantidade': 15,
      'categoria': 'Papelaria',
      'fornecedor': 'MedirMais',
    },
    {
      'nome': 'Cola Branca',
      'quantidade': 20,
      'categoria': 'Artes',
      'fornecedor': 'FixTudo',
    },
    {
      'nome': 'Tesoura Escolar',
      'quantidade': 12,
      'categoria': 'Artes',
      'fornecedor': 'CortaCerto',
    },
    {
      'nome': 'Apontador',
      'quantidade': 35,
      'categoria': 'Papelaria',
      'fornecedor': 'ApontaBem',
    },
    {
      'nome': 'Papel Sulfite A4',
      'quantidade': 1000,
      'categoria': 'Escritório',
      'fornecedor': 'OfficeMaster',
    },
    {
      'nome': 'Giz de Cera',
      'quantidade': 18,
      'categoria': 'Artes',
      'fornecedor': 'Colorir+Mais',
    },
    {
      'nome': 'Marcador Quadro Branco',
      'quantidade': 25,
      'categoria': 'Escritório',
      'fornecedor': 'QuadroShow',
    },
    {
      'nome': 'Cartolina Colorida',
      'quantidade': 60,
      'categoria': 'Artes',
      'fornecedor': 'CriArte',
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

  /// Buscar materiais por nome
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
          final nome = material['nome'].toString().toLowerCase();
          final categoria = material['categoria'].toString().toLowerCase();

          // Aplicar filtro de busca
          final matchesSearch =
              _searchQuery.isEmpty || nome.contains(_searchQuery);

          // Aplicar filtro de categoria
          bool matchesFilter = true;
          if (_currentFilter != 'todos') {
            matchesFilter = categoria == _currentFilter.toLowerCase();
          }

          return matchesSearch && matchesFilter;
        }).toList();

    update();
  }

  /// Mostrar detalhes do material
  void showMaterialDetails(Map<String, dynamic> material) {
    final String nome = material['nome'];
    final int quantidade = material['quantidade'];
    final String categoria = material['categoria'];
    final String fornecedor = material['fornecedor'];

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabeçalho
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _getCategoriaColor(
                        categoria,
                      ).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _getMaterialIcon(nome),
                      color: _getCategoriaColor(categoria),
                      size: 32,
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
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          categoria,
                          style: TextStyle(
                            fontSize: 16,
                            color: _getCategoriaColor(categoria),
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
                      label: 'Quantidade em Estoque:',
                      value: quantidade.toString(),
                      icon: Icons.inventory,
                      valueColor: _getQuantidadeColor(quantidade),
                    ),
                    const SizedBox(height: 12),
                    _DetailRow(
                      label: 'Fornecedor:',
                      value: fornecedor,
                      icon: Icons.business,
                    ),
                    const SizedBox(height: 12),
                    _DetailRow(
                      label: 'Status do Estoque:',
                      value: _getStatusText(quantidade),
                      icon: _getStatusIcon(quantidade),
                      valueColor: _getStatusColor(quantidade),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Recomendações
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _getStatusColor(quantidade).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _getStatusColor(quantidade).withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: _getStatusColor(quantidade),
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _getRecomendacao(quantidade),
                        style: TextStyle(
                          fontSize: 14,
                          color: _getStatusColor(quantidade),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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
                    onPressed: () {
                      // Aqui você pode implementar a funcionalidade de pedido
                      Get.snackbar(
                        'Sucesso',
                        'Pedido de reposição enviado!',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                    icon: const Icon(Icons.shopping_cart),
                    label: const Text(
                      'Fazer Pedido',
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

  IconData _getMaterialIcon(String nome) {
    final nomeLower = nome.toLowerCase();

    if (nomeLower.contains('caderno')) return Icons.book;
    if (nomeLower.contains('lápis') || nomeLower.contains('lapis'))
      return Icons.edit;
    if (nomeLower.contains('borracha')) return Icons.auto_fix_high;
    if (nomeLower.contains('caneta')) return Icons.edit_note;
    if (nomeLower.contains('régua') || nomeLower.contains('regua'))
      return Icons.straighten;
    if (nomeLower.contains('cola')) return Icons.attach_file;
    if (nomeLower.contains('tesoura')) return Icons.content_cut;
    if (nomeLower.contains('apontador')) return Icons.create;
    if (nomeLower.contains('papel')) return Icons.description;
    if (nomeLower.contains('giz')) return Icons.brush;
    if (nomeLower.contains('marcador')) return Icons.highlight;
    if (nomeLower.contains('cartolina')) return Icons.art_track;

    return Icons.school;
  }

  Color _getCategoriaColor(String categoria) {
    switch (categoria.toLowerCase()) {
      case 'papelaria':
        return Colors.blue;
      case 'artes':
        return Colors.purple;
      case 'escritório':
      case 'escritorio':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Color _getQuantidadeColor(int quantidade) {
    if (quantidade >= 50) return Colors.green;
    if (quantidade >= 20) return Colors.orange;
    if (quantidade >= 10) return Colors.blue;
    return Colors.red;
  }

  Color _getStatusColor(int quantidade) {
    if (quantidade >= 50) return Colors.green;
    if (quantidade >= 20) return Colors.orange;
    if (quantidade >= 10) return Colors.blue;
    return Colors.red;
  }

  IconData _getStatusIcon(int quantidade) {
    if (quantidade >= 50) return Icons.check_circle;
    if (quantidade >= 20) return Icons.warning;
    if (quantidade >= 10) return Icons.info;
    return Icons.error;
  }

  String _getStatusText(int quantidade) {
    if (quantidade >= 50) return 'Estoque alto';
    if (quantidade >= 20) return 'Estoque adequado';
    if (quantidade >= 10) return 'Estoque baixo';
    return 'Estoque crítico';
  }

  String _getRecomendacao(int quantidade) {
    if (quantidade >= 50)
      return 'Estoque em excelente estado. Não é necessário fazer pedido.';
    if (quantidade >= 20)
      return 'Estoque adequado. Considere fazer pedido em breve.';
    if (quantidade >= 10) return 'Estoque baixo. Recomenda-se fazer pedido.';
    return 'Estoque crítico! Faça pedido imediatamente.';
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
