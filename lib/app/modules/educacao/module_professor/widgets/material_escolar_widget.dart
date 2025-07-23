import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minha_gestao_inteligente_painel/app/shared/widgets/app_button_default.dart';
import 'package:minha_gestao_inteligente_painel/app/themes/app_colors.dart';

import '../controllers/material_escolar_controller.dart';

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
    final String titulo = materialData['titulo'] ?? '';
    final String descricao = materialData['descricao'] ?? '';
    final String disciplina = materialData['disciplina'] ?? '';
    final String categoria = materialData['categoria'] ?? '';
    final String tamanho = materialData['tamanho'] ?? '';
    final int downloads = materialData['downloads'] ?? 0;
    final int visualizacoes = materialData['visualizacoes'] ?? 0;
    final Color cor = materialData['cor'] ?? Colors.grey;

    final controller = Get.find<MaterialEscolarController>();

    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 320,
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
                      color: cor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getCategoriaIcon(categoria),
                      color: cor,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          titulo,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          disciplina,
                          style: TextStyle(
                            fontSize: 12,
                            color: cor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Descrição
              Text(
                descricao,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 12),

              // Informações do material
              Card(
                color: AppColors.card,
                elevation: 1.5,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Categoria:',
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
                              color: cor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              categoria,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.storage,
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            tamanho,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: AppButtonDefault(
                      onTap: () => controller.visualizarPDF(materialData),
                      text: 'Abrir PDF',
                      paddingVertical: 4,
                      borderColor: AppColors.primaryDark,
                      textColor: AppColors.primaryDark,
                      buttonColor: AppColors.card,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: AppButtonDefault(
                      onTap: () => controller.baixarMaterial(materialData),
                      text: 'Baixar',
                      buttonColor: AppColors.primaryDark,
                      paddingVertical: 4,
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
}
