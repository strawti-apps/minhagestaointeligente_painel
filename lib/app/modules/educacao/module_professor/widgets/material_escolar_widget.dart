import 'package:flutter/material.dart';
import 'package:minha_gestao_inteligente_painel/app/themes/app_colors.dart';

class MaterialEscolarWidget extends StatelessWidget {
  final Map<String, dynamic> materialData;
  final VoidCallback? onTap;

  const MaterialEscolarWidget({
    super.key,
    required this.materialData,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final String nome = materialData['nome'] ?? '';
    final int quantidade = materialData['quantidade'] ?? 0;
    final String categoria = materialData['categoria'] ?? '';
    final String fornecedor = materialData['fornecedor'] ?? '';

    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 280,
          color: AppColors.background,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabeçalho do material
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.textSecondary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getMaterialIcon(nome),
                      color: AppColors.textPrimary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nome,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          categoria,
                          style: TextStyle(
                            fontSize: 12,
                            color: _getCategoriaColor(categoria),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Informações do material
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Quantidade:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getQuantidadeColor(quantidade),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            quantidade.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.business,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            fornecedor,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Status do estoque
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _getStatusColor(quantidade).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: _getStatusColor(quantidade).withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      _getStatusIcon(quantidade),
                      size: 16,
                      color: _getStatusColor(quantidade),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _getStatusText(quantidade),
                        style: TextStyle(
                          fontSize: 12,
                          color: _getStatusColor(quantidade),
                          fontWeight: FontWeight.w500,
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
}
